From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 -
 Update 2
Date: Fri, 2 Feb 2018 18:46:00 +0000
Message-ID: <CAEzXK1rWeUYoSvd-T5JRSZnZSMcSCdpHDy6Eh5wkH=Qr=Gz2Bw@mail.gmail.com>
References: <CAEzXK1o+FewfiG84pCj8c_1Xz5KVsOOU7EX13LWaFVxK7s66fg@mail.gmail.com>
 <d755cd12-1a1e-ce98-2b0d-ea4b5eafc483@amd.com>
 <CAEzXK1qCfnHUvnuuViTP5fZQx2StjecV6o_QfJ2uJk603_9nhA@mail.gmail.com>
 <CAEzXK1oUyHsSGHeXS9qzWBSDL-FfRq2h-EiQMCfa=5BroO50gg@mail.gmail.com>
 <8bcdc933-050b-12ca-46e6-54bb66b6824d@gmail.com>
 <CAEzXK1pPzRM=EpL8fKQ5SdDvEePR+_KPhrtPMPiArt==BsJspA@mail.gmail.com>
 <99a9e27e-f166-f969-416f-f128b0673388@daenzer.net>
 <CAEzXK1rb6ngg=3MHo6yT+ed-a_1xr3ASwLPtsK4CpSMBk3xKgw@mail.gmail.com>
 <CAEzXK1qFh-Y6zCoVpRVRcLEe_hLFueqntrjaAwgfKyLGd2u27A@mail.gmail.com>
 <CAEzXK1rixP9spSTBY4V5GWxyUWJdf23Nbis2gbKgfxz4A6w2rQ@mail.gmail.com>
 <BN6PR12MB1652E01048ABD6A307E80B8DF7E40@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAEzXK1rbmaNifg00RY+GPdUgLtysLsF1mciPekbotWfT0gagJA@mail.gmail.com>
 <CAEzXK1ok5BsSMY2t4+D0575QSAqEkzKPC7cnWEVmg0OhCFcgcA@mail.gmail.com>
 <CADnq5_NPWa5s+dJwinBFLTzcGfycuuuin_YFp7CJnt_8A2p9eA@mail.gmail.com>
 <CAEzXK1rsnm318e6tE+9f=A3pAB4fHw3XUY0dMgvno4yUcoxgjA@mail.gmail.com>
 <c9d12d8c-a186-4041-ea41-1ccabe41eb29@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a113e4d6eb227de05643f1f07"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c9d12d8c-a186-4041-ea41-1ccabe41eb29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--001a113e4d6eb227de05643f1f07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian, Alexander,

I have enabled kmemleak, but memleak didn't detect anything special,
in fact this time, I don't know why, I didn't get any allocation
failure at all, but the GPU did hang after around 4h 6m of uptime with
Xorg.
The log can be found in attachment. I will try again to see if the
allocation failure reappears, or if it has become less apparent due to
kmemleak scans.

The kernel stack trace is similar to the GPU hangs I was getting on
earlier kernel versions with Kodi, or Firefox when watching videos
with either one, but if I left Xorg idle, it would remain up and
available without hanging for more than one day.
This stack trace also looks quite similar to what Daniel Andersson
reported in "[BUG] Intermittent hang/deadlock when opening browser tab
with Vega gpu", looks like another demonstration of the same bug on
different architectures.

Regards,
Lu=C3=ADs

On Fri, Feb 2, 2018 at 7:48 AM, Christian K=C3=B6nig
<ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Luis,
>
> please enable kmemleak in your build and watch out for any suspicious
> messages in the system log.
>
> Regards,
> Christian.
>
>
> Am 02.02.2018 um 00:03 schrieb Lu=C3=ADs Mendes:
>>
>> Hi Alexander,
>>
>> I didn't notice improvements on this issue with that particular patch
>> applied. It still ends up failing to allocate kernel memory after a
>> few hours of uptime with Xorg.
>>
>> I will try to upgrade to mesa 18.0.0-rc3 and to amd-staging-drm-next
>> head, to see if the issue still occurs with those versions.
>>
>> If you have additional suggestions I'll be happy to try them.
>>
>> Regards,
>> Lu=C3=ADs Mendes
>>
>> On Thu, Feb 1, 2018 at 2:30 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> wrote:
>>>
>>> On Wed, Jan 31, 2018 at 6:57 PM, Lu=C3=ADs Mendes <luis.p.mendes@gmail.=
com>
>>> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> I am getting a new issue with amdgpu with RX460, that is, now I can
>>>> play any videos with Kodi or play web videos with firefox and run
>>>> OpenGL applications without running into any issues, however after
>>>> some uptime with XOrg even when almost inactive I get a kmalloc
>>>> allocation failure, normally followed by a GPU hang a while after the
>>>> the allocation failure.
>>>> I had a terminal window under Ubuntu Mate 17.10 and I was compiling
>>>> code when I got the kernel messages that can be found in attachment.
>>>>
>>>> I am using the kernel as identified on my previous email, which can be
>>>> found below.
>>>
>>> does this patch help?
>>> https://patchwork.freedesktop.org/patch/198258/
>>>
>>> Alex
>>>
>>>> Regards,
>>>> Lu=C3=ADs Mendes
>>>>
>>>> On Wed, Jan 31, 2018 at 12:47 PM, Lu=C3=ADs Mendes <luis.p.mendes@gmai=
l.com>
>>>> wrote:
>>>>>
>>>>> Hi Alexander,
>>>>>
>>>>> I've cherry picked the patch you pointed out into kernel from
>>>>> amd-drm-next-4.17-wip at commit
>>>>> 9ab2894122275a6d636bb2654a157e88a0f7b9e2 ( drm/amdgpu: set
>>>>> DRIVER_ATOMIC flag early) and tested it on ARMv7l and the problem has
>>>>> gone indeed.
>>>>>
>>>>>
>>>>> Working great on ARMv7l with AMD RX460.
>>>>>
>>>>> Thanks,
>>>>> Lu=C3=ADs Mendes
>>>>>
>>>>>
>>>>> On Tue, Jan 30, 2018 at 6:44 PM, Deucher, Alexander
>>>>> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:
>>>>>>
>>>>>> Fixed with this patch:
>>>>>>
>>>>>>
>>>>>> https://lists.freedesktop.org/archives/amd-gfx/2018-January/018472.h=
tml
>>>>>>
>>>>>>
>>>>>> Alex
>>>>
>>>> <>
>>>>>>
>>>>>> __________________
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--001a113e4d6eb227de05643f1f07
Content-Type: text/plain; charset="US-ASCII"; name="AMDGPU_new_hang3.txt"
Content-Disposition: attachment; filename="AMDGPU_new_hang3.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jd69uvdv0

RmViICAyIDE2OjI5OjI5IGxvY2FsaG9zdCBrZXJuZWw6IFsxNDgwMS43NDA0NjddIFtkcm06YW1k
Z3B1X2pvYl90aW1lZG91dCBbYW1kZ3B1XV0gKkVSUk9SKiByaW5nIGdmeCB0aW1lb3V0LCBsYXN0
IHNpZ25hbGVkIHNlcT04MzEwMDYsIGxhc3QgZW1pdHRlZCBzZXE9ODMxMDA4CkZlYiAgMiAxNjoy
OToyOSBsb2NhbGhvc3Qga2VybmVsOiBbMTQ4MDEuNzUxNTU3XSBbZHJtXSBJUCBibG9jazpnbWNf
djhfMCBpcyBodW5nIQpGZWIgIDIgMTY6Mjk6MjkgbG9jYWxob3N0IGtlcm5lbDogWzE0ODAxLjc1
MTU2M10gW2RybV0gSVAgYmxvY2s6Z2Z4X3Y4XzAgaXMgaHVuZyEKRmViICAyIDE2OjI5OjI5IGxv
Y2FsaG9zdCBrZXJuZWw6IFsxNDgwMS43NTE2MTFdIFtkcm1dIEdQVSByZWNvdmVyeSBkaXNhYmxl
ZC4KRmViICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NTYxODFdIElORk86
IHRhc2sgYW1kZ3B1X2NzOjA6MzgwMyBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIwIHNlY29uZHMu
CkZlYiAgMiAxNjo0NDo1MyBsb2NhbGhvc3Qga2VybmVsOiBbMTU3MjUuODYzMDg1XSAgICAgICBO
b3QgdGFpbnRlZCA0LjE1LjAtcmM4LW5leHQyZy1nOWFiMjg5NC1kaXJ0eSAjMwpGZWIgIDIgMTY6
NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg2OTIxM10gImVjaG8gMCA+IC9wcm9jL3N5
cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLgpG
ZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3NzA3OF0gYW1kZ3B1X2Nz
OjAgICAgIEQgICAgMCAgMzgwMyAgIDMwOTEgMHgwMDAwMDAwMApGZWIgIDIgMTY6NDQ6NTMgbG9j
YWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3NzA4NF0gQmFja3RyYWNlOiAKRmViICAyIDE2OjQ0OjUz
IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NzcwOTZdIFs8ODBiNTcxYzg+XSAoX19zY2hlZHVs
ZSkgZnJvbSBbPDgwYjU3OGNjPl0gKHNjaGVkdWxlKzB4NDQvMHhhNCkKRmViICAyIDE2OjQ0OjUz
IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NzcxMDJdICByMTA6NjAwZjAwMTMgcjk6YjQ1YjYw
MDAgcjg6YjQ1YjdiZDQgcjc6MDAwMDAwMDAgcjY6N2ZmZmZmZmYgcjU6ODEwMDRjNDgKRmViICAy
IDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NzcxMDRdICByNDpmZmZmZTAwMApG
ZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3NzExMF0gWzw4MGI1Nzg4
OD5dIChzY2hlZHVsZSkgZnJvbSBbPDgwYjViNGYwPl0gKHNjaGVkdWxlX3RpbWVvdXQrMHgxZTAv
MHgyZTgpCkZlYiAgMiAxNjo0NDo1MyBsb2NhbGhvc3Qga2VybmVsOiBbMTU3MjUuODc3MTEyXSAg
cjU6ODEwMDRjNDggcjQ6N2ZmZmZmZmYKRmViICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJuZWw6
IFsxNTcyNS44NzcxMjFdIFs8ODBiNWIzMTA+XSAoc2NoZWR1bGVfdGltZW91dCkgZnJvbSBbPDgw
NjVkZjNjPl0gKGRtYV9mZW5jZV9kZWZhdWx0X3dhaXQrMHgyMTgvMHgyYjApCkZlYiAgMiAxNjo0
NDo1MyBsb2NhbGhvc3Qga2VybmVsOiBbMTU3MjUuODc3MTI1XSAgcjEwOjYwMGYwMDEzIHI5OmI0
NWI2MDAwIHI4OmI0NWI3YmQ0IHI3OjAwMDAwMDAwIHI2OjdmZmZmZmZmIHI1OjgxMDA0YzQ4CkZl
YiAgMiAxNjo0NDo1MyBsb2NhbGhvc3Qga2VybmVsOiBbMTU3MjUuODc3MTI3XSAgcjQ6OWRlMTIy
ODAKRmViICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NzcxMzJdIFs8ODA2
NWRkMjQ+XSAoZG1hX2ZlbmNlX2RlZmF1bHRfd2FpdCkgZnJvbSBbPDgwNjVkNmI0Pl0gKGRtYV9m
ZW5jZV93YWl0X3RpbWVvdXQrMHg0OC8weDE1YykKRmViICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBr
ZXJuZWw6IFsxNTcyNS44NzcxMzddICByMTA6YjQ1OTM4MDAgcjk6YmJmZDgwMDAgcjg6MDAwMDAw
MDEgcjc6YTE3YjM3NjggcjY6MDAwMDAwMDAgcjU6OWRlMTIyODAKRmViICAyIDE2OjQ0OjUzIGxv
Y2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NzcxMzhdICByNDo4MTA5NmMxOApGZWIgIDIgMTY6NDQ6
NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3NzM0Ml0gWzw4MDY1ZDY2Yz5dIChkbWFfZmVu
Y2Vfd2FpdF90aW1lb3V0KSBmcm9tIFs8N2YxYjViYzg+XSAoYW1kZ3B1X2N0eF93YWl0X3ByZXZf
ZmVuY2UrMHg0OC8weDgwIFthbWRncHVdKQpGZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5l
bDogWzE1NzI1Ljg3NzM0Nl0gIHI3OmExN2IzNzY4IHI2OjAwMDAwMDAxIHI1OmIzNDFlNmMwIHI0
OjAwMDAwMDAxCkZlYiAgMiAxNjo0NDo1MyBsb2NhbGhvc3Qga2VybmVsOiBbMTU3MjUuODc3NjA2
XSBbPDdmMWI1YjgwPl0gKGFtZGdwdV9jdHhfd2FpdF9wcmV2X2ZlbmNlIFthbWRncHVdKSBmcm9t
IFs8N2YxOWU3ODA+XSAoYW1kZ3B1X2NzX2lvY3RsKzB4NDI4LzB4MWVkYyBbYW1kZ3B1XSkKRmVi
ICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44Nzc2MDldICByNTpiMzQxZTZj
MCByNDowMDAwMDAwMQpGZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3
Nzc3M10gWzw3ZjE5ZTM1OD5dIChhbWRncHVfY3NfaW9jdGwgW2FtZGdwdV0pIGZyb20gWzw3ZjA4
YjkyMD5dIChkcm1faW9jdGxfa2VybmVsKzB4NjgvMHhiNCBbZHJtXSkKRmViICAyIDE2OjQ0OjUz
IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44Nzc3NzhdICByMTA6MDAwMDAwMTggcjk6YjQ1Yjdl
MmMgcjg6N2YxOWUzNTggcjc6MDAwMDAwMjEgcjY6MDAwMDAwMDAgcjU6YmJmZjAwMDAKRmViICAy
IDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44Nzc3NzldICByNDpiZTlkMzBjMApG
ZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3NzgyMV0gWzw3ZjA4Yjhi
OD5dIChkcm1faW9jdGxfa2VybmVsIFtkcm1dKSBmcm9tIFs8N2YwOGJkZWM+XSAoZHJtX2lvY3Rs
KzB4MmNjLzB4M2IwIFtkcm1dKQpGZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1
NzI1Ljg3NzgyNV0gIHI5OjAwMDAwMDQ0IHI4OmMwMTg2NDQ0IHI3OmJlOWQzMGMwIHI2OjdmMTll
MzU4IHI1OjdmMmZjYmE0IHI0OjgxMDA0YzQ4CkZlYiAgMiAxNjo0NDo1MyBsb2NhbGhvc3Qga2Vy
bmVsOiBbMTU3MjUuODc3OTcxXSBbPDdmMDhiYjIwPl0gKGRybV9pb2N0bCBbZHJtXSkgZnJvbSBb
PDdmMTgwMDEwPl0gKGFtZGdwdV9kcm1faW9jdGwrMHgxMC8weDE0IFthbWRncHVdKQpGZWIgIDIg
MTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3Nzk3Nl0gIHIxMDpiYjViZjIxMCBy
OTpiNDViNjAwMCByODo3MzIyYWFhMCByNzowMDAwMDAwYyByNjpiMDY5NGQ4MCByNTo3MzIyYWFh
MApGZWIgIDIgMTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3Nzk3N10gIHI0Ojgx
MDA0YzQ4CkZlYiAgMiAxNjo0NDo1MyBsb2NhbGhvc3Qga2VybmVsOiBbMTU3MjUuODc4MTAzXSBb
PDdmMTgwMDAwPl0gKGFtZGdwdV9kcm1faW9jdGwgW2FtZGdwdV0pIGZyb20gWzw4MDI4ZTRiND5d
IChkb192ZnNfaW9jdGwrMHhiOC8weDhjYykKRmViICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBrZXJu
ZWw6IFsxNTcyNS44NzgxMDhdIFs8ODAyOGUzZmM+XSAoZG9fdmZzX2lvY3RsKSBmcm9tIFs8ODAy
OGVkMDQ+XSAoU3lTX2lvY3RsKzB4M2MvMHg2MCkKRmViICAyIDE2OjQ0OjUzIGxvY2FsaG9zdCBr
ZXJuZWw6IFsxNTcyNS44NzgxMTJdICByMTA6MDAwMDAwMDAgcjk6YjQ1YjYwMDAgcjg6NzMyMmFh
YTAgcjc6YzAxODY0NDQgcjY6MDAwMDAwMGMgcjU6YjA2OTRkODAKRmViICAyIDE2OjQ0OjUzIGxv
Y2FsaG9zdCBrZXJuZWw6IFsxNTcyNS44NzgxMTRdICByNDpiMDY5NGQ4MQpGZWIgIDIgMTY6NDQ6
NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3ODEyMV0gWzw4MDI4ZWNjOD5dIChTeVNfaW9j
dGwpIGZyb20gWzw4MDEwOGYwMD5dIChyZXRfZmFzdF9zeXNjYWxsKzB4MC8weDU0KQpGZWIgIDIg
MTY6NDQ6NTMgbG9jYWxob3N0IGtlcm5lbDogWzE1NzI1Ljg3ODEyNV0gIHI5OmI0NWI2MDAwIHI4
OjgwMTA5MGU0IHI3OjAwMDAwMDM2IHI2OmMwMTg2NDQ0IHI1OjczMjJhYWEwIHI0OmMwMDA2NDAw
CkZlYiAgMiAxNjo0Njo1NiBsb2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzMwNTA1XSBJTkZPOiB0
YXNrIGFtZGdwdV9jczowOjM4MDMgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRzLgpG
ZWIgIDIgMTY6NDY6NTYgbG9jYWxob3N0IGtlcm5lbDogWzE1ODQ4LjczNzQxM10gICAgICAgTm90
IHRhaW50ZWQgNC4xNS4wLXJjOC1uZXh0MmctZzlhYjI4OTQtZGlydHkgIzMKRmViICAyIDE2OjQ2
OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NDM1NDFdICJlY2hvIDAgPiAvcHJvYy9zeXMv
a2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KRmVi
ICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTE0MDRdIGFtZGdwdV9jczow
ICAgICBEICAgIDAgIDM4MDMgICAzMDkxIDB4MDAwMDAwMDAKRmViICAyIDE2OjQ2OjU2IGxvY2Fs
aG9zdCBrZXJuZWw6IFsxNTg0OC43NTE0MTBdIEJhY2t0cmFjZTogCkZlYiAgMiAxNjo0Njo1NiBs
b2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUxNDIxXSBbPDgwYjU3MWM4Pl0gKF9fc2NoZWR1bGUp
IGZyb20gWzw4MGI1NzhjYz5dIChzY2hlZHVsZSsweDQ0LzB4YTQpCkZlYiAgMiAxNjo0Njo1NiBs
b2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUxNDI2XSAgcjEwOjYwMGYwMDEzIHI5OmI0NWI2MDAw
IHI4OmI0NWI3YmQ0IHI3OjAwMDAwMDAwIHI2OjdmZmZmZmZmIHI1OjgxMDA0YzQ4CkZlYiAgMiAx
Njo0Njo1NiBsb2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUxNDI4XSAgcjQ6ZmZmZmUwMDAKRmVi
ICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTE0MzRdIFs8ODBiNTc4ODg+
XSAoc2NoZWR1bGUpIGZyb20gWzw4MGI1YjRmMD5dIChzY2hlZHVsZV90aW1lb3V0KzB4MWUwLzB4
MmU4KQpGZWIgIDIgMTY6NDY6NTYgbG9jYWxob3N0IGtlcm5lbDogWzE1ODQ4Ljc1MTQzNl0gIHI1
OjgxMDA0YzQ4IHI0OjdmZmZmZmZmCkZlYiAgMiAxNjo0Njo1NiBsb2NhbGhvc3Qga2VybmVsOiBb
MTU4NDguNzUxNDQ0XSBbPDgwYjViMzEwPl0gKHNjaGVkdWxlX3RpbWVvdXQpIGZyb20gWzw4MDY1
ZGYzYz5dIChkbWFfZmVuY2VfZGVmYXVsdF93YWl0KzB4MjE4LzB4MmIwKQpGZWIgIDIgMTY6NDY6
NTYgbG9jYWxob3N0IGtlcm5lbDogWzE1ODQ4Ljc1MTQ0OV0gIHIxMDo2MDBmMDAxMyByOTpiNDVi
NjAwMCByODpiNDViN2JkNCByNzowMDAwMDAwMCByNjo3ZmZmZmZmZiByNTo4MTAwNGM0OApGZWIg
IDIgMTY6NDY6NTYgbG9jYWxob3N0IGtlcm5lbDogWzE1ODQ4Ljc1MTQ1MV0gIHI0OjlkZTEyMjgw
CkZlYiAgMiAxNjo0Njo1NiBsb2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUxNDU2XSBbPDgwNjVk
ZDI0Pl0gKGRtYV9mZW5jZV9kZWZhdWx0X3dhaXQpIGZyb20gWzw4MDY1ZDZiND5dIChkbWFfZmVu
Y2Vfd2FpdF90aW1lb3V0KzB4NDgvMHgxNWMpCkZlYiAgMiAxNjo0Njo1NiBsb2NhbGhvc3Qga2Vy
bmVsOiBbMTU4NDguNzUxNDYwXSAgcjEwOmI0NTkzODAwIHI5OmJiZmQ4MDAwIHI4OjAwMDAwMDAx
IHI3OmExN2IzNzY4IHI2OjAwMDAwMDAwIHI1OjlkZTEyMjgwCkZlYiAgMiAxNjo0Njo1NiBsb2Nh
bGhvc3Qga2VybmVsOiBbMTU4NDguNzUxNDYyXSAgcjQ6ODEwOTZjMTgKRmViICAyIDE2OjQ2OjU2
IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTE2NjddIFs8ODA2NWQ2NmM+XSAoZG1hX2ZlbmNl
X3dhaXRfdGltZW91dCkgZnJvbSBbPDdmMWI1YmM4Pl0gKGFtZGdwdV9jdHhfd2FpdF9wcmV2X2Zl
bmNlKzB4NDgvMHg4MCBbYW1kZ3B1XSkKRmViICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6
IFsxNTg0OC43NTE2NzFdICByNzphMTdiMzc2OCByNjowMDAwMDAwMSByNTpiMzQxZTZjMCByNDow
MDAwMDAwMQpGZWIgIDIgMTY6NDY6NTYgbG9jYWxob3N0IGtlcm5lbDogWzE1ODQ4Ljc1MTkzMF0g
Wzw3ZjFiNWI4MD5dIChhbWRncHVfY3R4X3dhaXRfcHJldl9mZW5jZSBbYW1kZ3B1XSkgZnJvbSBb
PDdmMTllNzgwPl0gKGFtZGdwdV9jc19pb2N0bCsweDQyOC8weDFlZGMgW2FtZGdwdV0pCkZlYiAg
MiAxNjo0Njo1NiBsb2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUxOTMzXSAgcjU6YjM0MWU2YzAg
cjQ6MDAwMDAwMDEKRmViICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTIw
OThdIFs8N2YxOWUzNTg+XSAoYW1kZ3B1X2NzX2lvY3RsIFthbWRncHVdKSBmcm9tIFs8N2YwOGI5
MjA+XSAoZHJtX2lvY3RsX2tlcm5lbCsweDY4LzB4YjQgW2RybV0pCkZlYiAgMiAxNjo0Njo1NiBs
b2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUyMTAzXSAgcjEwOjAwMDAwMDE4IHI5OmI0NWI3ZTJj
IHI4OjdmMTllMzU4IHI3OjAwMDAwMDIxIHI2OjAwMDAwMDAwIHI1OmJiZmYwMDAwCkZlYiAgMiAx
Njo0Njo1NiBsb2NhbGhvc3Qga2VybmVsOiBbMTU4NDguNzUyMTA1XSAgcjQ6YmU5ZDMwYzAKRmVi
ICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTIxNDRdIFs8N2YwOGI4Yjg+
XSAoZHJtX2lvY3RsX2tlcm5lbCBbZHJtXSkgZnJvbSBbPDdmMDhiZGVjPl0gKGRybV9pb2N0bCsw
eDJjYy8weDNiMCBbZHJtXSkKRmViICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0
OC43NTIxNDhdICByOTowMDAwMDA0NCByODpjMDE4NjQ0NCByNzpiZTlkMzBjMCByNjo3ZjE5ZTM1
OCByNTo3ZjJmY2JhNCByNDo4MTAwNGM0OApGZWIgIDIgMTY6NDY6NTYgbG9jYWxob3N0IGtlcm5l
bDogWzE1ODQ4Ljc1MjI5NV0gWzw3ZjA4YmIyMD5dIChkcm1faW9jdGwgW2RybV0pIGZyb20gWzw3
ZjE4MDAxMD5dIChhbWRncHVfZHJtX2lvY3RsKzB4MTAvMHgxNCBbYW1kZ3B1XSkKRmViICAyIDE2
OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTIyOTldICByMTA6YmI1YmYyMTAgcjk6
YjQ1YjYwMDAgcjg6NzMyMmFhYTAgcjc6MDAwMDAwMGMgcjY6YjA2OTRkODAgcjU6NzMyMmFhYTAK
RmViICAyIDE2OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTIzMDFdICByNDo4MTAw
NGM0OApGZWIgIDIgMTY6NDY6NTYgbG9jYWxob3N0IGtlcm5lbDogWzE1ODQ4Ljc1MjQyNl0gWzw3
ZjE4MDAwMD5dIChhbWRncHVfZHJtX2lvY3RsIFthbWRncHVdKSBmcm9tIFs8ODAyOGU0YjQ+XSAo
ZG9fdmZzX2lvY3RsKzB4YjgvMHg4Y2MpCkZlYiAgMiAxNjo0Njo1NiBsb2NhbGhvc3Qga2VybmVs
OiBbMTU4NDguNzUyNDMyXSBbPDgwMjhlM2ZjPl0gKGRvX3Zmc19pb2N0bCkgZnJvbSBbPDgwMjhl
ZDA0Pl0gKFN5U19pb2N0bCsweDNjLzB4NjApCkZlYiAgMiAxNjo0Njo1NiBsb2NhbGhvc3Qga2Vy
bmVsOiBbMTU4NDguNzUyNDM2XSAgcjEwOjAwMDAwMDAwIHI5OmI0NWI2MDAwIHI4OjczMjJhYWEw
IHI3OmMwMTg2NDQ0IHI2OjAwMDAwMDBjIHI1OmIwNjk0ZDgwCkZlYiAgMiAxNjo0Njo1NiBsb2Nh
bGhvc3Qga2VybmVsOiBbMTU4NDguNzUyNDM4XSAgcjQ6YjA2OTRkODEKRmViICAyIDE2OjQ2OjU2
IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTI0NDVdIFs8ODAyOGVjYzg+XSAoU3lTX2lvY3Rs
KSBmcm9tIFs8ODAxMDhmMDA+XSAocmV0X2Zhc3Rfc3lzY2FsbCsweDAvMHg1NCkKRmViICAyIDE2
OjQ2OjU2IGxvY2FsaG9zdCBrZXJuZWw6IFsxNTg0OC43NTI0NDldICByOTpiNDViNjAwMCByODo4
MDEwOTBlNCByNzowMDAwMDAzNiByNjpjMDE4NjQ0NCByNTo3MzIyYWFhMCByNDpjMDAwNjQwMAo=
--001a113e4d6eb227de05643f1f07
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--001a113e4d6eb227de05643f1f07--
