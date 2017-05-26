From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [RFC] Exclusive gpu access for SteamVR usecases
Date: Fri, 26 May 2017 21:24:13 +0200
Message-ID: <195df57c-28ed-e97e-5201-a9d98d83b0bb@vodafone.de>
References: <20170525000101.8184-1-andresx7@gmail.com>
 <20E73ED4-5A64-45A5-A609-77F91CAB8425@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0457123253=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20E73ED4-5A64-45A5-A609-77F91CAB8425-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0457123253==
Content-Type: multipart/alternative;
 boundary="------------075E90BA1B8AAEEE1EB8D1D9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------075E90BA1B8AAEEE1EB8D1D9
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

the idea is that the compositor (which is DRM master) can change the 
priority of it's clients.

So using dev->fd is pointless because that is the fd of the DRM master 
process.

Regards,
Christian.

Am 26.05.2017 um 11:02 schrieb Mao, David:
> Hi Andres,
> Why the fd is needed for this interface?
> Why not just using the dev->fd instead of fd?
> IIRC, if there are more than one fds opened in the process upon the 
> same device, they will share the same amdgpu_device_handle which is 
> guaranteed by amdgpu_device_initialize.
> In other word, we should not run into the case that user creates more 
> contexts with newly opened fd after tuning the priority of existing 
> context in the same process unless the previous fd is closed.
>
> Thanks.
> Best Regards,
> David
>
>> On 25 May 2017, at 8:00 AM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
>> <mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>
>> When multiple environments are running simultaneously on a system, e.g.
>> an X desktop + a SteamVR game session, it may be useful to sacrifice
>> performance in one environment in order to boost it on the other.
>>
>> This series provides a mechanism for a DRM_MASTER to provide exclusive
>> gpu access to a group of processes.
>>
>> Note: This series is built on the assumption that the drm lease patch 
>> series
>> will extend DRM_MASTER status to lesees.
>>
>> The libdrm we intend to provide is as follows:
>>
>> /**
>> * Set the priority of all contexts in a process
>> *
>> * This function will change the priority of all contexts owned by
>> * the process identified by fd.
>> *
>> * \param dev             - \c [in] device handle
>> * \param fd              - \c [in] fd from target process
>> * \param priority        - \c [in] target priority AMDGPU_CTX_PRIORITY_*
>> *
>> * \return  0 on success\n
>> *         <0 - Negative POSIX error code
>> *
>> * \notes @fd can be *any* file descriptor from the target process.
>> * \notes this function requires DRM_MASTER
>> */
>> int amdgpu_sched_process_priority_set(amdgpu_device_handle dev,
>>      int fd, int32_t priority);
>>
>> /**
>> * Request to raise the minimum required priority to schedule a gpu job
>> *
>> * Submit a request to increase the minimum required priority to schedule
>> * a gpu job. Once this function returns, the gpu scheduler will no longer
>> * consider jobs from contexts with priority lower than @priority.
>> *
>> * The minimum priority considered by the scheduler will be the 
>> highest from
>> * all currently active requests.
>> *
>> * Requests are refcounted, and must be balanced using
>> * amdgpu_sched_min_priority_put()
>> *
>> * \param dev             - \c [in] device handle
>> * \param priority        - \c [in] target priority AMDGPU_CTX_PRIORITY_*
>> *
>> * \return  0 on success\n
>> *         <0 - Negative POSIX error code
>> *
>> * \notes this function requires DRM_MASTER
>> */
>> int amdgpu_sched_min_priority_get(amdgpu_device_handle dev,
>>  int32_t priority);
>>
>> /**
>> * Drop a request to raise the minimum required scheduler priority
>> *
>> * This call balances amdgpu_sched_min_priority_get()
>> *
>> * If no other active requests exists for @priority, the minimum required
>> * priority will decay to a lower level until one is reached with an 
>> active
>> * request or the lowest priority is reached.
>> *
>> * \param dev             - \c [in] device handle
>> * \param priority        - \c [in] target priority AMDGPU_CTX_PRIORITY_*
>> *
>> * \return  0 on success\n
>> *         <0 - Negative POSIX error code
>> *
>> * \notes this function requires DRM_MASTER
>> */
>> int amdgpu_sched_min_priority_put(amdgpu_device_handle dev,
>>  int32_t priority);
>>
>> Using this app, VRComposer can raise the priority of the VRapp and 
>> itself. Then
>> it can restrict the minimum scheduler priority in order to become 
>> exclusive gpu
>> clients.
>>
>> One of the areas I'd like feedback is the following scenario. If a 
>> VRapp opens
>> a new fd and creates a new context after a call to set_priority, this 
>> specific
>> context will be lower priority than the rest. If the minimum required 
>> priority
>> is then raised, it is possible that this new context will be starved and
>> deadlock the VRapp.
>>
>> One solution I had in mind to address this situation, is to make 
>> set_priority
>> also raise the priority of future contexts created by the VRapp. 
>> However, that
>> would require keeping track of the requested priority on a 
>> per-process data
>> structure. The current design appears to steer clean of keeping any 
>> process
>> specific data, and everything instead of stored on a per-file basis. 
>> Which is
>> why I did not pursue this approach. But if this is something you'd 
>> like me to
>> implement let me know.
>>
>> One could also argue that preventing an application deadlock should 
>> be handled
>> between the VRComposer and the VRApp. It is not the kernel's 
>> responsibility to
>> babysit userspace applications and prevent themselves from shooting 
>> themselves
>> in the foot. The same could be achieved by improper usage of shared 
>> fences
>> between processes.
>>
>> Thoughts/feedback/comments on this issue, or others, are appreciated.
>>
>> Regards,
>> Andres
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------075E90BA1B8AAEEE1EB8D1D9
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi David,<br>
      <br>
      the idea is that the compositor (which is DRM master) can change
      the priority of it's clients.<br>
      <br>
      So using dev-&gt;fd is pointless because that is the fd of the DRM
      master process.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 26.05.2017 um 11:02 schrieb Mao, David:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20E73ED4-5A64-45A5-A609-77F91CAB8425-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <font style="font-size: 14px;" class="" face="Calibri">Hi Andres,</font>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">Why the fd is needed for this interface?</font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">Why not just using the dev-&gt;fd instead of
          fd?</font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">IIRC, if there are more than one fds opened in
          the process upon the same device, they will share the same
          amdgpu_device_handle which is guaranteed by
          amdgpu_device_initialize.</font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">In other word, we should not run into the case
          that user creates more contexts with newly opened fd after
          tuning the priority of existing context in the same process
          unless the previous fd is closed. </font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri"><br class="">
        </font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">Thanks.</font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">Best Regards,</font></div>
      <div class=""><font style="font-size: 14px;" class=""
          face="Calibri">David</font></div>
      <div class=""><br class="">
        <div>
          <blockquote type="cite" class="">
            <div class="">On 25 May 2017, at 8:00 AM, Andres Rodriguez
              &lt;<a href="mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=""
                moz-do-not-send="true">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:</div>
            <br class="Apple-interchange-newline">
            <div class="">
              <div class="">When multiple environments are running
                simultaneously on a system, e.g.<br class="">
                an X desktop + a SteamVR game session, it may be useful
                to sacrifice<br class="">
                performance in one environment in order to boost it on
                the other.<br class="">
                <br class="">
                This series provides a mechanism for a DRM_MASTER to
                provide exclusive<br class="">
                gpu access to a group of processes.<br class="">
                <br class="">
                Note: This series is built on the assumption that the
                drm lease patch series<br class="">
                will extend DRM_MASTER status to lesees.<br class="">
                <br class="">
                The libdrm we intend to provide is as follows:<br
                  class="">
                <br class="">
                /**<br class="">
                * Set the priority of all contexts in a process<br
                  class="">
                *<br class="">
                * This function will change the priority of all contexts
                owned by<br class="">
                * the process identified by fd.<br class="">
                *<br class="">
                * \param dev             - \c [in] device handle<br
                  class="">
                * \param fd              - \c [in] fd from target
                process<br class="">
                * \param priority        - \c [in] target priority
                AMDGPU_CTX_PRIORITY_*<br class="">
                *<br class="">
                * \return  0 on success\n<br class="">
                *         &lt;0 - Negative POSIX error code<br class="">
                *<br class="">
                * \notes @fd can be *any* file descriptor from the
                target process.<br class="">
                * \notes this function requires DRM_MASTER<br class="">
                */<br class="">
                int
                amdgpu_sched_process_priority_set(amdgpu_device_handle
                dev,<br class="">
                <span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span>     int
                fd, int32_t priority);<br class="">
                <br class="">
                /**<br class="">
                * Request to raise the minimum required priority to
                schedule a gpu job<br class="">
                *<br class="">
                * Submit a request to increase the minimum required
                priority to schedule<br class="">
                * a gpu job. Once this function returns, the gpu
                scheduler will no longer<br class="">
                * consider jobs from contexts with priority lower than
                @priority.<br class="">
                *<br class="">
                * The minimum priority considered by the scheduler will
                be the highest from<br class="">
                * all currently active requests.<br class="">
                *<br class="">
                * Requests are refcounted, and must be balanced using<br
                  class="">
                * amdgpu_sched_min_priority_put()<br class="">
                *<br class="">
                * \param dev             - \c [in] device handle<br
                  class="">
                * \param priority        - \c [in] target priority
                AMDGPU_CTX_PRIORITY_*<br class="">
                *<br class="">
                * \return  0 on success\n<br class="">
                *         &lt;0 - Negative POSIX error code<br class="">
                *<br class="">
                * \notes this function requires DRM_MASTER<br class="">
                */<br class="">
                int amdgpu_sched_min_priority_get(amdgpu_device_handle
                dev,<br class="">
                <span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span> int32_t
                priority);<br class="">
                <br class="">
                /**<br class="">
                * Drop a request to raise the minimum required scheduler
                priority<br class="">
                *<br class="">
                * This call balances amdgpu_sched_min_priority_get()<br
                  class="">
                *<br class="">
                * If no other active requests exists for @priority, the
                minimum required<br class="">
                * priority will decay to a lower level until one is
                reached with an active<br class="">
                * request or the lowest priority is reached.<br class="">
                *<br class="">
                * \param dev             - \c [in] device handle<br
                  class="">
                * \param priority        - \c [in] target priority
                AMDGPU_CTX_PRIORITY_*<br class="">
                *<br class="">
                * \return  0 on success\n<br class="">
                *         &lt;0 - Negative POSIX error code<br class="">
                *<br class="">
                * \notes this function requires DRM_MASTER<br class="">
                */<br class="">
                int amdgpu_sched_min_priority_put(amdgpu_device_handle
                dev,<br class="">
                <span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span><span class="Apple-tab-span" style="white-space:pre"></span> int32_t
                priority);<br class="">
                <br class="">
                Using this app, VRComposer can raise the priority of the
                VRapp and itself. Then<br class="">
                it can restrict the minimum scheduler priority in order
                to become exclusive gpu<br class="">
                clients.<br class="">
                <br class="">
                One of the areas I'd like feedback is the following
                scenario. If a VRapp opens<br class="">
                a new fd and creates a new context after a call to
                set_priority, this specific<br class="">
                context will be lower priority than the rest. If the
                minimum required priority<br class="">
                is then raised, it is possible that this new context
                will be starved and<br class="">
                deadlock the VRapp.<br class="">
                <br class="">
                One solution I had in mind to address this situation, is
                to make set_priority<br class="">
                also raise the priority of future contexts created by
                the VRapp. However, that<br class="">
                would require keeping track of the requested priority on
                a per-process data<br class="">
                structure. The current design appears to steer clean of
                keeping any process<br class="">
                specific data, and everything instead of stored on a
                per-file basis. Which is<br class="">
                why I did not pursue this approach. But if this is
                something you'd like me to<br class="">
                implement let me know.<br class="">
                <br class="">
                One could also argue that preventing an application
                deadlock should be handled<br class="">
                between the VRComposer and the VRApp. It is not the
                kernel's responsibility to<br class="">
                babysit userspace applications and prevent themselves
                from shooting themselves<br class="">
                in the foot. The same could be achieved by improper
                usage of shared fences<br class="">
                between processes.<br class="">
                <br class="">
                Thoughts/feedback/comments on this issue, or others, are
                appreciated.<br class="">
                <br class="">
                Regards,<br class="">
                Andres<br class="">
                <br class="">
                <br class="">
                _______________________________________________<br
                  class="">
                amd-gfx mailing list<br class="">
                <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=""
                  moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br
                  class="">
                <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br
                  class="">
              </div>
            </div>
          </blockquote>
        </div>
        <br class="">
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------075E90BA1B8AAEEE1EB8D1D9--

--===============0457123253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0457123253==--
