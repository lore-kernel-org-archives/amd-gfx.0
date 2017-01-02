From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Mechanism for high priority scheduling in amdgpu
Date: Mon, 2 Jan 2017 16:43:40 +0100
Message-ID: <fa97b20f-4c8d-8ee0-fbed-ca9144fc9be9@amd.com>
References: <544E607D03B20249AA404517E498FC4699EBD3@exchange01.valvesoftware.com>
 <SN1PR12MB0703173C7AD623F6C5AECE7DFE9F0@SN1PR12MB0703.namprd12.prod.outlook.com>
 <bd0ba668-3d13-6343-a1c6-de5d0b7b3be3@valvesoftware.com>
 <58575362.2030100@amd.com>
 <361f177c-bf55-1525-4f35-86708e4f8d9f@valvesoftware.com>
 <58576C15.1070909@amd.com> <2bf5afce-d5b8-4eaf-0fcd-a7ebfe85f92e@gmail.com>
 <5857751C.5060409@amd.com> <d8cf437e-af88-c76d-428f-53912bc43d2b@amd.com>
 <5068f779-50ad-5e17-6d7e-8493e8fdd78a@vodafone.de>
 <afc51505-7f86-a963-5d3a-be9df538019e@gmail.com>
 <76892a0d-677b-f0cb-d4e7-74d29b4a0aa7@amd.com>
 <8ab5bb4d-f331-d991-f208-ec7c0a25662a@gmail.com>
 <fd1f1a6f-f72a-3e65-bb6f-17671d8b1d6b@amd.com>
 <2e8051cb-09b1-c5cb-cb5a-b7ca30f65e89@valvesoftware.com>
 <1c3ea5aa-36ee-5031-5f32-d860e9e0bf7c@amd.com>
 <b853e4e3-0ba5-2bda-e129-d9253e7b098d@valvesoftware.com>
 <CAFQ_0eHg=Kf5qV50cgm51m6bTcMYdkgRXkT-sykJnYNzu3Zzsg@mail.gmail.com>
 <58607FDF.2080200@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0808856035=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58607FDF.2080200-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Pierre-Loup A. Griffais" <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Serguei Sagalovitch <serguei.sagalovitch-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0808856035==
Content-Type: multipart/alternative;
	boundary="------------8A0F7AEF1F662A95B70010BF"

--------------8A0F7AEF1F662A95B70010BF
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Indeed a couple of nice numbers.

> but everything already commited
> to the HW queue is executed in strict FIFO order.
Well actually if we get a high priority submission we could 
preempt/abort everything on the ring buffer before it in theory.

Probably not as fine granularity as the hardware scheduler, but might be 
easier to get working.

Regards,
Christian.

Am 26.12.2016 um 03:26 schrieb zhoucm1:
> Nice experiment, which is exactly SW scheduler can provide.
> And as you said "I.e. your context can be scheduled into the
> HW queue ahead of any other context, but everything already commited
> to the HW queue is executed in strict FIFO order."
>
> If you want to keep consistent latency, which will need to enable hw 
> priority queue feature.
>
> Regards,
> David Zhou
>
> On 2016年12月24日 06:20, Andres Rodriguez wrote:
>> Hey John,
>>
>> I've collected bit of data using high priority SW scheduler queues,
>> thought you might be interested.
>>
>> Implementation as per the patch above.
>>
>> Control test 1
>> ==============
>>
>> Sascha Willems mesh sample running on its own at regular priority
>>
>> Results
>> -------
>>
>> Mesh: ~0.14ms per-frame latency
>>
>> Control test 2
>> ==============
>>
>> Two Sascha Willems mesh sample running on its own at regular priority
>>
>> Results
>> -------
>>
>> Mesh 1: ~0.26ms per-frame latency
>> Mesh 2: ~0.26ms per-frame latency
>>
>> Test 1
>> ======
>>
>> Two Sascha Willems mesh samples running simultaneously. One at high
>> priority and the other running in a regular priority graphics context.
>>
>> Results
>> -------
>>
>> Mesh High:    0.14 - 0.24ms per-frame latency
>> Mesh Regular: 0.24 - 0.40ms per-frame latency
>>
>> Test 2
>> ======
>>
>> Ten Sascha Willems mesh samples running simultaneously. One at high
>> priority and the others running in a regular priority graphics context.
>>
>> Results
>> -------
>>
>> Mesh High:    0.14 - 0.8ms per-frame latency
>> Mesh Regular: 1.10 - 2.05ms per-frame latency
>>
>> Test 3
>> ======
>>
>> Two Sascha Willems mesh samples running simultaneously. One at high
>> priority and the other running in a regular priority graphics context.
>>
>> Also running Unigine Heaven at Exteme preset @ 2560x1600
>>
>> Results
>> -------
>>
>> Mesh High:     7 - 100ms per-frame latency (Lots of fluctuation)
>> Mesh Regular: 40 - 130ms per-frame latency(Lots of fluctuation)
>> Unigine Heaven: 20-40 fps
>>
>>
>> Test 4
>> ======
>>
>> Two Sascha Willems mesh samples running simultaneously. One at high
>> priority and the other running in a regular priority graphics context.
>>
>> Also running Talos Principle @ 4K
>>
>> Results
>> -------
>>
>> Mesh High:    0.14 - 3.97ms per-frame latency (Mostly floats ~0.4ms)
>> Mesh Regular: 0.43 - 8.11ms per-frame latency (Lots of fluctuation)
>> Talos: 24.8 fps AVG
>>
>> Observations
>> ============
>>
>> The high priority queue based on the SW scheduler provides significant
>> gains when paired with tasks that submit short duration commands into
>> the queue. This can be observed in tests 1 and 2.
>>
>> When the pipe is full of long running commands, the effects are dampened.
>> As observed in test 3, the per-frame latency suffers very large spikes,
>> and the latencies are very inconsistent.
>>
>> Talos seems to be a better behaved game. It may be submitting shorter
>> draw commands and the SW scheduler is able to interleave the rest of
>> the work.
>>
>> The results seem consistent with the hypothetical advantages the SW
>> scheduler should provide. I.e. your context can be scheduled into the
>> HW queue ahead of any other context, but everything already commited
>> to the HW queue is executed in strict FIFO order.
>>
>> In order to deal with cases similar to Test 3, we will need to take
>> advantage of further features.
>>
>> Notes
>> =====
>>
>> - Tests were run multiple times, and reboots were performed during tests.
>> - The mesh sample isn't really designed for benchmarking, but it should
>>   be decent for ballpark figures
>> - The high priority mesh app was run with default niceness and also 
>> niceness
>>   at -20. This had no effect on the results, so it was not added above.
>> - CPU usage was not saturated while running the tests
>>
>> Regards,
>> Andres
>>
>>
>> On Fri, Dec 23, 2016 at 1:18 PM, Pierre-Loup A. Griffais 
>> <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org <mailto:pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>> wrote:
>>
>>     I hate to keep bringing up display topics in an unrelated
>>     conversation, but I'm not sure where you got "Application -> X
>>     server -> compositor -> X server" from. As I was saying before,
>>     we need to be presenting directly to the HMD display as no
>>     display server can be in the way, both for latency but also
>>     quality of service reasons (a buggy application cannot be allowed
>>     to accidentally display undistorted rendering into the HMD); we
>>     intend to do the necessary work for this, and the extent of X's
>>     (or a Wayland implementation, or any other display server)
>>     involvment will be to participate enough to know that the HMD
>>     display is off-limits. If you have more questions on the display
>>     aspect, or VR rendering in general, I'm happy to try to address
>>     them out-of-band from this conversation.
>>
>>
>>     On 12/23/2016 02:54 AM, Christian König wrote:
>>
>>             But yes, in general you don't want another compositor in
>>             the way, so
>>             we'll be acquiring the HMD display directly, separate
>>             from any desktop
>>             or display server.
>>
>>         Assuming that the the HMD is attached to the rendering device
>>         in some
>>         way you have the X server and the Compositor which both try
>>         to be DRM
>>         master at the same time.
>>
>>         Please correct me if that was fixed in the meantime, but that
>>         sounds
>>         like it will simply not work. Or is this what Andres mention
>>         below Dave
>>         is working on ?.
>>
>>         Additional to that a compositor in combination with X is a
>>         bit counter
>>         productive when you want to keep the latency low.
>>
>>         E.g. the "normal" flow of a GL or Vulkan surface filled with
>>         rendered
>>         data to be displayed is from the Application -> X server ->
>>         compositor
>>         -> X server.
>>
>>         The extra step between X server and compositor just means
>>         extra latency
>>         and for this use case you probably don't want that.
>>
>>         Targeting something like Wayland and when you need X
>>         compatibility
>>         XWayland sounds like the much better idea.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 22.12.2016 um 20:54 schrieb Pierre-Loup A. Griffais:
>>
>>             Display concerns are a separate issue, and as Andres said
>>             we have
>>             other plans to address. But yes, in general you don't
>>             want another
>>             compositor in the way, so we'll be acquiring the HMD
>>             display directly,
>>             separate from any desktop or display server. Same with
>>             security, we
>>             can have a separate conversation about that when the time
>>             comes.
>>
>>             On 12/22/2016 08:41 AM, Serguei Sagalovitch wrote:
>>
>>                 Andres,
>>
>>                 Did you measure  latency, etc. impact of __any__
>>                 compositor?
>>
>>                 My understanding is that VR has pretty strict
>>                 requirements related to
>>                 QoS.
>>
>>                 Sincerely yours,
>>                 Serguei Sagalovitch
>>
>>
>>                 On 2016-12-22 11:35 AM, Andres Rodriguez wrote:
>>
>>                     Hey Christian,
>>
>>                     We are currently interested in X, but with some
>>                     distros switching to
>>                     other compositors by default, we also need to
>>                     consider those.
>>
>>                     We agree, running the full vrcompositor in root
>>                     isn't something that
>>                     we want to do. Too many security concerns. Having
>>                     a small root helper
>>                     that does the privilege escalation for us is the
>>                     initial idea.
>>
>>                     For a long term approach, Pierre-Loup and Dave
>>                     are working on dealing
>>                     with the "two compositors" scenario a little
>>                     better in DRM+X.
>>                     Fullscreen isn't really a sufficient approach,
>>                     since we don't want the
>>                     HMD to be used as part of the Desktop environment
>>                     when a VR app is not
>>                     in use (this is extremely annoying).
>>
>>                     When the above is settled, we should have an auth
>>                     mechanism besides
>>                     DRM_MASTER or DRM_AUTH that allows the
>>                     vrcompositor to take over the
>>                     HMD permanently away from X. Re-using that auth
>>                     method to gate this
>>                     IOCTL is probably going to be the final solution.
>>
>>                     I propose to start with ROOT_ONLY since it should
>>                     allow us to respect
>>                     kernel IOCTL compatibility guidelines with the
>>                     most flexibility. Going
>>                     from a restrictive to a more flexible permission
>>                     model would be
>>                     inclusive, but going from a general to a
>>                     restrictive model may exclude
>>                     some apps that used to work.
>>
>>                     Regards,
>>                     Andres
>>
>>                     On 12/22/2016 6:42 AM, Christian König wrote:
>>
>>                         Hi Andres,
>>
>>                         well using root might cause stability and
>>                         security problems as well.
>>                         We worked quite hard to avoid exactly this for X.
>>
>>                         We could make this feature depend on the
>>                         compositor being DRM master,
>>                         but for example with X the X server is master
>>                         (and e.g. can change
>>                         resolutions etc..) and not the compositor.
>>
>>                         So another question is also what windowing
>>                         system (if any) are you
>>                         planning to use? X, Wayland, Flinger or
>>                         something completely
>>                         different ?
>>
>>                         Regards,
>>                         Christian.
>>
>>                         Am 20.12.2016 um 16:51 schrieb Andres Rodriguez:
>>
>>                             Hi Christian,
>>
>>                             That is definitely a concern. What we are
>>                             currently thinking is to
>>                             make the high priority queues accessible
>>                             to root only.
>>
>>                             Therefore is a non-root user attempts to
>>                             set the high priority flag
>>                             on context allocation, we would fail the
>>                             call and return ENOPERM.
>>
>>                             Regards,
>>                             Andres
>>
>>
>>                             On 12/20/2016 7:56 AM, Christian König wrote:
>>
>>                                     BTW: If there is  non-VR
>>                                     application which will use
>>                                     high-priority
>>                                     h/w queue then VR application
>>                                     will suffer.  Any ideas how
>>                                     to solve it?
>>
>>                                 Yeah, that problem came to my mind as
>>                                 well.
>>
>>                                 Basically we need to restrict those
>>                                 high priority submissions to
>>                                 the VR compositor or otherwise any
>>                                 malfunctioning application could
>>                                 use it.
>>
>>                                 Just think about some WebGL suddenly
>>                                 taking all our rendering away
>>                                 and we won't get anything drawn any more.
>>
>>                                 Alex or Michel any ideas on that?
>>
>>                                 Regards,
>>                                 Christian.
>>
>>                                 Am 19.12.2016 um 15:48 schrieb
>>                                 Serguei Sagalovitch:
>>
>>                                     > If compute queue is occupied
>>                                     only by you, the efficiency
>>                                     > is equal with setting job queue
>>                                     to high priority I think.
>>                                     The only risk is the situation
>>                                     when graphics will take all
>>                                     needed CUs. But in any case it
>>                                     should be very good test.
>>
>>                                     Andres/Pierre-Loup,
>>
>>                                     Did you try to do it or it is a
>>                                     lot of work for you?
>>
>>
>>                                     BTW: If there is  non-VR
>>                                     application which will use
>>                                     high-priority
>>                                     h/w queue then VR application
>>                                     will suffer.  Any ideas how
>>                                     to solve it?
>>
>>                                     Sincerely yours,
>>                                     Serguei Sagalovitch
>>
>>                                     On 2016-12-19 12:50 AM, zhoucm1
>>                                     wrote:
>>
>>                                         Do you encounter the priority
>>                                         issue for compute queue with
>>                                         current driver?
>>
>>                                         If compute queue is occupied
>>                                         only by you, the efficiency
>>                                         is equal
>>                                         with setting job queue to
>>                                         high priority I think.
>>
>>                                         Regards,
>>                                         David Zhou
>>
>>                                         On 2016年12月19日 13:29, Andres
>>                                         Rodriguez wrote:
>>
>>                                             Yes, vulkan is available
>>                                             on all-open through the
>>                                             mesa radv UMD.
>>
>>                                             I'm not sure if I'm
>>                                             asking for too much, but
>>                                             if we can
>>                                             coordinate a similar
>>                                             interface in radv and
>>                                             amdgpu-pro at the
>>                                             vulkan level that would
>>                                             be great.
>>
>>                                             I'm not sure what that's
>>                                             going to be yet.
>>
>>                                             - Andres
>>
>>                                             On 12/19/2016 12:11 AM,
>>                                             zhoucm1 wrote:
>>
>>
>>
>>                                                 On 2016年12月19日 11:33,
>>                                                 Pierre-Loup A.
>>                                                 Griffais wrote:
>>
>>                                                     We're currently
>>                                                     working with the
>>                                                     open stack; I
>>                                                     assume that a
>>                                                     mechanism could
>>                                                     be exposed by
>>                                                     both open and Pro
>>                                                     Vulkan
>>                                                     userspace drivers
>>                                                     and that the
>>                                                     amdgpu kernel
>>                                                     interface
>>                                                     improvements we
>>                                                     would pursue
>>                                                     following this
>>                                                     discussion would
>>                                                     let both drivers
>>                                                     take advantage of
>>                                                     the feature, correct?
>>
>>                                                 Of course.
>>                                                 Does open stack have
>>                                                 Vulkan support?
>>
>>                                                 Regards,
>>                                                 David Zhou
>>
>>
>>                                                     On 12/18/2016
>>                                                     07:26 PM, zhoucm1
>>                                                     wrote:
>>
>>                                                         By the way,
>>                                                         are you using
>>                                                         all-open
>>                                                         driver or
>>                                                         amdgpu-pro
>>                                                         driver?
>>
>>                                                         +David Mao,
>>                                                         who is
>>                                                         working on
>>                                                         our Vulkan
>>                                                         driver.
>>
>>                                                         Regards,
>>                                                         David Zhou
>>
>>                                                         On
>>                                                         2016年12月18日
>>                                                         06:05,
>>                                                         Pierre-Loup
>>                                                         A. Griffais
>>                                                         wrote:
>>
>>                                                             Hi Serguei,
>>
>>                                                             I'm also
>>                                                             working
>>                                                             on the
>>                                                             bringing
>>                                                             up our VR
>>                                                             runtime
>>                                                             on top of
>>                                                             amgpu;
>>                                                             see
>>                                                             replies
>>                                                             inline.
>>
>>                                                             On
>>                                                             12/16/2016
>>                                                             09:05 PM,
>>                                                             Sagalovitch,
>>                                                             Serguei
>>                                                             wrote:
>>
>>                                                                 Andres,
>>
>>                                                                      For
>>                                                                     current
>>                                                                     VR
>>                                                                     workloads
>>                                                                     we
>>                                                                     have
>>                                                                     3
>>                                                                     separate
>>                                                                     processes
>>                                                                     running
>>                                                                     actually:
>>
>>                                                                 So we
>>                                                                 could
>>                                                                 have
>>                                                                 potential
>>                                                                 memory
>>                                                                 overcommit
>>                                                                 case
>>                                                                 or do
>>                                                                 you do
>>                                                                 partitioning
>>                                                                 on
>>                                                                 your
>>                                                                 own? 
>>                                                                 I
>>                                                                 would
>>                                                                 think
>>                                                                 that
>>                                                                 there
>>                                                                 is
>>                                                                 need
>>                                                                 to avoid
>>                                                                 overcomit
>>                                                                 in
>>                                                                 VR
>>                                                                 case to
>>                                                                 prevent
>>                                                                 any
>>                                                                 BO
>>                                                                 migration.
>>
>>
>>                                                             You're
>>                                                             entirely
>>                                                             correct;
>>                                                             currently
>>                                                             the VR
>>                                                             runtime is
>>                                                             setting up
>>                                                             prioritized
>>                                                             CPU
>>                                                             scheduling
>>                                                             for its
>>                                                             VR
>>                                                             compositor,
>>                                                             we're
>>                                                             working on
>>                                                             prioritized
>>                                                             GPU
>>                                                             scheduling
>>                                                             and
>>                                                             pre-emption
>>                                                             (eg. this
>>                                                             thread),
>>                                                             and in
>>                                                             the
>>                                                             future it
>>                                                             will make
>>                                                             sense to
>>                                                             do work
>>                                                             in order
>>                                                             to make
>>                                                             sure that
>>                                                             its
>>                                                             memory
>>                                                             allocations
>>                                                             do not
>>                                                             get
>>                                                             evicted,
>>                                                             to
>>                                                             prevent any
>>                                                             unwelcome
>>                                                             additional
>>                                                             latency
>>                                                             in the
>>                                                             event of
>>                                                             needing
>>                                                             to perform
>>                                                             just-in-time
>>                                                             reprojection.
>>
>>                                                                 BTW:
>>                                                                 Do
>>                                                                 you
>>                                                                 mean
>>                                                                 __real__
>>                                                                 processes
>>                                                                 or
>>                                                                 threads?
>>                                                                 Based
>>                                                                 on my
>>                                                                 understanding
>>                                                                 sharing
>>                                                                 BOs
>>                                                                 between
>>                                                                 different
>>                                                                 processes
>>                                                                 could
>>                                                                 introduce
>>                                                                 additional
>>                                                                 synchronization
>>                                                                 constrains.
>>                                                                 btw:
>>                                                                 I am not
>>                                                                 sure
>>                                                                 if we
>>                                                                 are
>>                                                                 able
>>                                                                 to
>>                                                                 share
>>                                                                 Vulkan
>>                                                                 sync.
>>                                                                 object
>>                                                                 cross-process
>>                                                                 boundary.
>>
>>
>>                                                             They are
>>                                                             different
>>                                                             processes;
>>                                                             it is
>>                                                             important
>>                                                             for the
>>                                                             compositor
>>                                                             that
>>                                                             is
>>                                                             responsible
>>                                                             for
>>                                                             quality-of-service
>>                                                             features
>>                                                             such as
>>                                                             consistently
>>                                                             presenting
>>                                                             distorted
>>                                                             frames
>>                                                             with the
>>                                                             right
>>                                                             latency,
>>                                                             reprojection,
>>                                                             etc,
>>                                                             to be
>>                                                             separate
>>                                                             from the
>>                                                             main
>>                                                             application.
>>
>>                                                             Currently
>>                                                             we are
>>                                                             using
>>                                                             unreleased
>>                                                             cross-process
>>                                                             memory and
>>                                                             semaphore
>>                                                             extensions
>>                                                             to fetch
>>                                                             updated
>>                                                             eye
>>                                                             images
>>                                                             from the
>>                                                             client
>>                                                             application,
>>                                                             but the
>>                                                             just-in-time
>>                                                             reprojection
>>                                                             discussed
>>                                                             here does not
>>                                                             actually
>>                                                             have any
>>                                                             direct
>>                                                             interactions
>>                                                             with
>>                                                             cross-process
>>                                                             resource
>>                                                             sharing,
>>                                                             since
>>                                                             it's
>>                                                             achieved
>>                                                             by using
>>                                                             whatever
>>                                                             is the
>>                                                             latest, most
>>                                                             up-to-date
>>                                                             eye
>>                                                             images
>>                                                             that have
>>                                                             already
>>                                                             been sent
>>                                                             by the client
>>                                                             application,
>>                                                             which are
>>                                                             already
>>                                                             available
>>                                                             to use
>>                                                             without
>>                                                             additional
>>                                                             synchronization.
>>
>>
>>                                                                      
>>                                                                      3)
>>                                                                     System
>>                                                                     compositor
>>                                                                     (we
>>                                                                     are
>>                                                                     looking
>>                                                                     at
>>                                                                     approaches
>>                                                                     to
>>                                                                     remove
>>                                                                     this
>>                                                                     overhead)
>>
>>                                                                 Yes, 
>>                                                                 IMHO
>>                                                                 the
>>                                                                 best
>>                                                                 is to
>>                                                                 run
>>                                                                 in 
>>                                                                 "full
>>                                                                 screen
>>                                                                 mode".
>>
>>
>>                                                             Yes, we
>>                                                             are
>>                                                             working
>>                                                             on
>>                                                             mechanisms
>>                                                             to
>>                                                             present
>>                                                             directly
>>                                                             to the
>>                                                             headset
>>                                                             display
>>                                                             without
>>                                                             any
>>                                                             intermediaries
>>                                                             as a
>>                                                             separate
>>                                                             effort.
>>
>>
>>                                                                      The
>>                                                                     latency
>>                                                                     is
>>                                                                     our
>>                                                                     main
>>                                                                     concern,
>>
>>                                                                 I
>>                                                                 would
>>                                                                 assume
>>                                                                 that
>>                                                                 this
>>                                                                 is
>>                                                                 the
>>                                                                 known
>>                                                                 problem
>>                                                                 (at
>>                                                                 least for
>>                                                                 compute
>>                                                                 usage).
>>                                                                 It
>>                                                                 looks
>>                                                                 like
>>                                                                 that
>>                                                                 amdgpu
>>                                                                 /
>>                                                                 kernel
>>                                                                 submission
>>                                                                 is
>>                                                                 rather
>>                                                                 CPU
>>                                                                 intensive
>>                                                                 (at least
>>                                                                 in
>>                                                                 the
>>                                                                 default
>>                                                                 configuration).
>>
>>
>>                                                             As long
>>                                                             as it's a
>>                                                             consistent
>>                                                             cost, it
>>                                                             shouldn't
>>                                                             an issue.
>>                                                             However, if
>>                                                             there's
>>                                                             high
>>                                                             degrees
>>                                                             of
>>                                                             variance
>>                                                             then that
>>                                                             would be
>>                                                             troublesome
>>                                                             and we
>>                                                             would
>>                                                             need to
>>                                                             account
>>                                                             for the
>>                                                             worst case.
>>
>>                                                             Hopefully
>>                                                             the
>>                                                             requirements
>>                                                             and
>>                                                             approach
>>                                                             we
>>                                                             described
>>                                                             make
>>                                                             sense, we're
>>                                                             looking
>>                                                             forward
>>                                                             to your
>>                                                             feedback
>>                                                             and
>>                                                             suggestions.
>>
>>                                                             Thanks!
>>                                                              -
>>                                                             Pierre-Loup
>>
>>
>>                                                                 Sincerely
>>                                                                 yours,
>>                                                                 Serguei
>>                                                                 Sagalovitch
>>
>>
>>                                                                 From:
>>                                                                 Andres
>>                                                                 Rodriguez
>>                                                                 <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org
>>                                                                 <mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>>
>>                                                                 Sent:
>>                                                                 December
>>                                                                 16,
>>                                                                 2016
>>                                                                 10:00 PM
>>                                                                 To:
>>                                                                 Sagalovitch,
>>                                                                 Serguei;
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 Subject:
>>                                                                 RE:
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>                                                                 Hey
>>                                                                 Serguei,
>>
>>                                                                     [Serguei]
>>                                                                     No.
>>                                                                     I
>>                                                                     mean
>>                                                                     pipe
>>                                                                     :-)
>>                                                                     as
>>                                                                     MEC
>>                                                                     define
>>                                                                     it. 
>>                                                                     As
>>                                                                     far
>>                                                                     as I
>>                                                                     understand
>>                                                                     (by
>>                                                                     simplifying)
>>                                                                     some
>>                                                                     scheduling
>>                                                                     is
>>                                                                     per
>>                                                                     pipe. 
>>                                                                     I
>>                                                                     know
>>                                                                     about
>>                                                                     the
>>                                                                     current
>>                                                                     allocation
>>                                                                     scheme
>>                                                                     but
>>                                                                     I
>>                                                                     do
>>                                                                     not
>>                                                                     think
>>                                                                     that
>>                                                                     it
>>                                                                     is 
>>                                                                     ideal. 
>>                                                                     I
>>                                                                     would
>>                                                                     assume
>>                                                                     that
>>                                                                     we
>>                                                                     need
>>                                                                     to
>>                                                                     switch
>>                                                                     to
>>                                                                     dynamical
>>                                                                     partition
>>                                                                     of
>>                                                                     resources 
>>                                                                     based
>>                                                                     on
>>                                                                     the
>>                                                                     workload
>>                                                                     otherwise
>>                                                                     we
>>                                                                     will
>>                                                                     have
>>                                                                     resource
>>                                                                     conflict
>>                                                                     between
>>                                                                     Vulkan
>>                                                                     compute
>>                                                                     and 
>>                                                                     OpenCL.
>>
>>
>>                                                                 I
>>                                                                 agree
>>                                                                 the
>>                                                                 partitioning
>>                                                                 isn't
>>                                                                 ideal.
>>                                                                 I'm
>>                                                                 hoping
>>                                                                 we can
>>                                                                 start
>>                                                                 with a
>>                                                                 solution
>>                                                                 that
>>                                                                 assumes
>>                                                                 that
>>                                                                 only
>>                                                                 pipe0
>>                                                                 has
>>                                                                 any
>>                                                                 work
>>                                                                 and
>>                                                                 the
>>                                                                 other
>>                                                                 pipes
>>                                                                 are
>>                                                                 idle (no
>>                                                                 HSA/ROCm
>>                                                                 running
>>                                                                 on
>>                                                                 the
>>                                                                 system).
>>
>>                                                                 This
>>                                                                 should
>>                                                                 be
>>                                                                 more
>>                                                                 or
>>                                                                 less
>>                                                                 the
>>                                                                 use
>>                                                                 case
>>                                                                 we
>>                                                                 expect
>>                                                                 from VR
>>                                                                 users.
>>
>>                                                                 I
>>                                                                 agree
>>                                                                 the
>>                                                                 split
>>                                                                 is
>>                                                                 currently
>>                                                                 not
>>                                                                 ideal,
>>                                                                 but
>>                                                                 I'd
>>                                                                 like to
>>                                                                 consider
>>                                                                 that
>>                                                                 a
>>                                                                 separate
>>                                                                 task,
>>                                                                 because
>>                                                                 making
>>                                                                 it
>>                                                                 dynamic
>>                                                                 is
>>                                                                 not
>>                                                                 straight
>>                                                                 forward
>>                                                                 :P
>>
>>                                                                     [Serguei]
>>                                                                     Vulkan
>>                                                                     works
>>                                                                     via
>>                                                                     amdgpu
>>                                                                     (kernel
>>                                                                     submissions)
>>                                                                     so
>>                                                                     amdkfd
>>                                                                     will
>>                                                                     be
>>                                                                     not
>>                                                                     involved. 
>>                                                                     I
>>                                                                     would
>>                                                                     assume
>>                                                                     that
>>                                                                     in
>>                                                                     the
>>                                                                     case
>>                                                                     of
>>                                                                     VR
>>                                                                     we
>>                                                                     will
>>                                                                     have
>>                                                                     one
>>                                                                     main
>>                                                                     application
>>                                                                     ("console"
>>                                                                     mode(?))
>>                                                                     so
>>                                                                     we
>>                                                                     could
>>                                                                     temporally
>>                                                                     "ignore"
>>                                                                     OpenCL/ROCm
>>                                                                     needs
>>                                                                     when
>>                                                                     VR
>>                                                                     is
>>                                                                     running.
>>
>>
>>                                                                 Correct,
>>                                                                 this
>>                                                                 is
>>                                                                 why
>>                                                                 we
>>                                                                 want
>>                                                                 to
>>                                                                 enable
>>                                                                 the
>>                                                                 high
>>                                                                 priority
>>                                                                 compute
>>                                                                 queue
>>                                                                 through
>>                                                                 libdrm-amdgpu,
>>                                                                 so
>>                                                                 that
>>                                                                 we
>>                                                                 can
>>                                                                 expose
>>                                                                 it
>>                                                                 through
>>                                                                 Vulkan
>>                                                                 later.
>>
>>                                                                 For
>>                                                                 current
>>                                                                 VR
>>                                                                 workloads
>>                                                                 we
>>                                                                 have
>>                                                                 3
>>                                                                 separate
>>                                                                 processes
>>                                                                 running
>>                                                                 actually:
>>                                                                    
>>                                                                 1)
>>                                                                 Game
>>                                                                 process
>>                                                                    
>>                                                                 2) VR
>>                                                                 Compositor
>>                                                                 (this
>>                                                                 is
>>                                                                 the
>>                                                                 process
>>                                                                 that
>>                                                                 will
>>                                                                 require
>>                                                                 high
>>                                                                 priority
>>                                                                 queue)
>>                                                                    
>>                                                                 3)
>>                                                                 System
>>                                                                 compositor
>>                                                                 (we
>>                                                                 are
>>                                                                 looking
>>                                                                 at
>>                                                                 approaches
>>                                                                 to
>>                                                                 remove
>>                                                                 this
>>                                                                 overhead)
>>
>>                                                                 For
>>                                                                 now I
>>                                                                 think
>>                                                                 it is
>>                                                                 okay
>>                                                                 to
>>                                                                 assume
>>                                                                 no
>>                                                                 OpenCL/ROCm
>>                                                                 running
>>                                                                 simultaneously,
>>                                                                 but
>>                                                                 I
>>                                                                 would
>>                                                                 also
>>                                                                 like
>>                                                                 to be
>>                                                                 able
>>                                                                 to
>>                                                                 address
>>                                                                 this
>>                                                                 case
>>                                                                 in the
>>                                                                 future
>>                                                                 (cross-pipe
>>                                                                 priorities).
>>
>>                                                                     [Serguei] 
>>                                                                     The
>>                                                                     problem
>>                                                                     with
>>                                                                     pre-emption
>>                                                                     of
>>                                                                     graphics
>>                                                                     task:
>>                                                                     (a)
>>                                                                     it
>>                                                                     may
>>                                                                     take
>>                                                                     time
>>                                                                     so
>>                                                                     latency
>>                                                                     may
>>                                                                     suffer
>>
>>
>>                                                                 The
>>                                                                 latency
>>                                                                 is
>>                                                                 our
>>                                                                 main
>>                                                                 concern,
>>                                                                 we
>>                                                                 want
>>                                                                 something
>>                                                                 that is
>>                                                                 predictable.
>>                                                                 A good
>>                                                                 illustration
>>                                                                 of
>>                                                                 what
>>                                                                 the
>>                                                                 reprojection
>>                                                                 scheduling
>>                                                                 looks
>>                                                                 like
>>                                                                 can be
>>                                                                 found
>>                                                                 here:
>>                                                                 https://community.amd.com/servlet/JiveServlet/showImage/38-1310-104754/pastedImage_3.png
>>                                                                 <https://community.amd.com/servlet/JiveServlet/showImage/38-1310-104754/pastedImage_3.png>
>>
>>
>>
>>
>>                                                                     (b)
>>                                                                     to
>>                                                                     preempt
>>                                                                     we
>>                                                                     need
>>                                                                     to
>>                                                                     have
>>                                                                     different
>>                                                                     "context"
>>                                                                     - we
>>                                                                     want
>>                                                                     to
>>                                                                     guarantee
>>                                                                     that
>>                                                                     submissions
>>                                                                     from
>>                                                                     the
>>                                                                     same
>>                                                                     context
>>                                                                     will
>>                                                                     be
>>                                                                     executed
>>                                                                     in
>>                                                                     order.
>>
>>
>>                                                                 This
>>                                                                 is
>>                                                                 okay,
>>                                                                 as
>>                                                                 the
>>                                                                 reprojection
>>                                                                 work
>>                                                                 doesn't
>>                                                                 have
>>                                                                 dependencies
>>                                                                 on
>>                                                                 the
>>                                                                 game
>>                                                                 context,
>>                                                                 and it
>>                                                                 even
>>                                                                 happens
>>                                                                 in a
>>                                                                 separate
>>                                                                 process.
>>
>>                                                                     BTW:
>>                                                                     (a)
>>                                                                     Do
>>                                                                     you
>>                                                                     want
>>                                                                     "preempt"
>>                                                                     and
>>                                                                     later
>>                                                                     resume
>>                                                                     or
>>                                                                     do
>>                                                                     you
>>                                                                     want
>>                                                                     "preempt"
>>                                                                     and
>>                                                                     "cancel/abort"
>>
>>
>>                                                                 Preempt
>>                                                                 the
>>                                                                 game
>>                                                                 with
>>                                                                 the
>>                                                                 compositor
>>                                                                 task
>>                                                                 and
>>                                                                 then
>>                                                                 resume
>>                                                                 it.
>>
>>                                                                     (b)
>>                                                                     Vulkan
>>                                                                     is
>>                                                                     generic
>>                                                                     API
>>                                                                     and
>>                                                                     could
>>                                                                     be
>>                                                                     used
>>                                                                     for
>>                                                                     graphics
>>                                                                     as
>>                                                                     well
>>                                                                     as
>>                                                                     for
>>                                                                     plain
>>                                                                     compute
>>                                                                     tasks
>>                                                                     (VK_QUEUE_COMPUTE_BIT).
>>
>>
>>                                                                 Yeah,
>>                                                                 the
>>                                                                 plan
>>                                                                 is to
>>                                                                 use
>>                                                                 vulkan
>>                                                                 compute.
>>                                                                 But
>>                                                                 if
>>                                                                 you
>>                                                                 figure
>>                                                                 out a way
>>                                                                 for
>>                                                                 us to get
>>                                                                 a
>>                                                                 guaranteed
>>                                                                 execution
>>                                                                 time
>>                                                                 using
>>                                                                 vulkan
>>                                                                 graphics,
>>                                                                 then
>>                                                                 I'll
>>                                                                 take you
>>                                                                 out
>>                                                                 for a
>>                                                                 beer :)
>>
>>                                                                 Regards,
>>                                                                 Andres
>>                                                                 ________________________________________
>>                                                                 From:
>>                                                                 Sagalovitch,
>>                                                                 Serguei
>>                                                                 [Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org
>>                                                                 <mailto:Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org>]
>>                                                                 Sent:
>>                                                                 Friday,
>>                                                                 December
>>                                                                 16,
>>                                                                 2016
>>                                                                 9:13 PM
>>                                                                 To:
>>                                                                 Andres
>>                                                                 Rodriguez;
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 Subject:
>>                                                                 Re:
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>                                                                 Hi
>>                                                                 Andres,
>>
>>                                                                 Please
>>                                                                 see
>>                                                                 inline
>>                                                                 (as
>>                                                                 [Serguei])
>>
>>                                                                 Sincerely
>>                                                                 yours,
>>                                                                 Serguei
>>                                                                 Sagalovitch
>>
>>
>>                                                                 From:
>>                                                                 Andres
>>                                                                 Rodriguez
>>                                                                 <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org
>>                                                                 <mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>>
>>                                                                 Sent:
>>                                                                 December
>>                                                                 16,
>>                                                                 2016
>>                                                                 8:29 PM
>>                                                                 To:
>>                                                                 Sagalovitch,
>>                                                                 Serguei;
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 Subject:
>>                                                                 RE:
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>                                                                 Hi
>>                                                                 Serguei,
>>
>>                                                                 Thanks
>>                                                                 for
>>                                                                 the
>>                                                                 feedback.
>>                                                                 Answers
>>                                                                 inline
>>                                                                 as [AR].
>>
>>                                                                 Regards,
>>                                                                 Andres
>>
>>                                                                 ________________________________________
>>                                                                 From:
>>                                                                 Sagalovitch,
>>                                                                 Serguei
>>                                                                 [Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org
>>                                                                 <mailto:Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org>]
>>                                                                 Sent:
>>                                                                 Friday,
>>                                                                 December
>>                                                                 16,
>>                                                                 2016
>>                                                                 8:15 PM
>>                                                                 To:
>>                                                                 Andres
>>                                                                 Rodriguez;
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 Subject:
>>                                                                 Re:
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>                                                                 Andres,
>>
>>
>>                                                                 Quick
>>                                                                 comments:
>>
>>                                                                 1) To
>>                                                                 minimize
>>                                                                 "bubbles",
>>                                                                 etc.
>>                                                                 we
>>                                                                 need
>>                                                                 to
>>                                                                 "force"
>>                                                                 CU
>>                                                                 assignments/binding
>>                                                                 to
>>                                                                 high-priority
>>                                                                 queue
>>                                                                 when
>>                                                                 it
>>                                                                 will
>>                                                                 be in
>>                                                                 use
>>                                                                 and
>>                                                                 "free"
>>                                                                 them
>>                                                                 later
>>                                                                 (we 
>>                                                                 do
>>                                                                 not
>>                                                                 want
>>                                                                 forever
>>                                                                 take
>>                                                                 CUs
>>                                                                 from
>>                                                                 e.g.
>>                                                                 graphic
>>                                                                 task to
>>                                                                 degrade
>>                                                                 graphics
>>                                                                 performance).
>>
>>                                                                 Otherwise
>>                                                                 we
>>                                                                 could
>>                                                                 have
>>                                                                 scenario
>>                                                                 when
>>                                                                 long
>>                                                                 graphics
>>                                                                 task (or
>>                                                                 low-priority
>>                                                                 compute)
>>                                                                 will
>>                                                                 took
>>                                                                 all
>>                                                                 (extra)
>>                                                                 CUs
>>                                                                 and
>>                                                                 high--priority
>>                                                                 will
>>                                                                 wait for
>>                                                                 needed
>>                                                                 resources.
>>                                                                 It
>>                                                                 will
>>                                                                 not
>>                                                                 be
>>                                                                 visible
>>                                                                 on
>>                                                                 "NOP
>>                                                                 " but
>>                                                                 only
>>                                                                 when
>>                                                                 you
>>                                                                 submit
>>                                                                 "real"
>>                                                                 compute
>>                                                                 task
>>                                                                 so I
>>                                                                 would
>>                                                                 recommend
>>                                                                 not
>>                                                                 to
>>                                                                 use
>>                                                                 "NOP"
>>                                                                 packets
>>                                                                 at
>>                                                                 all for
>>                                                                 testing.
>>
>>                                                                 It
>>                                                                 (CU
>>                                                                 assignment)
>>                                                                 could
>>                                                                 be
>>                                                                 relatively
>>                                                                 easy
>>                                                                 done when
>>                                                                 everything
>>                                                                 is
>>                                                                 going
>>                                                                 via
>>                                                                 kernel
>>                                                                 (e.g.
>>                                                                 as
>>                                                                 part
>>                                                                 of
>>                                                                 frame
>>                                                                 submission)
>>                                                                 but I
>>                                                                 must
>>                                                                 admit
>>                                                                 that I
>>                                                                 am
>>                                                                 not sure
>>                                                                 about
>>                                                                 the
>>                                                                 best
>>                                                                 way
>>                                                                 for
>>                                                                 user
>>                                                                 level
>>                                                                 submissions
>>                                                                 (amdkfd).
>>
>>                                                                 [AR]
>>                                                                 I
>>                                                                 wasn't
>>                                                                 aware
>>                                                                 of
>>                                                                 this
>>                                                                 part
>>                                                                 of
>>                                                                 the
>>                                                                 programming
>>                                                                 sequence.
>>                                                                 Thanks
>>                                                                 for
>>                                                                 the
>>                                                                 heads up!
>>                                                                 Is
>>                                                                 this
>>                                                                 similar
>>                                                                 to
>>                                                                 the
>>                                                                 CU
>>                                                                 masking
>>                                                                 programming?
>>                                                                 [Serguei]
>>                                                                 Yes.
>>                                                                 To
>>                                                                 simplify:
>>                                                                 the
>>                                                                 problem
>>                                                                 is
>>                                                                 that
>>                                                                 "scheduler"
>>                                                                 when
>>                                                                 deciding
>>                                                                 which
>>                                                                 queue
>>                                                                 to 
>>                                                                 run
>>                                                                 will
>>                                                                 check
>>                                                                 if
>>                                                                 there
>>                                                                 is
>>                                                                 enough
>>                                                                 resources
>>                                                                 and
>>                                                                 if
>>                                                                 not then
>>                                                                 it
>>                                                                 will
>>                                                                 begin
>>                                                                 to
>>                                                                 check
>>                                                                 other
>>                                                                 queues
>>                                                                 with
>>                                                                 lower
>>                                                                 priority.
>>
>>                                                                 2) I
>>                                                                 would
>>                                                                 recommend
>>                                                                 to
>>                                                                 dedicate
>>                                                                 the
>>                                                                 whole
>>                                                                 pipe to
>>                                                                 high-priority
>>                                                                 queue
>>                                                                 and have
>>                                                                 nothing
>>                                                                 their
>>                                                                 except
>>                                                                 it.
>>
>>                                                                 [AR]
>>                                                                 I'm
>>                                                                 guessing
>>                                                                 in
>>                                                                 this
>>                                                                 context
>>                                                                 you
>>                                                                 mean
>>                                                                 pipe
>>                                                                 = queue?
>>                                                                 (as
>>                                                                 opposed
>>                                                                 to
>>                                                                 the
>>                                                                 MEC
>>                                                                 definition
>>                                                                 of
>>                                                                 pipe,
>>                                                                 which
>>                                                                 is a
>>                                                                 grouping
>>                                                                 of
>>                                                                 queues).
>>                                                                 I say
>>                                                                 this
>>                                                                 because
>>                                                                 amdgpu
>>                                                                 only
>>                                                                 has
>>                                                                 access
>>                                                                 to 1
>>                                                                 pipe,
>>                                                                 and
>>                                                                 the
>>                                                                 rest
>>                                                                 are
>>                                                                 statically
>>                                                                 partitioned
>>                                                                 for
>>                                                                 amdkfd
>>                                                                 usage.
>>
>>                                                                 [Serguei]
>>                                                                 No. I
>>                                                                 mean
>>                                                                 pipe
>>                                                                 :-) 
>>                                                                 as
>>                                                                 MEC
>>                                                                 define
>>                                                                 it.
>>                                                                 As
>>                                                                 far as I
>>                                                                 understand
>>                                                                 (by
>>                                                                 simplifying)
>>                                                                 some
>>                                                                 scheduling
>>                                                                 is
>>                                                                 per
>>                                                                 pipe. 
>>                                                                 I
>>                                                                 know
>>                                                                 about
>>                                                                 the
>>                                                                 current
>>                                                                 allocation
>>                                                                 scheme
>>                                                                 but I
>>                                                                 do
>>                                                                 not think
>>                                                                 that
>>                                                                 it
>>                                                                 is 
>>                                                                 ideal. 
>>                                                                 I
>>                                                                 would
>>                                                                 assume
>>                                                                 that
>>                                                                 we
>>                                                                 need
>>                                                                 to
>>                                                                 switch to
>>                                                                 dynamical
>>                                                                 partition
>>                                                                 of
>>                                                                 resources 
>>                                                                 based
>>                                                                 on
>>                                                                 the
>>                                                                 workload
>>                                                                 otherwise
>>                                                                 we
>>                                                                 will have
>>                                                                 resource
>>                                                                 conflict
>>                                                                 between
>>                                                                 Vulkan
>>                                                                 compute
>>                                                                 and 
>>                                                                 OpenCL.
>>
>>
>>                                                                 BTW:
>>                                                                 Which
>>                                                                 user
>>                                                                 level
>>                                                                 API
>>                                                                 do
>>                                                                 you
>>                                                                 want
>>                                                                 to
>>                                                                 use
>>                                                                 for
>>                                                                 compute:
>>                                                                 Vulkan or
>>                                                                 OpenCL?
>>
>>                                                                 [AR]
>>                                                                 Vulkan
>>
>>                                                                 [Serguei]
>>                                                                 Vulkan
>>                                                                 works
>>                                                                 via
>>                                                                 amdgpu
>>                                                                 (kernel
>>                                                                 submissions)
>>                                                                 so
>>                                                                 amdkfd
>>                                                                 will
>>                                                                 be not
>>                                                                 involved. 
>>                                                                 I
>>                                                                 would
>>                                                                 assume
>>                                                                 that
>>                                                                 in
>>                                                                 the
>>                                                                 case
>>                                                                 of VR
>>                                                                 we will
>>                                                                 have
>>                                                                 one main
>>                                                                 application
>>                                                                 ("console"
>>                                                                 mode(?))
>>                                                                 so we
>>                                                                 could
>>                                                                 temporally
>>                                                                 "ignore"
>>                                                                 OpenCL/ROCm
>>                                                                 needs
>>                                                                 when
>>                                                                 VR is
>>                                                                 running.
>>
>>                                                                      we
>>                                                                     will
>>                                                                     not
>>                                                                     be
>>                                                                     able
>>                                                                     to
>>                                                                     provide
>>                                                                     a
>>                                                                     solution
>>                                                                     compatible
>>                                                                     with
>>                                                                     GFX
>>                                                                     worloads.
>>
>>                                                                 I
>>                                                                 assume
>>                                                                 that
>>                                                                 you
>>                                                                 are
>>                                                                 talking
>>                                                                 about
>>                                                                 graphics?
>>                                                                 Am I
>>                                                                 right?
>>
>>                                                                 [AR]
>>                                                                 Yeah,
>>                                                                 my
>>                                                                 understanding
>>                                                                 is
>>                                                                 that
>>                                                                 pre-empting
>>                                                                 the
>>                                                                 currently
>>                                                                 running
>>                                                                 graphics
>>                                                                 job
>>                                                                 and
>>                                                                 scheduling
>>                                                                 in
>>                                                                 something
>>                                                                 else
>>                                                                 using
>>                                                                 mid-buffer
>>                                                                 pre-emption
>>                                                                 has
>>                                                                 some
>>                                                                 cases
>>                                                                 where it
>>                                                                 doesn't
>>                                                                 work
>>                                                                 well.
>>                                                                 But
>>                                                                 if with
>>                                                                 polaris10
>>                                                                 it
>>                                                                 starts
>>                                                                 working
>>                                                                 well,
>>                                                                 it
>>                                                                 might
>>                                                                 be a
>>                                                                 better
>>                                                                 solution
>>                                                                 for
>>                                                                 us
>>                                                                 (because
>>                                                                 the
>>                                                                 whole
>>                                                                 reprojection
>>                                                                 work
>>                                                                 uses
>>                                                                 the
>>                                                                 vulkan
>>                                                                 graphics
>>                                                                 stack
>>                                                                 at
>>                                                                 the
>>                                                                 moment,
>>                                                                 and
>>                                                                 porting
>>                                                                 it to
>>                                                                 compute
>>                                                                 is
>>                                                                 not
>>                                                                 trivial).
>>
>>                                                                 [Serguei] 
>>                                                                 The
>>                                                                 problem
>>                                                                 with
>>                                                                 pre-emption
>>                                                                 of
>>                                                                 graphics
>>                                                                 task:
>>                                                                 (a)
>>                                                                 it may
>>                                                                 take
>>                                                                 time so
>>                                                                 latency
>>                                                                 may
>>                                                                 suffer
>>                                                                 (b)
>>                                                                 to
>>                                                                 preempt
>>                                                                 we
>>                                                                 need
>>                                                                 to
>>                                                                 have
>>                                                                 different
>>                                                                 "context"
>>                                                                 - we want
>>                                                                 to
>>                                                                 guarantee
>>                                                                 that
>>                                                                 submissions
>>                                                                 from
>>                                                                 the
>>                                                                 same
>>                                                                 context
>>                                                                 will be
>>                                                                 executed
>>                                                                 in order.
>>                                                                 BTW:
>>                                                                 (a)
>>                                                                 Do
>>                                                                 you
>>                                                                 want
>>                                                                 "preempt"
>>                                                                 and
>>                                                                 later
>>                                                                 resume
>>                                                                 or do you
>>                                                                 want
>>                                                                 "preempt"
>>                                                                 and
>>                                                                 "cancel/abort"? 
>>                                                                 (b)
>>                                                                 Vulkan
>>                                                                 is
>>                                                                 generic
>>                                                                 API
>>                                                                 and
>>                                                                 could
>>                                                                 be used
>>                                                                 for
>>                                                                 graphics
>>                                                                 as
>>                                                                 well
>>                                                                 as
>>                                                                 for
>>                                                                 plain
>>                                                                 compute
>>                                                                 tasks
>>                                                                 (VK_QUEUE_COMPUTE_BIT).
>>
>>
>>                                                                 Sincerely
>>                                                                 yours,
>>                                                                 Serguei
>>                                                                 Sagalovitch
>>
>>
>>
>>                                                                 From:
>>                                                                 amd-gfx
>>                                                                 <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
>>                                                                 on
>>                                                                 behalf of
>>                                                                 Andres
>>                                                                 Rodriguez
>>                                                                 <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org
>>                                                                 <mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>>
>>                                                                 Sent:
>>                                                                 December
>>                                                                 16,
>>                                                                 2016
>>                                                                 6:15 PM
>>                                                                 To:
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 Subject:
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in
>>                                                                 amdgpu
>>
>>                                                                 Hi
>>                                                                 Everyone,
>>
>>                                                                 This
>>                                                                 RFC
>>                                                                 is
>>                                                                 also
>>                                                                 available
>>                                                                 as a
>>                                                                 gist
>>                                                                 here:
>>                                                                 https://gist.github.com/lostgoat/7000432cd6864265dbc2c3ab93204249
>>                                                                 <https://gist.github.com/lostgoat/7000432cd6864265dbc2c3ab93204249>
>>
>>
>>
>>
>>
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>                                                                 gist.github.com
>>                                                                 <http://gist.github.com>
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>
>>
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>                                                                 gist.github.com
>>                                                                 <http://gist.github.com>
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>
>>
>>
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>                                                                 gist.github.com
>>                                                                 <http://gist.github.com>
>>                                                                 [RFC]
>>                                                                 Mechanism
>>                                                                 for
>>                                                                 high
>>                                                                 priority
>>                                                                 scheduling
>>                                                                 in amdgpu
>>
>>
>>                                                                 We
>>                                                                 are
>>                                                                 interested
>>                                                                 in
>>                                                                 feedback
>>                                                                 for a
>>                                                                 mechanism
>>                                                                 to
>>                                                                 effectively
>>                                                                 schedule
>>                                                                 high
>>                                                                 priority
>>                                                                 VR
>>                                                                 reprojection
>>                                                                 tasks
>>                                                                 (also
>>                                                                 referred
>>                                                                 to as
>>                                                                 time-warping)
>>                                                                 for
>>                                                                 Polaris10
>>                                                                 running
>>                                                                 on
>>                                                                 the
>>                                                                 amdgpu
>>                                                                 kernel
>>                                                                 driver.
>>
>>                                                                 Brief
>>                                                                 context:
>>                                                                 --------------
>>
>>                                                                 The
>>                                                                 main
>>                                                                 objective
>>                                                                 of
>>                                                                 reprojection
>>                                                                 is to
>>                                                                 avoid
>>                                                                 motion
>>                                                                 sickness
>>                                                                 for VR
>>                                                                 users in
>>                                                                 scenarios
>>                                                                 where
>>                                                                 the
>>                                                                 game
>>                                                                 or
>>                                                                 application
>>                                                                 would
>>                                                                 fail
>>                                                                 to finish
>>                                                                 rendering
>>                                                                 a new
>>                                                                 frame
>>                                                                 in
>>                                                                 time
>>                                                                 for
>>                                                                 the
>>                                                                 next
>>                                                                 VBLANK.
>>                                                                 When
>>                                                                 this
>>                                                                 happens,
>>                                                                 the
>>                                                                 user's
>>                                                                 head
>>                                                                 movements
>>                                                                 are
>>                                                                 not
>>                                                                 reflected
>>                                                                 on
>>                                                                 the
>>                                                                 Head
>>                                                                 Mounted
>>                                                                 Display
>>                                                                 (HMD)
>>                                                                 for the
>>                                                                 duration
>>                                                                 of an
>>                                                                 extra
>>                                                                 frame.
>>                                                                 This
>>                                                                 extended
>>                                                                 mismatch
>>                                                                 between
>>                                                                 the
>>                                                                 inner ear
>>                                                                 and the
>>                                                                 eyes may
>>                                                                 cause
>>                                                                 the
>>                                                                 user
>>                                                                 to
>>                                                                 experience
>>                                                                 motion
>>                                                                 sickness.
>>
>>                                                                 The
>>                                                                 VR
>>                                                                 compositor
>>                                                                 deals
>>                                                                 with
>>                                                                 this
>>                                                                 problem
>>                                                                 by
>>                                                                 fabricating
>>                                                                 a
>>                                                                 new frame
>>                                                                 using the
>>                                                                 user's
>>                                                                 updated
>>                                                                 head
>>                                                                 position
>>                                                                 in
>>                                                                 combination
>>                                                                 with the
>>                                                                 previous
>>                                                                 frames.
>>                                                                 This
>>                                                                 avoids
>>                                                                 a
>>                                                                 prolonged
>>                                                                 mismatch
>>                                                                 between
>>                                                                 the
>>                                                                 HMD
>>                                                                 output
>>                                                                 and the
>>                                                                 inner
>>                                                                 ear.
>>
>>                                                                 Because
>>                                                                 of
>>                                                                 the
>>                                                                 adverse
>>                                                                 effects
>>                                                                 on
>>                                                                 the
>>                                                                 user,
>>                                                                 we
>>                                                                 require
>>                                                                 high
>>                                                                 confidence
>>                                                                 that the
>>                                                                 reprojection
>>                                                                 task
>>                                                                 will
>>                                                                 complete
>>                                                                 before
>>                                                                 the
>>                                                                 VBLANK
>>                                                                 interval.
>>                                                                 Even if
>>                                                                 the
>>                                                                 GFX pipe
>>                                                                 is
>>                                                                 currently
>>                                                                 full
>>                                                                 of
>>                                                                 work
>>                                                                 from
>>                                                                 the
>>                                                                 game/application
>>                                                                 (which
>>                                                                 is most
>>                                                                 likely
>>                                                                 the
>>                                                                 case).
>>
>>                                                                 For
>>                                                                 more
>>                                                                 details
>>                                                                 and
>>                                                                 illustrations,
>>                                                                 please
>>                                                                 refer
>>                                                                 to the
>>                                                                 following
>>                                                                 document:
>>                                                                 https://community.amd.com/community/gaming/blog/2016/03/28/asynchronous-shaders-evolved
>>                                                                 <https://community.amd.com/community/gaming/blog/2016/03/28/asynchronous-shaders-evolved>
>>
>>
>>
>>
>>
>>                                                                 Gaming:
>>                                                                 Asynchronous
>>                                                                 Shaders
>>                                                                 Evolved
>>                                                                 |
>>                                                                 Community
>>                                                                 community.amd.com
>>                                                                 <http://community.amd.com>
>>                                                                 One
>>                                                                 of
>>                                                                 the
>>                                                                 most
>>                                                                 exciting
>>                                                                 new
>>                                                                 developments
>>                                                                 in
>>                                                                 GPU
>>                                                                 technology
>>                                                                 over the
>>                                                                 past
>>                                                                 year
>>                                                                 has
>>                                                                 been
>>                                                                 the
>>                                                                 adoption
>>                                                                 of
>>                                                                 asynchronous
>>                                                                 shaders,
>>                                                                 which can
>>                                                                 make
>>                                                                 more
>>                                                                 efficient
>>                                                                 use
>>                                                                 of ...
>>
>>
>>
>>                                                                 Gaming:
>>                                                                 Asynchronous
>>                                                                 Shaders
>>                                                                 Evolved
>>                                                                 |
>>                                                                 Community
>>                                                                 community.amd.com
>>                                                                 <http://community.amd.com>
>>                                                                 One
>>                                                                 of
>>                                                                 the
>>                                                                 most
>>                                                                 exciting
>>                                                                 new
>>                                                                 developments
>>                                                                 in
>>                                                                 GPU
>>                                                                 technology
>>                                                                 over the
>>                                                                 past
>>                                                                 year
>>                                                                 has
>>                                                                 been
>>                                                                 the
>>                                                                 adoption
>>                                                                 of
>>                                                                 asynchronous
>>                                                                 shaders,
>>                                                                 which can
>>                                                                 make
>>                                                                 more
>>                                                                 efficient
>>                                                                 use
>>                                                                 of ...
>>
>>
>>
>>                                                                 Gaming:
>>                                                                 Asynchronous
>>                                                                 Shaders
>>                                                                 Evolved
>>                                                                 |
>>                                                                 Community
>>                                                                 community.amd.com
>>                                                                 <http://community.amd.com>
>>                                                                 One
>>                                                                 of
>>                                                                 the
>>                                                                 most
>>                                                                 exciting
>>                                                                 new
>>                                                                 developments
>>                                                                 in
>>                                                                 GPU
>>                                                                 technology
>>                                                                 over the
>>                                                                 past
>>                                                                 year
>>                                                                 has
>>                                                                 been
>>                                                                 the
>>                                                                 adoption
>>                                                                 of
>>                                                                 asynchronous
>>                                                                 shaders,
>>                                                                 which can
>>                                                                 make
>>                                                                 more
>>                                                                 efficient
>>                                                                 use
>>                                                                 of ...
>>
>>
>>                                                                 Requirements:
>>                                                                 -------------
>>
>>                                                                 The
>>                                                                 mechanism
>>                                                                 must
>>                                                                 expose
>>                                                                 the
>>                                                                 following
>>                                                                 functionaility:
>>
>>                                                                     *
>>                                                                 Job
>>                                                                 round
>>                                                                 trip
>>                                                                 time
>>                                                                 must
>>                                                                 be
>>                                                                 predictable,
>>                                                                 from
>>                                                                 submission
>>                                                                 to
>>                                                                 fence
>>                                                                 signal
>>
>>                                                                     *
>>                                                                 The
>>                                                                 mechanism
>>                                                                 must
>>                                                                 support
>>                                                                 compute
>>                                                                 workloads.
>>
>>                                                                 Goals:
>>                                                                 ------
>>
>>                                                                     *
>>                                                                 The
>>                                                                 mechanism
>>                                                                 should
>>                                                                 provide
>>                                                                 low
>>                                                                 submission
>>                                                                 latencies
>>
>>                                                                 Test:
>>                                                                 submitting
>>                                                                 a NOP
>>                                                                 packet
>>                                                                 through
>>                                                                 the
>>                                                                 mechanism
>>                                                                 on busy
>>                                                                 hardware
>>                                                                 should
>>                                                                 be
>>                                                                 equivalent
>>                                                                 to
>>                                                                 submitting
>>                                                                 a NOP
>>                                                                 on
>>                                                                 idle
>>                                                                 hardware.
>>
>>                                                                 Nice
>>                                                                 to have:
>>                                                                 -------------
>>
>>                                                                     *
>>                                                                 The
>>                                                                 mechanism
>>                                                                 should
>>                                                                 also
>>                                                                 support
>>                                                                 GFX
>>                                                                 workloads.
>>
>>                                                                 My
>>                                                                 understanding
>>                                                                 is
>>                                                                 that
>>                                                                 with
>>                                                                 the
>>                                                                 current
>>                                                                 hardware
>>                                                                 capabilities
>>                                                                 in
>>                                                                 Polaris10
>>                                                                 we
>>                                                                 will
>>                                                                 not
>>                                                                 be
>>                                                                 able
>>                                                                 to
>>                                                                 provide
>>                                                                 a
>>                                                                 solution
>>                                                                 compatible
>>                                                                 with GFX
>>                                                                 worloads.
>>
>>                                                                 But I
>>                                                                 would
>>                                                                 love
>>                                                                 to
>>                                                                 hear
>>                                                                 otherwise.
>>                                                                 So if
>>                                                                 anyone
>>                                                                 has an
>>                                                                 idea,
>>                                                                 approach
>>                                                                 or
>>                                                                 suggestion
>>                                                                 that
>>                                                                 will
>>                                                                 also
>>                                                                 be
>>                                                                 compatible
>>                                                                 with
>>                                                                 the
>>                                                                 GFX ring,
>>                                                                 please
>>                                                                 let
>>                                                                 us know
>>                                                                 about it.
>>
>>                                                                     *
>>                                                                 The
>>                                                                 above
>>                                                                 guarantees
>>                                                                 should
>>                                                                 also
>>                                                                 be
>>                                                                 respected
>>                                                                 by
>>                                                                 amdkfd
>>                                                                 workloads
>>
>>                                                                 Would
>>                                                                 be
>>                                                                 good
>>                                                                 to
>>                                                                 have
>>                                                                 for
>>                                                                 consistency,
>>                                                                 but
>>                                                                 not
>>                                                                 strictly
>>                                                                 necessary
>>                                                                 as
>>                                                                 users
>>                                                                 running
>>                                                                 games
>>                                                                 are
>>                                                                 not
>>                                                                 traditionally
>>                                                                 running
>>                                                                 HPC
>>                                                                 workloads
>>                                                                 in the
>>                                                                 background.
>>
>>                                                                 Proposed
>>                                                                 approach:
>>                                                                 ------------------
>>
>>                                                                 Similar
>>                                                                 to
>>                                                                 the
>>                                                                 windows
>>                                                                 driver,
>>                                                                 we
>>                                                                 could
>>                                                                 expose
>>                                                                 a high
>>                                                                 priority
>>                                                                 compute
>>                                                                 queue to
>>                                                                 userspace.
>>
>>                                                                 Submissions
>>                                                                 to
>>                                                                 this
>>                                                                 compute
>>                                                                 queue
>>                                                                 will
>>                                                                 be
>>                                                                 scheduled
>>                                                                 with
>>                                                                 high
>>                                                                 priority,
>>                                                                 and may
>>                                                                 acquire
>>                                                                 hardware
>>                                                                 resources
>>                                                                 previously
>>                                                                 in
>>                                                                 use
>>                                                                 by other
>>                                                                 queues.
>>
>>                                                                 This
>>                                                                 can
>>                                                                 be
>>                                                                 achieved
>>                                                                 by
>>                                                                 taking
>>                                                                 advantage
>>                                                                 of
>>                                                                 the
>>                                                                 'priority'
>>                                                                 field in
>>                                                                 the HQDs
>>                                                                 and
>>                                                                 could
>>                                                                 be
>>                                                                 programmed
>>                                                                 by
>>                                                                 amdgpu
>>                                                                 or
>>                                                                 the
>>                                                                 amdgpu
>>                                                                 scheduler.
>>                                                                 The
>>                                                                 relevant
>>                                                                 register
>>                                                                 fields
>>                                                                 are:
>>                                                                      
>>                                                                   *
>>                                                                 mmCP_HQD_PIPE_PRIORITY
>>                                                                      
>>                                                                   *
>>                                                                 mmCP_HQD_QUEUE_PRIORITY
>>
>>                                                                 Implementation
>>                                                                 approach
>>                                                                 1 -
>>                                                                 static
>>                                                                 partitioning:
>>                                                                 ------------------------------------------------
>>
>>                                                                 The
>>                                                                 amdgpu
>>                                                                 driver
>>                                                                 currently
>>                                                                 controls
>>                                                                 8
>>                                                                 compute
>>                                                                 queues
>>                                                                 from
>>                                                                 pipe0.
>>                                                                 We can
>>                                                                 statically
>>                                                                 partition
>>                                                                 these
>>                                                                 as
>>                                                                 follows:
>>                                                                      
>>                                                                   *
>>                                                                 7x
>>                                                                 regular
>>                                                                      
>>                                                                   *
>>                                                                 1x
>>                                                                 high
>>                                                                 priority
>>
>>                                                                 The
>>                                                                 relevant
>>                                                                 priorities
>>                                                                 can
>>                                                                 be
>>                                                                 set
>>                                                                 so
>>                                                                 that
>>                                                                 submissions
>>                                                                 to
>>                                                                 the high
>>                                                                 priority
>>                                                                 ring
>>                                                                 will
>>                                                                 starve
>>                                                                 the
>>                                                                 other
>>                                                                 compute
>>                                                                 rings
>>                                                                 and
>>                                                                 the
>>                                                                 GFX ring.
>>
>>                                                                 The
>>                                                                 amdgpu
>>                                                                 scheduler
>>                                                                 will
>>                                                                 only
>>                                                                 place
>>                                                                 jobs
>>                                                                 into
>>                                                                 the high
>>                                                                 priority
>>                                                                 rings
>>                                                                 if the
>>                                                                 context
>>                                                                 is
>>                                                                 marked
>>                                                                 as
>>                                                                 high
>>                                                                 priority.
>>                                                                 And a
>>                                                                 corresponding
>>                                                                 priority
>>                                                                 should be
>>                                                                 added
>>                                                                 to
>>                                                                 keep
>>                                                                 track
>>                                                                 of
>>                                                                 this
>>                                                                 information:
>>                                                                    
>>                                                                  *
>>                                                                 AMD_SCHED_PRIORITY_KERNEL
>>                                                                    
>>                                                                  * ->
>>                                                                 AMD_SCHED_PRIORITY_HIGH
>>                                                                    
>>                                                                  *
>>                                                                 AMD_SCHED_PRIORITY_NORMAL
>>
>>                                                                 The
>>                                                                 user
>>                                                                 will
>>                                                                 request
>>                                                                 a
>>                                                                 high
>>                                                                 priority
>>                                                                 context
>>                                                                 by
>>                                                                 setting
>>                                                                 an
>>                                                                 appropriate
>>                                                                 flag
>>                                                                 in
>>                                                                 drm_amdgpu_ctx_in
>>                                                                 (AMDGPU_CTX_HIGH_PRIORITY
>>                                                                 or
>>                                                                 similar):
>>                                                                 https://github.com/torvalds/linux/blob/master/include/uapi/drm/amdgpu_drm.h#L163
>>                                                                 <https://github.com/torvalds/linux/blob/master/include/uapi/drm/amdgpu_drm.h#L163>
>>
>>
>>
>>
>>                                                                 The
>>                                                                 setting
>>                                                                 is in
>>                                                                 a per
>>                                                                 context
>>                                                                 level
>>                                                                 so
>>                                                                 that
>>                                                                 we can:
>>                                                                     *
>>                                                                 Maintain
>>                                                                 a
>>                                                                 consistent
>>                                                                 FIFO
>>                                                                 ordering
>>                                                                 of all
>>                                                                 submissions
>>                                                                 to a
>>                                                                 context
>>                                                                     *
>>                                                                 Create
>>                                                                 high
>>                                                                 priority
>>                                                                 and
>>                                                                 non-high
>>                                                                 priority
>>                                                                 contexts
>>                                                                 in
>>                                                                 the same
>>                                                                 process
>>
>>                                                                 Implementation
>>                                                                 approach
>>                                                                 2 -
>>                                                                 dynamic
>>                                                                 priority
>>                                                                 programming:
>>                                                                 ---------------------------------------------------------
>>
>>                                                                 Similar
>>                                                                 to
>>                                                                 the
>>                                                                 above,
>>                                                                 but
>>                                                                 instead
>>                                                                 of
>>                                                                 programming
>>                                                                 the
>>                                                                 priorities
>>                                                                 and
>>                                                                 amdgpu_init()
>>                                                                 time,
>>                                                                 the
>>                                                                 SW
>>                                                                 scheduler
>>                                                                 will
>>                                                                 reprogram
>>                                                                 the
>>                                                                 queue
>>                                                                 priorities
>>                                                                 dynamically
>>                                                                 when
>>                                                                 scheduling
>>                                                                 a task.
>>
>>                                                                 This
>>                                                                 would
>>                                                                 involve
>>                                                                 having
>>                                                                 a
>>                                                                 hardware
>>                                                                 specific
>>                                                                 callback
>>                                                                 from
>>                                                                 the
>>                                                                 scheduler
>>                                                                 to
>>                                                                 set
>>                                                                 the
>>                                                                 appropriate
>>                                                                 queue
>>                                                                 priority:
>>                                                                 set_priority(int
>>                                                                 ring,
>>                                                                 int
>>                                                                 index,
>>                                                                 int
>>                                                                 priority)
>>
>>                                                                 During
>>                                                                 this
>>                                                                 callback
>>                                                                 we
>>                                                                 would
>>                                                                 have
>>                                                                 to
>>                                                                 grab
>>                                                                 the
>>                                                                 SRBM
>>                                                                 mutex
>>                                                                 to
>>                                                                 perform
>>                                                                 the
>>                                                                 appropriate
>>                                                                 HW
>>                                                                 programming,
>>                                                                 and
>>                                                                 I'm
>>                                                                 not
>>                                                                 really
>>                                                                 sure
>>                                                                 if
>>                                                                 that is
>>                                                                 something
>>                                                                 we
>>                                                                 should
>>                                                                 be
>>                                                                 doing
>>                                                                 from
>>                                                                 the
>>                                                                 scheduler.
>>
>>                                                                 On
>>                                                                 the
>>                                                                 positive
>>                                                                 side,
>>                                                                 this
>>                                                                 approach
>>                                                                 would
>>                                                                 allow
>>                                                                 us to
>>                                                                 program
>>                                                                 a
>>                                                                 range of
>>                                                                 priorities
>>                                                                 for
>>                                                                 jobs
>>                                                                 instead
>>                                                                 of a
>>                                                                 single
>>                                                                 "high
>>                                                                 priority"
>>                                                                 value",
>>                                                                 achieving
>>                                                                 something
>>                                                                 similar
>>                                                                 to
>>                                                                 the
>>                                                                 niceness
>>                                                                 API
>>                                                                 available
>>                                                                 for CPU
>>                                                                 scheduling.
>>
>>                                                                 I'm
>>                                                                 not
>>                                                                 sure
>>                                                                 if
>>                                                                 this
>>                                                                 flexibility
>>                                                                 is
>>                                                                 something
>>                                                                 that
>>                                                                 we would
>>                                                                 need for
>>                                                                 our use
>>                                                                 case,
>>                                                                 but
>>                                                                 it
>>                                                                 might
>>                                                                 be
>>                                                                 useful
>>                                                                 in
>>                                                                 other
>>                                                                 scenarios
>>                                                                 (multiple
>>                                                                 users
>>                                                                 sharing
>>                                                                 compute
>>                                                                 time
>>                                                                 on a
>>                                                                 server).
>>
>>                                                                 This
>>                                                                 approach
>>                                                                 would
>>                                                                 require
>>                                                                 a new
>>                                                                 int
>>                                                                 field in
>>                                                                 drm_amdgpu_ctx_in,
>>                                                                 or
>>                                                                 repurposing
>>                                                                 of
>>                                                                 the
>>                                                                 flags
>>                                                                 field.
>>
>>                                                                 Known
>>                                                                 current
>>                                                                 obstacles:
>>                                                                 ------------------------
>>
>>                                                                 The
>>                                                                 SQ is
>>                                                                 currently
>>                                                                 programmed
>>                                                                 to
>>                                                                 disregard
>>                                                                 the HQD
>>                                                                 priorities,
>>                                                                 and
>>                                                                 instead
>>                                                                 it picks
>>                                                                 jobs
>>                                                                 at
>>                                                                 random.
>>                                                                 Settings
>>                                                                 from
>>                                                                 the
>>                                                                 shader
>>                                                                 itself
>>                                                                 are also
>>                                                                 disregarded
>>                                                                 as
>>                                                                 this is
>>                                                                 considered
>>                                                                 a
>>                                                                 privileged
>>                                                                 field.
>>
>>                                                                 Effectively
>>                                                                 we
>>                                                                 can
>>                                                                 get
>>                                                                 our
>>                                                                 compute
>>                                                                 wavefront
>>                                                                 launched
>>                                                                 ASAP,
>>                                                                 but we
>>                                                                 might
>>                                                                 not
>>                                                                 get the
>>                                                                 time
>>                                                                 we
>>                                                                 need
>>                                                                 on
>>                                                                 the SQ.
>>
>>                                                                 The
>>                                                                 current
>>                                                                 programming
>>                                                                 would
>>                                                                 have
>>                                                                 to be
>>                                                                 changed
>>                                                                 to allow
>>                                                                 priority
>>                                                                 propagation
>>                                                                 from
>>                                                                 the
>>                                                                 HQD
>>                                                                 into
>>                                                                 the SQ.
>>
>>                                                                 Generic
>>                                                                 approach
>>                                                                 for
>>                                                                 all
>>                                                                 HW IPs:
>>                                                                 --------------------------------
>>
>>                                                                 For
>>                                                                 consistency
>>                                                                 purposes,
>>                                                                 the
>>                                                                 high
>>                                                                 priority
>>                                                                 context
>>                                                                 can be
>>                                                                 enabled
>>                                                                 for
>>                                                                 all
>>                                                                 HW IPs
>>                                                                 with
>>                                                                 support
>>                                                                 of
>>                                                                 the
>>                                                                 SW
>>                                                                 scheduler.
>>                                                                 This
>>                                                                 will
>>                                                                 function
>>                                                                 similarly
>>                                                                 to the
>>                                                                 current
>>                                                                 AMD_SCHED_PRIORITY_KERNEL
>>                                                                 priority,
>>                                                                 where
>>                                                                 the
>>                                                                 job
>>                                                                 can jump
>>                                                                 ahead of
>>                                                                 anything
>>                                                                 not
>>                                                                 commited
>>                                                                 to
>>                                                                 the
>>                                                                 HW queue.
>>
>>                                                                 The
>>                                                                 benefits
>>                                                                 of
>>                                                                 requesting
>>                                                                 a
>>                                                                 high
>>                                                                 priority
>>                                                                 context
>>                                                                 for a
>>                                                                 non-compute
>>                                                                 queue
>>                                                                 will
>>                                                                 be
>>                                                                 lesser
>>                                                                 (e.g.
>>                                                                 up to
>>                                                                 10s
>>                                                                 of
>>                                                                 wait
>>                                                                 time
>>                                                                 if a
>>                                                                 GFX
>>                                                                 command
>>                                                                 is
>>                                                                 stuck in
>>                                                                 front of
>>                                                                 you),
>>                                                                 but
>>                                                                 having
>>                                                                 the
>>                                                                 API
>>                                                                 in
>>                                                                 place
>>                                                                 will
>>                                                                 allow
>>                                                                 us to
>>                                                                 easily
>>                                                                 improve
>>                                                                 the
>>                                                                 implementation
>>                                                                 in
>>                                                                 the
>>                                                                 future
>>                                                                 as
>>                                                                 new
>>                                                                 features
>>                                                                 become
>>                                                                 available
>>                                                                 in new
>>                                                                 hardware.
>>
>>                                                                 Future
>>                                                                 steps:
>>                                                                 -------------
>>
>>                                                                 Once
>>                                                                 we
>>                                                                 have
>>                                                                 an
>>                                                                 approach
>>                                                                 settled,
>>                                                                 I can
>>                                                                 take
>>                                                                 care
>>                                                                 of the
>>                                                                 implementation.
>>
>>                                                                 Also,
>>                                                                 once
>>                                                                 the
>>                                                                 interface
>>                                                                 is
>>                                                                 mostly
>>                                                                 decided,
>>                                                                 we
>>                                                                 can start
>>                                                                 thinking
>>                                                                 about
>>                                                                 exposing
>>                                                                 the
>>                                                                 high
>>                                                                 priority
>>                                                                 queue
>>                                                                 through
>>                                                                 radv.
>>
>>                                                                 Request
>>                                                                 for
>>                                                                 feedback:
>>                                                                 ---------------------
>>
>>                                                                 We
>>                                                                 aren't
>>                                                                 married
>>                                                                 to
>>                                                                 any
>>                                                                 of
>>                                                                 the
>>                                                                 approaches
>>                                                                 outlined
>>                                                                 above.
>>                                                                 Our goal
>>                                                                 is to
>>                                                                 obtain
>>                                                                 a
>>                                                                 mechanism
>>                                                                 that
>>                                                                 will
>>                                                                 allow
>>                                                                 us to
>>                                                                 complete
>>                                                                 the
>>                                                                 reprojection
>>                                                                 job
>>                                                                 within a
>>                                                                 predictable
>>                                                                 amount
>>                                                                 of
>>                                                                 time.
>>                                                                 So if
>>                                                                 anyone
>>                                                                 anyone
>>                                                                 has any
>>                                                                 suggestions
>>                                                                 for
>>                                                                 improvements
>>                                                                 or
>>                                                                 alternative
>>                                                                 strategies
>>                                                                 we
>>                                                                 are
>>                                                                 more than
>>                                                                 happy
>>                                                                 to hear
>>                                                                 them.
>>
>>                                                                 If
>>                                                                 any
>>                                                                 of
>>                                                                 the
>>                                                                 technical
>>                                                                 information
>>                                                                 above
>>                                                                 is also
>>                                                                 incorrect,
>>                                                                 feel
>>                                                                 free
>>                                                                 to point
>>                                                                 out
>>                                                                 my
>>                                                                 misunderstandings.
>>
>>                                                                 Looking
>>                                                                 forward
>>                                                                 to
>>                                                                 hearing
>>                                                                 from you.
>>
>>                                                                 Regards,
>>                                                                 Andres
>>
>>                                                                 _______________________________________________
>>                                                                 amd-gfx
>>                                                                 mailing
>>                                                                 list
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>                                                                 <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>
>>
>>                                                                 amd-gfx
>>                                                                 Info
>>                                                                 Page
>>                                                                 -
>>                                                                 lists.freedesktop.org
>>                                                                 <http://lists.freedesktop.org>
>>                                                                 lists.freedesktop.org
>>                                                                 <http://lists.freedesktop.org>
>>                                                                 To
>>                                                                 see
>>                                                                 the
>>                                                                 collection
>>                                                                 of
>>                                                                 prior
>>                                                                 postings
>>                                                                 to
>>                                                                 the list,
>>                                                                 visit the
>>                                                                 amd-gfx
>>                                                                 Archives.
>>                                                                 Using
>>                                                                 amd-gfx:
>>                                                                 To
>>                                                                 post
>>                                                                 a
>>                                                                 message
>>                                                                 to all
>>                                                                 the list
>>                                                                 members,
>>                                                                 send
>>                                                                 email ...
>>
>>
>>
>>                                                                 amd-gfx
>>                                                                 Info
>>                                                                 Page
>>                                                                 -
>>                                                                 lists.freedesktop.org
>>                                                                 <http://lists.freedesktop.org>
>>                                                                 lists.freedesktop.org
>>                                                                 <http://lists.freedesktop.org>
>>                                                                 To
>>                                                                 see
>>                                                                 the
>>                                                                 collection
>>                                                                 of
>>                                                                 prior
>>                                                                 postings
>>                                                                 to
>>                                                                 the list,
>>                                                                 visit the
>>                                                                 amd-gfx
>>                                                                 Archives.
>>                                                                 Using
>>                                                                 amd-gfx:
>>                                                                 To
>>                                                                 post
>>                                                                 a
>>                                                                 message
>>                                                                 to all
>>                                                                 the list
>>                                                                 members,
>>                                                                 send
>>                                                                 email ...
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>                                                                 _______________________________________________
>>                                                                 amd-gfx
>>                                                                 mailing
>>                                                                 list
>>                                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                                 https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>                                                                 <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>
>>
>>                                                             _______________________________________________
>>                                                             amd-gfx
>>                                                             mailing list
>>                                                             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                             https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>                                                             <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>
>>
>>
>>
>>                                                 _______________________________________________
>>                                                 amd-gfx mailing list
>>                                                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                                 https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>                                                 <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>
>>
>>
>>
>>                                     Sincerely yours,
>>                                     Serguei Sagalovitch
>>
>>                                     _______________________________________________
>>                                     amd-gfx mailing list
>>                                     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>                                     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>                                     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>                                     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>
>>
>>
>>
>>
>>
>>
>>                 Sincerely yours,
>>                 Serguei Sagalovitch
>>
>>
>>
>>
>>
>


--------------8A0F7AEF1F662A95B70010BF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Indeed a couple of nice numbers.<br>
      <br>
      <blockquote type="cite"><span
          style="font-family:monospace,monospace">but everything already
          commited<br>
          to the HW queue is executed in strict FIFO order.</span></blockquote>
      Well actually if we get a high priority submission we could
      preempt/abort everything on the ring buffer before it in theory.<br>
      <br>
      Probably not as fine granularity as the hardware scheduler, but
      might be easier to get working.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 26.12.2016 um 03:26 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:58607FDF.2080200-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      Nice experiment, which is exactly SW scheduler can provide.<br>
      And as you said "<span style="font-family:monospace,monospace">I.e.
        your context can be scheduled into the<br>
        HW queue ahead of any other context, but everything already
        commited<br>
        to the HW queue is executed in strict FIFO order.</span>"<br>
      <br>
      If you want to keep <span style="font-family:monospace,monospace">consistent</span>
      latency, which will need to enable hw priority queue feature.<br>
      <br>
      Regards,<br>
      David Zhou<br>
      <br>
      <div class="moz-cite-prefix">On 2016年12月24日 06:20, Andres
        Rodriguez wrote:<br>
      </div>
      <blockquote
cite="mid:CAFQ_0eHg=Kf5qV50cgm51m6bTcMYdkgRXkT-sykJnYNzu3Zzsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
        type="cite">
        <div dir="ltr">
          <div>
            <div><span style="font-family:monospace,monospace">Hey John,<br>
                <br>
              </span></div>
            <span style="font-family:monospace,monospace">I've collected
              bit of data using high priority SW scheduler queues,<br>
            </span></div>
          <div><span style="font-family:monospace,monospace">thought you
              might be interested.<br>
            </span></div>
          <div><span style="font-family:monospace,monospace"><br>
              Implementation as per the patch above.<br>
              <br>
              Control test 1<br>
              ==============<br>
              <br>
              Sascha Willems mesh sample running on its own at regular
              priority<br>
              <br>
              Results<br>
              -------<br>
              <br>
              Mesh: ~0.14ms per-frame latency<br>
              <br>
              Control test 2<br>
              ==============<br>
              <br>
              Two Sascha Willems mesh sample running on its own at
              regular priority<br>
              <br>
              Results<br>
              -------<br>
              <br>
              Mesh 1: ~0.26ms per-frame latency<br>
              Mesh 2: ~0.26ms per-frame latency<br>
              <br>
              Test 1<br>
              ======<br>
              <br>
              Two Sascha Willems mesh samples running simultaneously.
              One at high<br>
              priority and the other running in a regular priority
              graphics context.<br>
              <br>
              Results<br>
              -------<br>
              <br>
              Mesh High:    0.14 - 0.24ms per-frame latency<br>
              Mesh Regular: 0.24 - 0.40ms per-frame latency<br>
              <br>
              Test 2<br>
              ======<br>
              <br>
              Ten Sascha Willems mesh samples running simultaneously.
              One at high<br>
              priority and the others running in a regular priority
              graphics context.<br>
              <br>
              Results<br>
              -------<br>
              <br>
              Mesh High:    0.14 - 0.8ms per-frame latency<br>
              Mesh Regular: 1.10 - 2.05ms per-frame latency<br>
              <br>
              Test 3<br>
              ======<br>
              <br>
              Two Sascha Willems mesh samples running simultaneously.
              One at high<br>
              priority and the other running in a regular priority
              graphics context.<br>
              <br>
              Also running Unigine Heaven at Exteme preset @ 2560x1600<br>
              <br>
              Results<br>
              -------<br>
              <br>
              Mesh High:     7 - 100ms per-frame latency </span><span
              style="font-family:monospace,monospace"><span
                style="font-family:monospace,monospace"><span
                  style="font-family:monospace,monospace">(Lots of
                  fluctuation)</span></span><br>
              Mesh Regular: 40 - 130ms per-frame latency</span><span
              style="font-family:monospace,monospace"><span
                style="font-family:monospace,monospace"></span><span
                style="font-family:monospace,monospace"><span
                  style="font-family:monospace,monospace"><span
                    style="font-family:monospace,monospace"> (Lots of
                    fluctuation)<br>
                  </span></span></span>Unigine Heaven: 20-40 fps<br>
              <br>
            </span><br>
            <span style="font-family:monospace,monospace"><span
                style="font-family:monospace,monospace">Test 4<br>
                ======<br>
                <br>
                Two Sascha Willems mesh samples running simultaneously.
                One at high<br>
                priority and the other running in a regular priority
                graphics context.<br>
                <br>
                Also running Talos Principle @ 4K<br>
                <br>
                Results<br>
                -------<br>
                <br>
                Mesh High:    0.14 - 3.97ms per-frame latency (Mostly
                floats ~0.4ms)<br>
                Mesh Regular: 0.43 - 8.11ms per-frame latency (Lots of
                fluctuation)<br>
                Talos: 24.8 fps AVG</span><br>
              <br>
              Observations<br>
              ============<br>
              <br>
              The high priority queue based on the SW scheduler provides
              significant<br>
              gains when paired with tasks that submit short duration
              commands into<br>
              the queue. This can be observed in tests 1 and 2.<br>
              <br>
              When the pipe is full of long running commands, the
              effects are dampened.<br>
              As observed in test 3, the per-frame latency suffers very
              large spikes,<br>
              and the latencies are very inconsistent.<br>
              <br>
              Talos seems to be a better behaved game. It may be
              submitting shorter<br>
              draw commands and the SW scheduler is able to interleave
              the rest of<br>
              the work.<br>
              <br>
              The results seem consistent with the hypothetical
              advantages the SW<br>
              scheduler should provide. I.e. your context can be
              scheduled into the<br>
              HW queue ahead of any other context, but everything
              already commited<br>
              to the HW queue is executed in strict FIFO order.<br>
              <br>
            </span></div>
          <div><span style="font-family:monospace,monospace">In order to
              deal with cases similar to Test 3, we will need to take<br>
            </span></div>
          <div><span style="font-family:monospace,monospace">advantage
              of further features.<br>
              <br>
              Notes<br>
              =====<br>
              <br>
              - Tests were run multiple times, and reboots were
              performed during tests.<br>
              - The mesh sample isn't really designed for benchmarking,
              but it should<br>
                be decent for ballpark figures<br>
              - The high priority mesh app was run with default niceness
              and also niceness<br>
                at -20. This had no effect on the results, so it was not
              added above.<br>
              - CPU usage was not saturated while running the tests<br>
              <br>
            </span></div>
          <div><span style="font-family:monospace,monospace">Regards,<br>
            </span></div>
          <div><span style="font-family:monospace,monospace">Andres<br>
            </span></div>
          <br>
        </div>
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Fri, Dec 23, 2016 at 1:18 PM,
            Pierre-Loup A. Griffais <span dir="ltr">&lt;<a
                moz-do-not-send="true"
                href="mailto:pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org"
                target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org">pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org</a></a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">I hate
              to keep bringing up display topics in an unrelated
              conversation, but I'm not sure where you got "Application
              -&gt; X server -&gt; compositor -&gt; X server" from. As I
              was saying before, we need to be presenting directly to
              the HMD display as no display server can be in the way,
              both for latency but also quality of service reasons (a
              buggy application cannot be allowed to accidentally
              display undistorted rendering into the HMD); we intend to
              do the necessary work for this, and the extent of X's (or
              a Wayland implementation, or any other display server)
              involvment will be to participate enough to know that the
              HMD display is off-limits. If you have more questions on
              the display aspect, or VR rendering in general, I'm happy
              to try to address them out-of-band from this conversation.
              <div class="HOEnZb">
                <div class="h5"><br>
                  <br>
                  On 12/23/2016 02:54 AM, Christian König wrote:<br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      But yes, in general you don't want another
                      compositor in the way, so<br>
                      we'll be acquiring the HMD display directly,
                      separate from any desktop<br>
                      or display server.<br>
                    </blockquote>
                    Assuming that the the HMD is attached to the
                    rendering device in some<br>
                    way you have the X server and the Compositor which
                    both try to be DRM<br>
                    master at the same time.<br>
                    <br>
                    Please correct me if that was fixed in the meantime,
                    but that sounds<br>
                    like it will simply not work. Or is this what Andres
                    mention below Dave<br>
                    is working on ?.<br>
                    <br>
                    Additional to that a compositor in combination with
                    X is a bit counter<br>
                    productive when you want to keep the latency low.<br>
                    <br>
                    E.g. the "normal" flow of a GL or Vulkan surface
                    filled with rendered<br>
                    data to be displayed is from the Application -&gt; X
                    server -&gt; compositor<br>
                    -&gt; X server.<br>
                    <br>
                    The extra step between X server and compositor just
                    means extra latency<br>
                    and for this use case you probably don't want that.<br>
                    <br>
                    Targeting something like Wayland and when you need X
                    compatibility<br>
                    XWayland sounds like the much better idea.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 22.12.2016 um 20:54 schrieb Pierre-Loup A.
                    Griffais:<br>
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      Display concerns are a separate issue, and as
                      Andres said we have<br>
                      other plans to address. But yes, in general you
                      don't want another<br>
                      compositor in the way, so we'll be acquiring the
                      HMD display directly,<br>
                      separate from any desktop or display server. Same
                      with security, we<br>
                      can have a separate conversation about that when
                      the time comes.<br>
                      <br>
                      On 12/22/2016 08:41 AM, Serguei Sagalovitch wrote:<br>
                      <blockquote class="gmail_quote" style="margin:0 0
                        0 .8ex;border-left:1px #ccc
                        solid;padding-left:1ex"> Andres,<br>
                        <br>
                        Did you measure  latency, etc. impact of __any__
                        compositor?<br>
                        <br>
                        My understanding is that VR has pretty strict
                        requirements related to<br>
                        QoS.<br>
                        <br>
                        Sincerely yours,<br>
                        Serguei Sagalovitch<br>
                        <br>
                        <br>
                        On 2016-12-22 11:35 AM, Andres Rodriguez wrote:<br>
                        <blockquote class="gmail_quote" style="margin:0
                          0 0 .8ex;border-left:1px #ccc
                          solid;padding-left:1ex"> Hey Christian,<br>
                          <br>
                          We are currently interested in X, but with
                          some distros switching to<br>
                          other compositors by default, we also need to
                          consider those.<br>
                          <br>
                          We agree, running the full vrcompositor in
                          root isn't something that<br>
                          we want to do. Too many security concerns.
                          Having a small root helper<br>
                          that does the privilege escalation for us is
                          the initial idea.<br>
                          <br>
                          For a long term approach, Pierre-Loup and Dave
                          are working on dealing<br>
                          with the "two compositors" scenario a little
                          better in DRM+X.<br>
                          Fullscreen isn't really a sufficient approach,
                          since we don't want the<br>
                          HMD to be used as part of the Desktop
                          environment when a VR app is not<br>
                          in use (this is extremely annoying).<br>
                          <br>
                          When the above is settled, we should have an
                          auth mechanism besides<br>
                          DRM_MASTER or DRM_AUTH that allows the
                          vrcompositor to take over the<br>
                          HMD permanently away from X. Re-using that
                          auth method to gate this<br>
                          IOCTL is probably going to be the final
                          solution.<br>
                          <br>
                          I propose to start with ROOT_ONLY since it
                          should allow us to respect<br>
                          kernel IOCTL compatibility guidelines with the
                          most flexibility. Going<br>
                          from a restrictive to a more flexible
                          permission model would be<br>
                          inclusive, but going from a general to a
                          restrictive model may exclude<br>
                          some apps that used to work.<br>
                          <br>
                          Regards,<br>
                          Andres<br>
                          <br>
                          On 12/22/2016 6:42 AM, Christian König wrote:<br>
                          <blockquote class="gmail_quote"
                            style="margin:0 0 0 .8ex;border-left:1px
                            #ccc solid;padding-left:1ex"> Hi Andres,<br>
                            <br>
                            well using root might cause stability and
                            security problems as well.<br>
                            We worked quite hard to avoid exactly this
                            for X.<br>
                            <br>
                            We could make this feature depend on the
                            compositor being DRM master,<br>
                            but for example with X the X server is
                            master (and e.g. can change<br>
                            resolutions etc..) and not the compositor.<br>
                            <br>
                            So another question is also what windowing
                            system (if any) are you<br>
                            planning to use? X, Wayland, Flinger or
                            something completely<br>
                            different ?<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            Am 20.12.2016 um 16:51 schrieb Andres
                            Rodriguez:<br>
                            <blockquote class="gmail_quote"
                              style="margin:0 0 0 .8ex;border-left:1px
                              #ccc solid;padding-left:1ex"> Hi
                              Christian,<br>
                              <br>
                              That is definitely a concern. What we are
                              currently thinking is to<br>
                              make the high priority queues accessible
                              to root only.<br>
                              <br>
                              Therefore is a non-root user attempts to
                              set the high priority flag<br>
                              on context allocation, we would fail the
                              call and return ENOPERM.<br>
                              <br>
                              Regards,<br>
                              Andres<br>
                              <br>
                              <br>
                              On 12/20/2016 7:56 AM, Christian König
                              wrote:<br>
                              <blockquote class="gmail_quote"
                                style="margin:0 0 0 .8ex;border-left:1px
                                #ccc solid;padding-left:1ex">
                                <blockquote class="gmail_quote"
                                  style="margin:0 0 0
                                  .8ex;border-left:1px #ccc
                                  solid;padding-left:1ex"> BTW: If there
                                  is  non-VR application which will use
                                  high-priority<br>
                                  h/w queue then VR application will
                                  suffer.  Any ideas how<br>
                                  to solve it?<br>
                                </blockquote>
                                Yeah, that problem came to my mind as
                                well.<br>
                                <br>
                                Basically we need to restrict those high
                                priority submissions to<br>
                                the VR compositor or otherwise any
                                malfunctioning application could<br>
                                use it.<br>
                                <br>
                                Just think about some WebGL suddenly
                                taking all our rendering away<br>
                                and we won't get anything drawn any
                                more.<br>
                                <br>
                                Alex or Michel any ideas on that?<br>
                                <br>
                                Regards,<br>
                                Christian.<br>
                                <br>
                                Am 19.12.2016 um 15:48 schrieb Serguei
                                Sagalovitch:<br>
                                <blockquote class="gmail_quote"
                                  style="margin:0 0 0
                                  .8ex;border-left:1px #ccc
                                  solid;padding-left:1ex"> &gt; If
                                  compute queue is occupied only by you,
                                  the efficiency<br>
                                  &gt; is equal with setting job queue
                                  to high priority I think.<br>
                                  The only risk is the situation when
                                  graphics will take all<br>
                                  needed CUs. But in any case it should
                                  be very good test.<br>
                                  <br>
                                  Andres/Pierre-Loup,<br>
                                  <br>
                                  Did you try to do it or it is a lot of
                                  work for you?<br>
                                  <br>
                                  <br>
                                  BTW: If there is  non-VR application
                                  which will use high-priority<br>
                                  h/w queue then VR application will
                                  suffer.  Any ideas how<br>
                                  to solve it?<br>
                                  <br>
                                  Sincerely yours,<br>
                                  Serguei Sagalovitch<br>
                                  <br>
                                  On 2016-12-19 12:50 AM, zhoucm1 wrote:<br>
                                  <blockquote class="gmail_quote"
                                    style="margin:0 0 0
                                    .8ex;border-left:1px #ccc
                                    solid;padding-left:1ex"> Do you
                                    encounter the priority issue for
                                    compute queue with<br>
                                    current driver?<br>
                                    <br>
                                    If compute queue is occupied only by
                                    you, the efficiency is equal<br>
                                    with setting job queue to high
                                    priority I think.<br>
                                    <br>
                                    Regards,<br>
                                    David Zhou<br>
                                    <br>
                                    On 2016年12月19日 13:29, Andres
                                    Rodriguez wrote:<br>
                                    <blockquote class="gmail_quote"
                                      style="margin:0 0 0
                                      .8ex;border-left:1px #ccc
                                      solid;padding-left:1ex"> Yes,
                                      vulkan is available on all-open
                                      through the mesa radv UMD.<br>
                                      <br>
                                      I'm not sure if I'm asking for too
                                      much, but if we can<br>
                                      coordinate a similar interface in
                                      radv and amdgpu-pro at the<br>
                                      vulkan level that would be great.<br>
                                      <br>
                                      I'm not sure what that's going to
                                      be yet.<br>
                                      <br>
                                      - Andres<br>
                                      <br>
                                      On 12/19/2016 12:11 AM, zhoucm1
                                      wrote:<br>
                                      <blockquote class="gmail_quote"
                                        style="margin:0 0 0
                                        .8ex;border-left:1px #ccc
                                        solid;padding-left:1ex"> <br>
                                        <br>
                                        On 2016年12月19日 11:33,
                                        Pierre-Loup A. Griffais wrote:<br>
                                        <blockquote class="gmail_quote"
                                          style="margin:0 0 0
                                          .8ex;border-left:1px #ccc
                                          solid;padding-left:1ex"> We're
                                          currently working with the
                                          open stack; I assume that a<br>
                                          mechanism could be exposed by
                                          both open and Pro Vulkan<br>
                                          userspace drivers and that the
                                          amdgpu kernel interface<br>
                                          improvements we would pursue
                                          following this discussion
                                          would<br>
                                          let both drivers take
                                          advantage of the feature,
                                          correct?<br>
                                        </blockquote>
                                        Of course.<br>
                                        Does open stack have Vulkan
                                        support?<br>
                                        <br>
                                        Regards,<br>
                                        David Zhou<br>
                                        <blockquote class="gmail_quote"
                                          style="margin:0 0 0
                                          .8ex;border-left:1px #ccc
                                          solid;padding-left:1ex"> <br>
                                          On 12/18/2016 07:26 PM,
                                          zhoucm1 wrote:<br>
                                          <blockquote
                                            class="gmail_quote"
                                            style="margin:0 0 0
                                            .8ex;border-left:1px #ccc
                                            solid;padding-left:1ex"> By
                                            the way, are you using
                                            all-open driver or
                                            amdgpu-pro<br>
                                            driver?<br>
                                            <br>
                                            +David Mao, who is working
                                            on our Vulkan driver.<br>
                                            <br>
                                            Regards,<br>
                                            David Zhou<br>
                                            <br>
                                            On 2016年12月18日 06:05,
                                            Pierre-Loup A. Griffais
                                            wrote:<br>
                                            <blockquote
                                              class="gmail_quote"
                                              style="margin:0 0 0
                                              .8ex;border-left:1px #ccc
                                              solid;padding-left:1ex">
                                              Hi Serguei,<br>
                                              <br>
                                              I'm also working on the
                                              bringing up our VR runtime
                                              on top of<br>
                                              amgpu;<br>
                                              see replies inline.<br>
                                              <br>
                                              On 12/16/2016 09:05 PM,
                                              Sagalovitch, Serguei
                                              wrote:<br>
                                              <blockquote
                                                class="gmail_quote"
                                                style="margin:0 0 0
                                                .8ex;border-left:1px
                                                #ccc
                                                solid;padding-left:1ex">
                                                Andres,<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                   For current VR
                                                  workloads we have 3
                                                  separate processes<br>
                                                  running<br>
                                                  actually:<br>
                                                </blockquote>
                                                So we could have
                                                potential memory
                                                overcommit case or do<br>
                                                you do<br>
                                                partitioning<br>
                                                on your own?  I would
                                                think that there is need
                                                to avoid<br>
                                                overcomit in<br>
                                                VR case to<br>
                                                prevent any BO
                                                migration.<br>
                                              </blockquote>
                                              <br>
                                              You're entirely correct;
                                              currently the VR runtime
                                              is<br>
                                              setting up<br>
                                              prioritized CPU scheduling
                                              for its VR compositor,
                                              we're<br>
                                              working on<br>
                                              prioritized GPU scheduling
                                              and pre-emption (eg. this<br>
                                              thread), and in<br>
                                              the future it will make
                                              sense to do work in order
                                              to make<br>
                                              sure that<br>
                                              its memory allocations do
                                              not get evicted, to
                                              prevent any<br>
                                              unwelcome<br>
                                              additional latency in the
                                              event of needing to
                                              perform<br>
                                              just-in-time<br>
                                              reprojection.<br>
                                              <br>
                                              <blockquote
                                                class="gmail_quote"
                                                style="margin:0 0 0
                                                .8ex;border-left:1px
                                                #ccc
                                                solid;padding-left:1ex">
                                                BTW: Do you mean
                                                __real__ processes or
                                                threads?<br>
                                                Based on my
                                                understanding sharing
                                                BOs between different<br>
                                                processes<br>
                                                could introduce
                                                additional
                                                synchronization
                                                constrains. btw:<br>
                                                I am not<br>
                                                sure<br>
                                                if we are able to share
                                                Vulkan sync. object
                                                cross-process<br>
                                                boundary.<br>
                                              </blockquote>
                                              <br>
                                              They are different
                                              processes; it is important
                                              for the<br>
                                              compositor that<br>
                                              is responsible for
                                              quality-of-service
                                              features such as<br>
                                              consistently<br>
                                              presenting distorted
                                              frames with the right
                                              latency,<br>
                                              reprojection, etc,<br>
                                              to be separate from the
                                              main application.<br>
                                              <br>
                                              Currently we are using
                                              unreleased cross-process
                                              memory and<br>
                                              semaphore<br>
                                              extensions to fetch
                                              updated eye images from
                                              the client<br>
                                              application,<br>
                                              but the just-in-time
                                              reprojection discussed
                                              here does not<br>
                                              actually<br>
                                              have any direct
                                              interactions with
                                              cross-process resource<br>
                                              sharing,<br>
                                              since it's achieved by
                                              using whatever is the
                                              latest, most<br>
                                              up-to-date<br>
                                              eye images that have
                                              already been sent by the
                                              client<br>
                                              application,<br>
                                              which are already
                                              available to use without
                                              additional<br>
                                              synchronization.<br>
                                              <br>
                                              <blockquote
                                                class="gmail_quote"
                                                style="margin:0 0 0
                                                .8ex;border-left:1px
                                                #ccc
                                                solid;padding-left:1ex">
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                     3) System
                                                  compositor (we are
                                                  looking at approaches
                                                  to<br>
                                                  remove this<br>
                                                  overhead)<br>
                                                </blockquote>
                                                Yes,  IMHO the best is
                                                to run in  "full screen
                                                mode".<br>
                                              </blockquote>
                                              <br>
                                              Yes, we are working on
                                              mechanisms to present
                                              directly to the<br>
                                              headset<br>
                                              display without any
                                              intermediaries as a
                                              separate effort.<br>
                                              <br>
                                              <blockquote
                                                class="gmail_quote"
                                                style="margin:0 0 0
                                                .8ex;border-left:1px
                                                #ccc
                                                solid;padding-left:1ex">
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                   The latency is our
                                                  main concern,<br>
                                                </blockquote>
                                                I would assume that this
                                                is the known problem (at
                                                least for<br>
                                                compute<br>
                                                usage).<br>
                                                It looks like that
                                                amdgpu / kernel
                                                submission is rather CPU<br>
                                                intensive<br>
                                                (at least<br>
                                                in the default
                                                configuration).<br>
                                              </blockquote>
                                              <br>
                                              As long as it's a
                                              consistent cost, it
                                              shouldn't an issue.<br>
                                              However, if<br>
                                              there's high degrees of
                                              variance then that would
                                              be<br>
                                              troublesome and we<br>
                                              would need to account for
                                              the worst case.<br>
                                              <br>
                                              Hopefully the requirements
                                              and approach we described
                                              make<br>
                                              sense, we're<br>
                                              looking forward to your
                                              feedback and suggestions.<br>
                                              <br>
                                              Thanks!<br>
                                               - Pierre-Loup<br>
                                              <br>
                                              <blockquote
                                                class="gmail_quote"
                                                style="margin:0 0 0
                                                .8ex;border-left:1px
                                                #ccc
                                                solid;padding-left:1ex">
                                                <br>
                                                Sincerely yours,<br>
                                                Serguei Sagalovitch<br>
                                                <br>
                                                <br>
                                                From: Andres Rodriguez
                                                &lt;<a
                                                  moz-do-not-send="true"
href="mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org">andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org</a></a>&gt;<br>
                                                Sent: December 16, 2016
                                                10:00 PM<br>
                                                To: Sagalovitch,
                                                Serguei; <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                Subject: RE: [RFC]
                                                Mechanism for high
                                                priority scheduling<br>
                                                in amdgpu<br>
                                                <br>
                                                Hey Serguei,<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                  [Serguei] No. I mean
                                                  pipe :-) as MEC define
                                                  it.  As far<br>
                                                  as I<br>
                                                  understand (by
                                                  simplifying)<br>
                                                  some scheduling is per
                                                  pipe.  I know about
                                                  the current<br>
                                                  allocation<br>
                                                  scheme but I do not
                                                  think<br>
                                                  that it is  ideal.  I
                                                  would assume that we
                                                  need to<br>
                                                  switch to<br>
                                                  dynamical partition<br>
                                                  of resources  based on
                                                  the workload otherwise
                                                  we will have<br>
                                                  resource<br>
                                                  conflict<br>
                                                  between Vulkan compute
                                                  and  OpenCL.<br>
                                                </blockquote>
                                                <br>
                                                I agree the partitioning
                                                isn't ideal. I'm hoping
                                                we can<br>
                                                start with a<br>
                                                solution that assumes
                                                that<br>
                                                only pipe0 has any work
                                                and the other pipes are
                                                idle (no<br>
                                                HSA/ROCm<br>
                                                running on the system).<br>
                                                <br>
                                                This should be more or
                                                less the use case we
                                                expect from VR<br>
                                                users.<br>
                                                <br>
                                                I agree the split is
                                                currently not ideal, but
                                                I'd like to<br>
                                                consider<br>
                                                that a separate task,
                                                because<br>
                                                making it dynamic is not
                                                straight forward :P<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                  [Serguei] Vulkan works
                                                  via amdgpu (kernel
                                                  submissions) so<br>
                                                  amdkfd<br>
                                                  will be not<br>
                                                  involved.  I would
                                                  assume that in the
                                                  case of VR we will<br>
                                                  have one main<br>
                                                  application ("console"
                                                  mode(?)) so we could
                                                  temporally<br>
                                                  "ignore"<br>
                                                  OpenCL/ROCm needs when
                                                  VR is running.<br>
                                                </blockquote>
                                                <br>
                                                Correct, this is why we
                                                want to enable the high
                                                priority<br>
                                                compute<br>
                                                queue through<br>
                                                libdrm-amdgpu, so that
                                                we can expose it through
                                                Vulkan<br>
                                                later.<br>
                                                <br>
                                                For current VR workloads
                                                we have 3 separate
                                                processes<br>
                                                running actually:<br>
                                                    1) Game process<br>
                                                    2) VR Compositor
                                                (this is the process
                                                that will require<br>
                                                high<br>
                                                priority queue)<br>
                                                    3) System compositor
                                                (we are looking at
                                                approaches to<br>
                                                remove this<br>
                                                overhead)<br>
                                                <br>
                                                For now I think it is
                                                okay to assume no
                                                OpenCL/ROCm running<br>
                                                simultaneously, but<br>
                                                I would also like to be
                                                able to address this
                                                case in the<br>
                                                future<br>
                                                (cross-pipe priorities).<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                  [Serguei]  The problem
                                                  with pre-emption of
                                                  graphics task:<br>
                                                  (a) it<br>
                                                  may take time so<br>
                                                  latency may suffer<br>
                                                </blockquote>
                                                <br>
                                                The latency is our main
                                                concern, we want
                                                something that is<br>
                                                predictable. A good<br>
                                                illustration of what the
                                                reprojection scheduling
                                                looks like<br>
                                                can be<br>
                                                found here:<br>
                                                <a
                                                  moz-do-not-send="true"
href="https://community.amd.com/servlet/JiveServlet/showImage/38-1310-104754/pastedImage_3.png"
                                                  rel="noreferrer"
                                                  target="_blank"><a class="moz-txt-link-freetext" href="https://community.amd.com/serv">https://community.amd.com/serv</a><wbr>let/JiveServlet/showImage/38-<wbr>1310-104754/pastedImage_3.png</a><br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                  (b) to preempt we need
                                                  to have different
                                                  "context" - we<br>
                                                  want<br>
                                                  to guarantee that
                                                  submissions from the
                                                  same context will<br>
                                                  be executed<br>
                                                  in order.<br>
                                                </blockquote>
                                                <br>
                                                This is okay, as the
                                                reprojection work
                                                doesn't have<br>
                                                dependencies on<br>
                                                the game context, and it<br>
                                                even happens in a
                                                separate process.<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                  BTW: (a) Do you want
                                                  "preempt" and later
                                                  resume or do you<br>
                                                  want<br>
                                                  "preempt" and<br>
                                                  "cancel/abort"<br>
                                                </blockquote>
                                                <br>
                                                Preempt the game with
                                                the compositor task and
                                                then resume<br>
                                                it.<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                  (b) Vulkan is generic
                                                  API and could be used
                                                  for graphics<br>
                                                  as well as<br>
                                                  for plain compute
                                                  tasks
                                                  (VK_QUEUE_COMPUTE_BIT).<br>
                                                </blockquote>
                                                <br>
                                                Yeah, the plan is to use
                                                vulkan compute. But if
                                                you figure<br>
                                                out a way<br>
                                                for us to get<br>
                                                a guaranteed execution
                                                time using vulkan
                                                graphics, then<br>
                                                I'll take you<br>
                                                out for a beer :)<br>
                                                <br>
                                                Regards,<br>
                                                Andres<br>
______________________________<wbr>__________<br>
                                                From: Sagalovitch,
                                                Serguei [<a
                                                  moz-do-not-send="true"
href="mailto:Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org">Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org</a></a>]<br>
                                                Sent: Friday, December
                                                16, 2016 9:13 PM<br>
                                                To: Andres Rodriguez; <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                Subject: Re: [RFC]
                                                Mechanism for high
                                                priority scheduling<br>
                                                in amdgpu<br>
                                                <br>
                                                Hi Andres,<br>
                                                <br>
                                                Please see inline (as
                                                [Serguei])<br>
                                                <br>
                                                Sincerely yours,<br>
                                                Serguei Sagalovitch<br>
                                                <br>
                                                <br>
                                                From: Andres Rodriguez
                                                &lt;<a
                                                  moz-do-not-send="true"
href="mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org">andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org</a></a>&gt;<br>
                                                Sent: December 16, 2016
                                                8:29 PM<br>
                                                To: Sagalovitch,
                                                Serguei; <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                Subject: RE: [RFC]
                                                Mechanism for high
                                                priority scheduling<br>
                                                in amdgpu<br>
                                                <br>
                                                Hi Serguei,<br>
                                                <br>
                                                Thanks for the feedback.
                                                Answers inline as [AR].<br>
                                                <br>
                                                Regards,<br>
                                                Andres<br>
                                                <br>
______________________________<wbr>__________<br>
                                                From: Sagalovitch,
                                                Serguei [<a
                                                  moz-do-not-send="true"
href="mailto:Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org">Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org</a></a>]<br>
                                                Sent: Friday, December
                                                16, 2016 8:15 PM<br>
                                                To: Andres Rodriguez; <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                Subject: Re: [RFC]
                                                Mechanism for high
                                                priority scheduling<br>
                                                in amdgpu<br>
                                                <br>
                                                Andres,<br>
                                                <br>
                                                <br>
                                                Quick comments:<br>
                                                <br>
                                                1) To minimize
                                                "bubbles", etc. we need
                                                to "force" CU<br>
                                                assignments/binding<br>
                                                to high-priority queue 
                                                when it will be in use
                                                and "free"<br>
                                                them later<br>
                                                (we  do not want forever
                                                take CUs from e.g.
                                                graphic task to<br>
                                                degrade<br>
                                                graphics<br>
                                                performance).<br>
                                                <br>
                                                Otherwise we could have
                                                scenario when long
                                                graphics task (or<br>
                                                low-priority<br>
                                                compute) will took all
                                                (extra) CUs and
                                                high--priority will<br>
                                                wait for<br>
                                                needed resources.<br>
                                                It will not be visible
                                                on "NOP " but only when
                                                you submit<br>
                                                "real"<br>
                                                compute task<br>
                                                so I would recommend 
                                                not to use "NOP" packets
                                                at all for<br>
                                                testing.<br>
                                                <br>
                                                It (CU assignment) could
                                                be relatively easy done
                                                when<br>
                                                everything is<br>
                                                going via kernel<br>
                                                (e.g. as part of frame
                                                submission) but I must
                                                admit that I<br>
                                                am not sure<br>
                                                about the best way for
                                                user level submissions
                                                (amdkfd).<br>
                                                <br>
                                                [AR] I wasn't aware of
                                                this part of the
                                                programming<br>
                                                sequence. Thanks<br>
                                                for the heads up!<br>
                                                Is this similar to the
                                                CU masking programming?<br>
                                                [Serguei] Yes. To
                                                simplify: the problem is
                                                that "scheduler"<br>
                                                when<br>
                                                deciding which<br>
                                                queue to  run will check
                                                if there is enough
                                                resources and<br>
                                                if not then<br>
                                                it will begin<br>
                                                to check other queues
                                                with lower priority.<br>
                                                <br>
                                                2) I would recommend to
                                                dedicate the whole pipe
                                                to<br>
                                                high-priority<br>
                                                queue and have<br>
                                                nothing their except it.<br>
                                                <br>
                                                [AR] I'm guessing in
                                                this context you mean
                                                pipe = queue?<br>
                                                (as opposed<br>
                                                to the MEC definition<br>
                                                of pipe, which is a
                                                grouping of queues). I
                                                say this because<br>
                                                amdgpu<br>
                                                only has access to 1
                                                pipe,<br>
                                                and the rest are
                                                statically partitioned
                                                for amdkfd usage.<br>
                                                <br>
                                                [Serguei] No. I mean
                                                pipe :-)  as MEC define
                                                it. As far as I<br>
                                                understand (by
                                                simplifying)<br>
                                                some scheduling is per
                                                pipe.  I know about the
                                                current<br>
                                                allocation<br>
                                                scheme but I do not
                                                think<br>
                                                that it is  ideal.  I
                                                would assume that we
                                                need to switch to<br>
                                                dynamical partition<br>
                                                of resources  based on
                                                the workload otherwise
                                                we will have<br>
                                                resource<br>
                                                conflict<br>
                                                between Vulkan compute
                                                and  OpenCL.<br>
                                                <br>
                                                <br>
                                                BTW: Which user level
                                                API do you want to use
                                                for compute:<br>
                                                Vulkan or<br>
                                                OpenCL?<br>
                                                <br>
                                                [AR] Vulkan<br>
                                                <br>
                                                [Serguei] Vulkan works
                                                via amdgpu (kernel
                                                submissions) so<br>
                                                amdkfd will<br>
                                                be not<br>
                                                involved.  I would
                                                assume that in the case
                                                of VR we will<br>
                                                have one main<br>
                                                application ("console"
                                                mode(?)) so we could
                                                temporally<br>
                                                "ignore"<br>
                                                OpenCL/ROCm needs when
                                                VR is running.<br>
                                                <br>
                                                <blockquote
                                                  class="gmail_quote"
                                                  style="margin:0 0 0
                                                  .8ex;border-left:1px
                                                  #ccc
                                                  solid;padding-left:1ex">
                                                   we will not be able
                                                  to provide a solution
                                                  compatible with<br>
                                                  GFX<br>
                                                  worloads.<br>
                                                </blockquote>
                                                I assume that you are
                                                talking about graphics?
                                                Am I right?<br>
                                                <br>
                                                [AR] Yeah, my
                                                understanding is that
                                                pre-empting the<br>
                                                currently running<br>
                                                graphics job and
                                                scheduling in<br>
                                                something else using
                                                mid-buffer pre-emption
                                                has some cases<br>
                                                where it<br>
                                                doesn't work well. But
                                                if with<br>
                                                polaris10 it starts
                                                working well, it might
                                                be a better<br>
                                                solution for<br>
                                                us (because the whole
                                                reprojection<br>
                                                work uses the vulkan
                                                graphics stack at the
                                                moment, and<br>
                                                porting it to<br>
                                                compute is not trivial).<br>
                                                <br>
                                                [Serguei]  The problem
                                                with pre-emption of
                                                graphics task:<br>
                                                (a) it may<br>
                                                take time so<br>
                                                latency may suffer (b)
                                                to preempt we need to
                                                have different<br>
                                                "context"<br>
                                                - we want<br>
                                                to guarantee that
                                                submissions from the
                                                same context will be<br>
                                                executed<br>
                                                in order.<br>
                                                BTW: (a) Do you want 
                                                "preempt" and later
                                                resume or do you<br>
                                                want<br>
                                                "preempt" and<br>
                                                "cancel/abort"?  (b)
                                                Vulkan is generic API
                                                and could be used<br>
                                                for graphics as well as
                                                for plain compute tasks<br>
                                                (VK_QUEUE_COMPUTE_BIT).<br>
                                                <br>
                                                <br>
                                                Sincerely yours,<br>
                                                Serguei Sagalovitch<br>
                                                <br>
                                                <br>
                                                <br>
                                                From: amd-gfx &lt;<a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org</a><wbr>ktop.org</a>&gt;
                                                on<br>
                                                behalf of<br>
                                                Andres Rodriguez &lt;<a
                                                  moz-do-not-send="true"
href="mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org">andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org</a></a>&gt;<br>
                                                Sent: December 16, 2016
                                                6:15 PM<br>
                                                To: <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                Subject: [RFC] Mechanism
                                                for high priority
                                                scheduling in<br>
                                                amdgpu<br>
                                                <br>
                                                Hi Everyone,<br>
                                                <br>
                                                This RFC is also
                                                available as a gist
                                                here:<br>
                                                <a
                                                  moz-do-not-send="true"
href="https://gist.github.com/lostgoat/7000432cd6864265dbc2c3ab93204249"
                                                  rel="noreferrer"
                                                  target="_blank"><a class="moz-txt-link-freetext" href="https://gist.github.com/lostgo">https://gist.github.com/lostgo</a><wbr>at/7000432cd6864265dbc2c3ab932<wbr>04249</a><br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                [RFC] Mechanism for high
                                                priority scheduling in
                                                amdgpu<br>
                                                <a
                                                  moz-do-not-send="true"
href="http://gist.github.com" rel="noreferrer" target="_blank">gist.github.com</a><br>
                                                [RFC] Mechanism for high
                                                priority scheduling in
                                                amdgpu<br>
                                                <br>
                                                <br>
                                                <br>
                                                [RFC] Mechanism for high
                                                priority scheduling in
                                                amdgpu<br>
                                                <a
                                                  moz-do-not-send="true"
href="http://gist.github.com" rel="noreferrer" target="_blank">gist.github.com</a><br>
                                                [RFC] Mechanism for high
                                                priority scheduling in
                                                amdgpu<br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                [RFC] Mechanism for high
                                                priority scheduling in
                                                amdgpu<br>
                                                <a
                                                  moz-do-not-send="true"
href="http://gist.github.com" rel="noreferrer" target="_blank">gist.github.com</a><br>
                                                [RFC] Mechanism for high
                                                priority scheduling in
                                                amdgpu<br>
                                                <br>
                                                <br>
                                                We are interested in
                                                feedback for a mechanism
                                                to<br>
                                                effectively schedule<br>
                                                high<br>
                                                priority VR reprojection
                                                tasks (also referred to
                                                as<br>
                                                time-warping) for<br>
                                                Polaris10<br>
                                                running on the amdgpu
                                                kernel driver.<br>
                                                <br>
                                                Brief context:<br>
                                                --------------<br>
                                                <br>
                                                The main objective of
                                                reprojection is to avoid
                                                motion<br>
                                                sickness for VR<br>
                                                users in<br>
                                                scenarios where the game
                                                or application would
                                                fail to finish<br>
                                                rendering a new<br>
                                                frame in time for the
                                                next VBLANK. When this
                                                happens, the<br>
                                                user's head<br>
                                                movements<br>
                                                are not reflected on the
                                                Head Mounted Display
                                                (HMD) for the<br>
                                                duration<br>
                                                of an<br>
                                                extra frame. This
                                                extended mismatch
                                                between the inner ear<br>
                                                and the<br>
                                                eyes may<br>
                                                cause the user to
                                                experience motion
                                                sickness.<br>
                                                <br>
                                                The VR compositor deals
                                                with this problem by
                                                fabricating a<br>
                                                new frame<br>
                                                using the<br>
                                                user's updated head
                                                position in combination
                                                with the<br>
                                                previous frames.<br>
                                                This<br>
                                                avoids a prolonged
                                                mismatch between the HMD
                                                output and the<br>
                                                inner ear.<br>
                                                <br>
                                                Because of the adverse
                                                effects on the user, we
                                                require high<br>
                                                confidence that the<br>
                                                reprojection task will
                                                complete before the
                                                VBLANK interval.<br>
                                                Even if<br>
                                                the GFX pipe<br>
                                                is currently full of
                                                work from the
                                                game/application (which<br>
                                                is most<br>
                                                likely the case).<br>
                                                <br>
                                                For more details and
                                                illustrations, please
                                                refer to the<br>
                                                following<br>
                                                document:<br>
                                                <a
                                                  moz-do-not-send="true"
href="https://community.amd.com/community/gaming/blog/2016/03/28/asynchronous-shaders-evolved"
                                                  rel="noreferrer"
                                                  target="_blank"><a class="moz-txt-link-freetext" href="https://community.amd.com/comm">https://community.amd.com/comm</a><wbr>unity/gaming/blog/2016/03/28/<wbr>asynchronous-shaders-evolved</a><br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                Gaming: Asynchronous
                                                Shaders Evolved |
                                                Community<br>
                                                <a
                                                  moz-do-not-send="true"
href="http://community.amd.com" rel="noreferrer" target="_blank">community.amd.com</a><br>
                                                One of the most exciting
                                                new developments in GPU
                                                technology<br>
                                                over the<br>
                                                past year has been the
                                                adoption of asynchronous
                                                shaders,<br>
                                                which can<br>
                                                make more efficient use
                                                of ...<br>
                                                <br>
                                                <br>
                                                <br>
                                                Gaming: Asynchronous
                                                Shaders Evolved |
                                                Community<br>
                                                <a
                                                  moz-do-not-send="true"
href="http://community.amd.com" rel="noreferrer" target="_blank">community.amd.com</a><br>
                                                One of the most exciting
                                                new developments in GPU
                                                technology<br>
                                                over the<br>
                                                past year has been the
                                                adoption of asynchronous
                                                shaders,<br>
                                                which can<br>
                                                make more efficient use
                                                of ...<br>
                                                <br>
                                                <br>
                                                <br>
                                                Gaming: Asynchronous
                                                Shaders Evolved |
                                                Community<br>
                                                <a
                                                  moz-do-not-send="true"
href="http://community.amd.com" rel="noreferrer" target="_blank">community.amd.com</a><br>
                                                One of the most exciting
                                                new developments in GPU
                                                technology<br>
                                                over the<br>
                                                past year has been the
                                                adoption of asynchronous
                                                shaders,<br>
                                                which can<br>
                                                make more efficient use
                                                of ...<br>
                                                <br>
                                                <br>
                                                Requirements:<br>
                                                -------------<br>
                                                <br>
                                                The mechanism must
                                                expose the following
                                                functionaility:<br>
                                                <br>
                                                    * Job round trip
                                                time must be
                                                predictable, from<br>
                                                submission to<br>
                                                fence signal<br>
                                                <br>
                                                    * The mechanism must
                                                support compute
                                                workloads.<br>
                                                <br>
                                                Goals:<br>
                                                ------<br>
                                                <br>
                                                    * The mechanism
                                                should provide low
                                                submission latencies<br>
                                                <br>
                                                Test: submitting a NOP
                                                packet through the
                                                mechanism on busy<br>
                                                hardware<br>
                                                should<br>
                                                be equivalent to
                                                submitting a NOP on idle
                                                hardware.<br>
                                                <br>
                                                Nice to have:<br>
                                                -------------<br>
                                                <br>
                                                    * The mechanism
                                                should also support GFX
                                                workloads.<br>
                                                <br>
                                                My understanding is that
                                                with the current
                                                hardware<br>
                                                capabilities in<br>
                                                Polaris10 we<br>
                                                will not be able to
                                                provide a solution
                                                compatible with GFX<br>
                                                worloads.<br>
                                                <br>
                                                But I would love to hear
                                                otherwise. So if anyone
                                                has an<br>
                                                idea,<br>
                                                approach or<br>
                                                suggestion that will
                                                also be compatible with
                                                the GFX ring,<br>
                                                please let<br>
                                                us know<br>
                                                about it.<br>
                                                <br>
                                                    * The above
                                                guarantees should also
                                                be respected by<br>
                                                amdkfd workloads<br>
                                                <br>
                                                Would be good to have
                                                for consistency, but not
                                                strictly<br>
                                                necessary as<br>
                                                users running<br>
                                                games are not
                                                traditionally running
                                                HPC workloads in the<br>
                                                background.<br>
                                                <br>
                                                Proposed approach:<br>
                                                ------------------<br>
                                                <br>
                                                Similar to the windows
                                                driver, we could expose
                                                a high<br>
                                                priority<br>
                                                compute queue to<br>
                                                userspace.<br>
                                                <br>
                                                Submissions to this
                                                compute queue will be
                                                scheduled with<br>
                                                high<br>
                                                priority, and may<br>
                                                acquire hardware
                                                resources previously in
                                                use by other<br>
                                                queues.<br>
                                                <br>
                                                This can be achieved by
                                                taking advantage of the
                                                'priority'<br>
                                                field in<br>
                                                the HQDs<br>
                                                and could be programmed
                                                by amdgpu or the amdgpu
                                                scheduler.<br>
                                                The relevant<br>
                                                register fields are:<br>
                                                        *
                                                mmCP_HQD_PIPE_PRIORITY<br>
                                                        *
                                                mmCP_HQD_QUEUE_PRIORITY<br>
                                                <br>
                                                Implementation approach
                                                1 - static partitioning:<br>
------------------------------<wbr>------------------<br>
                                                <br>
                                                The amdgpu driver
                                                currently controls 8
                                                compute queues from<br>
                                                pipe0. We can<br>
                                                statically partition
                                                these as follows:<br>
                                                        * 7x regular<br>
                                                        * 1x high
                                                priority<br>
                                                <br>
                                                The relevant priorities
                                                can be set so that
                                                submissions to<br>
                                                the high<br>
                                                priority<br>
                                                ring will starve the
                                                other compute rings and
                                                the GFX ring.<br>
                                                <br>
                                                The amdgpu scheduler
                                                will only place jobs
                                                into the high<br>
                                                priority<br>
                                                rings if the<br>
                                                context is marked as
                                                high priority. And a
                                                corresponding<br>
                                                priority<br>
                                                should be<br>
                                                added to keep track of
                                                this information:<br>
                                                     *
                                                AMD_SCHED_PRIORITY_KERNEL<br>
                                                     * -&gt;
                                                AMD_SCHED_PRIORITY_HIGH<br>
                                                     *
                                                AMD_SCHED_PRIORITY_NORMAL<br>
                                                <br>
                                                The user will request a
                                                high priority context by
                                                setting an<br>
                                                appropriate flag<br>
                                                in drm_amdgpu_ctx_in
                                                (AMDGPU_CTX_HIGH_PRIORITY
                                                or similar):<br>
                                                <a
                                                  moz-do-not-send="true"
href="https://github.com/torvalds/linux/blob/master/include/uapi/drm/amdgpu_drm.h#L163"
                                                  rel="noreferrer"
                                                  target="_blank"><a class="moz-txt-link-freetext" href="https://github.com/torvalds/li">https://github.com/torvalds/li</a><wbr>nux/blob/master/include/uapi/<wbr>drm/amdgpu_drm.h#L163</a><br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                The setting is in a per
                                                context level so that we
                                                can:<br>
                                                    * Maintain a
                                                consistent FIFO ordering
                                                of all<br>
                                                submissions to a<br>
                                                context<br>
                                                    * Create high
                                                priority and non-high
                                                priority contexts<br>
                                                in the same<br>
                                                process<br>
                                                <br>
                                                Implementation approach
                                                2 - dynamic priority
                                                programming:<br>
------------------------------<wbr>---------------------------<br>
                                                <br>
                                                Similar to the above,
                                                but instead of
                                                programming the<br>
                                                priorities and<br>
                                                amdgpu_init() time, the
                                                SW scheduler will
                                                reprogram the<br>
                                                queue priorities<br>
                                                dynamically when
                                                scheduling a task.<br>
                                                <br>
                                                This would involve
                                                having a hardware
                                                specific callback from<br>
                                                the<br>
                                                scheduler to<br>
                                                set the appropriate
                                                queue priority:
                                                set_priority(int ring,<br>
                                                int index,<br>
                                                int priority)<br>
                                                <br>
                                                During this callback we
                                                would have to grab the
                                                SRBM mutex<br>
                                                to perform<br>
                                                the appropriate<br>
                                                HW programming, and I'm
                                                not really sure if that
                                                is<br>
                                                something we<br>
                                                should be doing from<br>
                                                the scheduler.<br>
                                                <br>
                                                On the positive side,
                                                this approach would
                                                allow us to<br>
                                                program a range of<br>
                                                priorities for jobs
                                                instead of a single
                                                "high priority"<br>
                                                value",<br>
                                                achieving<br>
                                                something similar to the
                                                niceness API available
                                                for CPU<br>
                                                scheduling.<br>
                                                <br>
                                                I'm not sure if this
                                                flexibility is something
                                                that we would<br>
                                                need for<br>
                                                our use<br>
                                                case, but it might be
                                                useful in other
                                                scenarios (multiple<br>
                                                users<br>
                                                sharing compute<br>
                                                time on a server).<br>
                                                <br>
                                                This approach would
                                                require a new int field
                                                in<br>
                                                drm_amdgpu_ctx_in, or<br>
                                                repurposing<br>
                                                of the flags field.<br>
                                                <br>
                                                Known current obstacles:<br>
                                                ------------------------<br>
                                                <br>
                                                The SQ is currently
                                                programmed to disregard
                                                the HQD<br>
                                                priorities, and<br>
                                                instead it picks<br>
                                                jobs at random. Settings
                                                from the shader itself
                                                are also<br>
                                                disregarded<br>
                                                as this is<br>
                                                considered a privileged
                                                field.<br>
                                                <br>
                                                Effectively we can get
                                                our compute wavefront
                                                launched ASAP,<br>
                                                but we<br>
                                                might not get the<br>
                                                time we need on the SQ.<br>
                                                <br>
                                                The current programming
                                                would have to be changed
                                                to allow<br>
                                                priority<br>
                                                propagation<br>
                                                from the HQD into the
                                                SQ.<br>
                                                <br>
                                                Generic approach for all
                                                HW IPs:<br>
------------------------------<wbr>--<br>
                                                <br>
                                                For consistency
                                                purposes, the high
                                                priority context can be<br>
                                                enabled<br>
                                                for all HW IPs<br>
                                                with support of the SW
                                                scheduler. This will
                                                function<br>
                                                similarly to the<br>
                                                current<br>
AMD_SCHED_PRIORITY_KERNEL priority, where the job can jump<br>
                                                ahead of<br>
                                                anything not<br>
                                                commited to the HW
                                                queue.<br>
                                                <br>
                                                The benefits of
                                                requesting a high
                                                priority context for a<br>
                                                non-compute<br>
                                                queue will<br>
                                                be lesser (e.g. up to
                                                10s of wait time if a
                                                GFX command is<br>
                                                stuck in<br>
                                                front of<br>
                                                you), but having the API
                                                in place will allow us
                                                to easily<br>
                                                improve the<br>
                                                implementation<br>
                                                in the future as new
                                                features become
                                                available in new<br>
                                                hardware.<br>
                                                <br>
                                                Future steps:<br>
                                                -------------<br>
                                                <br>
                                                Once we have an approach
                                                settled, I can take care
                                                of the<br>
                                                implementation.<br>
                                                <br>
                                                Also, once the interface
                                                is mostly decided, we
                                                can start<br>
                                                thinking about<br>
                                                exposing the high
                                                priority queue through
                                                radv.<br>
                                                <br>
                                                Request for feedback:<br>
                                                ---------------------<br>
                                                <br>
                                                We aren't married to any
                                                of the approaches
                                                outlined above.<br>
                                                Our goal<br>
                                                is to<br>
                                                obtain a mechanism that
                                                will allow us to
                                                complete the<br>
                                                reprojection<br>
                                                job within a<br>
                                                predictable amount of
                                                time. So if anyone
                                                anyone has any<br>
                                                suggestions for<br>
                                                improvements or
                                                alternative strategies
                                                we are more than<br>
                                                happy to hear<br>
                                                them.<br>
                                                <br>
                                                If any of the technical
                                                information above is
                                                also<br>
                                                incorrect, feel<br>
                                                free to point<br>
                                                out my
                                                misunderstandings.<br>
                                                <br>
                                                Looking forward to
                                                hearing from you.<br>
                                                <br>
                                                Regards,<br>
                                                Andres<br>
                                                <br>
______________________________<wbr>_________________<br>
                                                amd-gfx mailing list<br>
                                                <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                <a
                                                  moz-do-not-send="true"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                  rel="noreferrer"
                                                  target="_blank"><a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/">https://lists.freedesktop.org/</a><wbr>mailman/listinfo/amd-gfx</a><br>
                                                <br>
                                                <br>
                                                amd-gfx Info Page - <a
                                                  moz-do-not-send="true"
href="http://lists.freedesktop.org" rel="noreferrer" target="_blank">lists.freedesktop.org</a><br>
                                                <a
                                                  moz-do-not-send="true"
href="http://lists.freedesktop.org" rel="noreferrer" target="_blank">lists.freedesktop.org</a><br>
                                                To see the collection of
                                                prior postings to the
                                                list,<br>
                                                visit the<br>
                                                amd-gfx Archives. Using
                                                amd-gfx: To post a
                                                message to all<br>
                                                the list<br>
                                                members, send email ...<br>
                                                <br>
                                                <br>
                                                <br>
                                                amd-gfx Info Page - <a
                                                  moz-do-not-send="true"
href="http://lists.freedesktop.org" rel="noreferrer" target="_blank">lists.freedesktop.org</a><br>
                                                <a
                                                  moz-do-not-send="true"
href="http://lists.freedesktop.org" rel="noreferrer" target="_blank">lists.freedesktop.org</a><br>
                                                To see the collection of
                                                prior postings to the
                                                list,<br>
                                                visit the<br>
                                                amd-gfx Archives. Using
                                                amd-gfx: To post a
                                                message to all<br>
                                                the list<br>
                                                members, send email ...<br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
                                                <br>
______________________________<wbr>_________________<br>
                                                amd-gfx mailing list<br>
                                                <a
                                                  moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                <a
                                                  moz-do-not-send="true"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                  rel="noreferrer"
                                                  target="_blank"><a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/">https://lists.freedesktop.org/</a><wbr>mailman/listinfo/amd-gfx</a><br>
                                                <br>
                                              </blockquote>
                                              <br>
______________________________<wbr>_________________<br>
                                              amd-gfx mailing list<br>
                                              <a moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                              <a moz-do-not-send="true"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                rel="noreferrer"
                                                target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
                                            </blockquote>
                                            <br>
                                          </blockquote>
                                          <br>
                                        </blockquote>
                                        <br>
                                        ______________________________<wbr>_________________<br>
                                        amd-gfx mailing list<br>
                                        <a moz-do-not-send="true"
                                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                          target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                        <a moz-do-not-send="true"
                                          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                          rel="noreferrer"
                                          target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
                                      </blockquote>
                                      <br>
                                    </blockquote>
                                    <br>
                                  </blockquote>
                                  <br>
                                  Sincerely yours,<br>
                                  Serguei Sagalovitch<br>
                                  <br>
                                  ______________________________<wbr>_________________<br>
                                  amd-gfx mailing list<br>
                                  <a moz-do-not-send="true"
                                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                    target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                  <a moz-do-not-send="true"
                                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                    rel="noreferrer" target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
                                </blockquote>
                                <br>
                                <br>
                              </blockquote>
                              <br>
                            </blockquote>
                            <br>
                          </blockquote>
                          <br>
                        </blockquote>
                        <br>
                        Sincerely yours,<br>
                        Serguei Sagalovitch<br>
                        <br>
                      </blockquote>
                      <br>
                    </blockquote>
                    <br>
                  </blockquote>
                  <br>
                </div>
              </div>
            </blockquote>
          </div>
          <br>
        </div>
      </blockquote>
      <br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------8A0F7AEF1F662A95B70010BF--

--===============0808856035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0808856035==--
