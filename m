From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: RFC for a render API to support adaptive sync and VRR
Date: Tue, 10 Apr 2018 17:43:03 +0200
Message-ID: <fc53ce53-f02c-891d-4aa5-e9a11cbe3007@amd.com>
References: <c79421ce-9408-5cd6-5de3-0fa521146e4b@amd.com>
 <435ebd04-0435-5a6a-9f1e-e4c4fc629aa9@amd.com>
 <20180409214554.GB13967@intel.com>
 <1e8d1857-faba-85da-0136-ea7c29ec1b84@amd.com>
 <b75e31f7-ce59-de97-5445-cb4c03ff7336@daenzer.net>
 <ae9992e5-43ab-9636-13e1-8a5c692480b5@amd.com>
 <MWHPR12MB1837C57016A470A5199E855282BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0180586049=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <MWHPR12MB1837C57016A470A5199E855282BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Cyr, Aric" <Aric.Cyr@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Manasi Navare <manasi.d.navare@intel.com>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Daenzer,
 Michel" <Michel.Daenzer@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0180586049==
Content-Type: multipart/alternative;
 boundary="------------2A19E94A4CFBE446056EE3AA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2A19E94A4CFBE446056EE3AA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.04.2018 um 17:35 schrieb Cyr, Aric:
>> -----Original Message-----
>> From: Wentland, Harry
>> Sent: Tuesday, April 10, 2018 11:08
>> To: Michel Dänzer <michel@daenzer.net>; Koenig, Christian <Christian.Koenig@amd.com>; Manasi Navare
>> <manasi.d.navare@intel.com>
>> Cc: Haehnle, Nicolai <Nicolai.Haehnle@amd.com>; Daniel Vetter <daniel.vetter@ffwll.ch>; Daenzer, Michel
>> <Michel.Daenzer@amd.com>; dri-devel <dri-devel@lists.freedesktop.org>; amd-gfx mailing list <amd-gfx@lists.freedesktop.org>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Cyr, Aric <Aric.Cyr@amd.com>; Koo, Anthony <Anthony.Koo@amd.com>
>> Subject: Re: RFC for a render API to support adaptive sync and VRR
>>
>> On 2018-04-10 03:37 AM, Michel Dänzer wrote:
>>> On 2018-04-10 08:45 AM, Christian König wrote:
>>>> Am 09.04.2018 um 23:45 schrieb Manasi Navare:
>>>>> Thanks for initiating the discussion. Find my comments below:
>>>>> On Mon, Apr 09, 2018 at 04:00:21PM -0400, Harry Wentland wrote:
>>>>>> On 2018-04-09 03:56 PM, Harry Wentland wrote:
>>>>>>> === A DRM render API to support variable refresh rates ===
>>>>>>>
>>>>>>> In order to benefit from adaptive sync and VRR userland needs a way
>>>>>>> to let us know whether to vary frame timings or to target a
>>>>>>> different frame time. These can be provided as atomic properties on
>>>>>>> a CRTC:
>>>>>>>    * bool    variable_refresh_compatible
>>>>>>>    * int    target_frame_duration_ns (nanosecond frame duration)
>>>>>>>
>>>>>>> This gives us the following cases:
>>>>>>>
>>>>>>> variable_refresh_compatible = 0, target_frame_duration_ns = 0
>>>>>>>    * drive monitor at timing's normal refresh rate
>>>>>>>
>>>>>>> variable_refresh_compatible = 1, target_frame_duration_ns = 0
>>>>>>>    * send new frame to monitor as soon as it's available, if within
>>>>>>> min/max of monitor's reported capabilities
>>>>>>>
>>>>>>> variable_refresh_compatible = 0/1, target_frame_duration_ns = > 0
>>>>>>>    * send new frame to monitor with the specified
>>>>>>> target_frame_duration_ns
>>>>>>>
>>>>>>> When a target_frame_duration_ns or variable_refresh_compatible
>>>>>>> cannot be supported the atomic check will reject the commit.
>>>>>>>
>>>>> What I would like is two sets of properties on a CRTC or preferably on
>>>>> a connector:
>>>>>
>>>>> KMD properties that UMD can query:
>>>>> * vrr_capable -  This will be an immutable property for exposing
>>>>> hardware's capability of supporting VRR. This will be set by the
>>>>> kernel after
>>>>> reading the EDID mode information and monitor range capabilities.
>>>>> * vrr_vrefresh_max, vrr_vrefresh_min - To expose the min and max
>>>>> refresh rates supported.
>>>>> These properties are optional and will be created and attached to the
>>>>> DP/eDP connector when the connector
>>>>> is getting intialized.
>>>> Mhm, aren't those properties actually per mode and not per CRTC/connector?
>>>>
>>>>> Properties that you mentioned above that the UMD can set before kernel
>>>>> can enable VRR functionality
>>>>> *bool vrr_enable or vrr_compatible
>>>>> target_frame_duration_ns
>>>> Yeah, that certainly makes sense. But target_frame_duration_ns is a bad
>>>> name/semantics.
>>>>
>>>> We should use an absolute timestamp where the frame should be presented,
>>>> otherwise you could run into a bunch of trouble with IOCTL restarts or
>>>> missed blanks.
>>> Also, a fixed target frame duration isn't suitable even for video
>>> playback, due to drift between the video and audio clocks.
> Why?  Even if they drift, you know you want to show your 24Hz video frame for 41.6666ms and adaptive sync can ensure that with reasonable accuracy.
> All we're doing is eliminating the need for frame rate converters from the application and offloading that to hardware.
>
>>> Time-based presentation seems to be the right approach for preventing
>>> micro-stutter in games as well, Croteam developers have been researching
>>> this.
>>>
>> I'm not sure if the driver can ever give a guarantee of the exact time a flip occurs. What we have control over with our HW is frame
>> duration.
>>
>> Are Croteam devs trying to predict render times? I'm not sure how that would work. We've had bad experience in the past with
>> games that try to do framepacing as that's usually not accurate and tends to lead to more problems than benefits.
> For gaming, it doesn't make sense nor is it feasible to know how exactly how long a render will take with microsecond precision, very coarse guesses at best.  The point of adaptive sync is that it works *transparently* for the majority of cases, within the capability of the HW and driver.  We don't want to have every game re-write their engine to support this, but we do want the majority to "just work".
>
> The only exception is the video case where an application may want to request a fixed frame duration aligned to the video content.  This requires an explicit interface for the video app, and our proposal is to keep it simple:  app knows how long a frame should be presented for, and we try to honour that.

Well I strongly disagree on that.

See VDPAU for example: 
https://http.download.nvidia.com/XFree86/vdpau/doxygen/html/group___vdp_presentation_queue.html#ga5bd61ca8ef5d1bc54ca6921aa57f835a
> [in]
>
> 	earliest_presentation_time 	The timestamp associated with the 
> surface. The presentation queue will not display the surface until the 
> presentation queue's current time is at least this value.
>

Especially video players want an interface where they can specify when 
exactly a frame should show up on the display and then get the feedback 
when it actually was displayed.

For video games we have a similar situation where a frame is rendered 
for a certain world time and in the ideal case we would actually display 
the frame at this world time.

I mean we have the guys from Valve on this mailing list so I think we 
should just get the feedback from them and see what they prefer.

Regards,
Christian.

>
> -Aric


--------------2A19E94A4CFBE446056EE3AA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 10.04.2018 um 17:35 schrieb Cyr,
      Aric:<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR12MB1837C57016A470A5199E855282BE0@MWHPR12MB1837.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre wrap="">-----Original Message-----
From: Wentland, Harry
Sent: Tuesday, April 10, 2018 11:08
To: Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel@daenzer.net">&lt;michel@daenzer.net&gt;</a>; Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Manasi Navare
<a class="moz-txt-link-rfc2396E" href="mailto:manasi.d.navare@intel.com">&lt;manasi.d.navare@intel.com&gt;</a>
Cc: Haehnle, Nicolai <a class="moz-txt-link-rfc2396E" href="mailto:Nicolai.Haehnle@amd.com">&lt;Nicolai.Haehnle@amd.com&gt;</a>; Daniel Vetter <a class="moz-txt-link-rfc2396E" href="mailto:daniel.vetter@ffwll.ch">&lt;daniel.vetter@ffwll.ch&gt;</a>; Daenzer, Michel
<a class="moz-txt-link-rfc2396E" href="mailto:Michel.Daenzer@amd.com">&lt;Michel.Daenzer@amd.com&gt;</a>; dri-devel <a class="moz-txt-link-rfc2396E" href="mailto:dri-devel@lists.freedesktop.org">&lt;dri-devel@lists.freedesktop.org&gt;</a>; amd-gfx mailing list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Cyr, Aric <a class="moz-txt-link-rfc2396E" href="mailto:Aric.Cyr@amd.com">&lt;Aric.Cyr@amd.com&gt;</a>; Koo, Anthony <a class="moz-txt-link-rfc2396E" href="mailto:Anthony.Koo@amd.com">&lt;Anthony.Koo@amd.com&gt;</a>
Subject: Re: RFC for a render API to support adaptive sync and VRR

On 2018-04-10 03:37 AM, Michel Dänzer wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">On 2018-04-10 08:45 AM, Christian König wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">Am 09.04.2018 um 23:45 schrieb Manasi Navare:
</pre>
            <blockquote type="cite">
              <pre wrap="">Thanks for initiating the discussion. Find my comments below:
On Mon, Apr 09, 2018 at 04:00:21PM -0400, Harry Wentland wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="">On 2018-04-09 03:56 PM, Harry Wentland wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="">
=== A DRM render API to support variable refresh rates ===

In order to benefit from adaptive sync and VRR userland needs a way
to let us know whether to vary frame timings or to target a
different frame time. These can be provided as atomic properties on
a CRTC:
  * bool    variable_refresh_compatible
  * int    target_frame_duration_ns (nanosecond frame duration)

This gives us the following cases:

variable_refresh_compatible = 0, target_frame_duration_ns = 0
  * drive monitor at timing's normal refresh rate

variable_refresh_compatible = 1, target_frame_duration_ns = 0
  * send new frame to monitor as soon as it's available, if within
min/max of monitor's reported capabilities

variable_refresh_compatible = 0/1, target_frame_duration_ns = &gt; 0
  * send new frame to monitor with the specified
target_frame_duration_ns

When a target_frame_duration_ns or variable_refresh_compatible
cannot be supported the atomic check will reject the commit.

</pre>
                </blockquote>
              </blockquote>
              <pre wrap="">What I would like is two sets of properties on a CRTC or preferably on
a connector:

KMD properties that UMD can query:
* vrr_capable -  This will be an immutable property for exposing
hardware's capability of supporting VRR. This will be set by the
kernel after
reading the EDID mode information and monitor range capabilities.
* vrr_vrefresh_max, vrr_vrefresh_min - To expose the min and max
refresh rates supported.
These properties are optional and will be created and attached to the
DP/eDP connector when the connector
is getting intialized.
</pre>
            </blockquote>
            <pre wrap="">
Mhm, aren't those properties actually per mode and not per CRTC/connector?

</pre>
            <blockquote type="cite">
              <pre wrap="">Properties that you mentioned above that the UMD can set before kernel
can enable VRR functionality
*bool vrr_enable or vrr_compatible
target_frame_duration_ns
</pre>
            </blockquote>
            <pre wrap="">
Yeah, that certainly makes sense. But target_frame_duration_ns is a bad
name/semantics.

We should use an absolute timestamp where the frame should be presented,
otherwise you could run into a bunch of trouble with IOCTL restarts or
missed blanks.
</pre>
          </blockquote>
          <pre wrap="">
Also, a fixed target frame duration isn't suitable even for video
playback, due to drift between the video and audio clocks.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
Why?  Even if they drift, you know you want to show your 24Hz video frame for 41.6666ms and adaptive sync can ensure that with reasonable accuracy.  
All we're doing is eliminating the need for frame rate converters from the application and offloading that to hardware.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">Time-based presentation seems to be the right approach for preventing
micro-stutter in games as well, Croteam developers have been researching
this.

</pre>
        </blockquote>
        <pre wrap="">
I'm not sure if the driver can ever give a guarantee of the exact time a flip occurs. What we have control over with our HW is frame
duration.

Are Croteam devs trying to predict render times? I'm not sure how that would work. We've had bad experience in the past with
games that try to do framepacing as that's usually not accurate and tends to lead to more problems than benefits.
</pre>
      </blockquote>
      <pre wrap="">
For gaming, it doesn't make sense nor is it feasible to know how exactly how long a render will take with microsecond precision, very coarse guesses at best.  The point of adaptive sync is that it works *transparently* for the majority of cases, within the capability of the HW and driver.  We don't want to have every game re-write their engine to support this, but we do want the majority to "just work".

The only exception is the video case where an application may want to request a fixed frame duration aligned to the video content.  This requires an explicit interface for the video app, and our proposal is to keep it simple:  app knows how long a frame should be presented for, and we try to honour that.</pre>
    </blockquote>
    <br>
    Well I strongly disagree on that.<br>
    <br>
    See VDPAU for example:
<a class="moz-txt-link-freetext" href="https://http.download.nvidia.com/XFree86/vdpau/doxygen/html/group___vdp_presentation_queue.html#ga5bd61ca8ef5d1bc54ca6921aa57f835a">https://http.download.nvidia.com/XFree86/vdpau/doxygen/html/group___vdp_presentation_queue.html#ga5bd61ca8ef5d1bc54ca6921aa57f835a</a><br>
    <blockquote type="cite">[in]
      <table class="params">
        <tbody>
          <tr>
            <td class="paramdir"><br>
            </td>
            <td class="paramname">earliest_presentation_time</td>
            <td>The timestamp associated with the surface. The
              presentation queue will not display the surface until the
              presentation queue's current time is at least this value.</td>
          </tr>
        </tbody>
      </table>
    </blockquote>
    <br>
    Especially video players want an interface where they can specify
    when exactly a frame should show up on the display and then get the
    feedback when it actually was displayed.<br>
    <br>
    For video games we have a similar situation where a frame is
    rendered for a certain world time and in the ideal case we would
    actually display the frame at this world time.<br>
    <br>
    I mean we have the guys from Valve on this mailing list so I think
    we should just get the feedback from them and see what they prefer.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:MWHPR12MB1837C57016A470A5199E855282BE0@MWHPR12MB1837.namprd12.prod.outlook.com">
      <pre wrap="">

-Aric
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------2A19E94A4CFBE446056EE3AA--

--===============0180586049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0180586049==--
