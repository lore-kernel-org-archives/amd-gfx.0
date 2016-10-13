From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: don't give up if DPM is already running
Date: Thu, 13 Oct 2016 11:29:19 -0400
Message-ID: <CADnq5_M=Lt1qoOG2=T+t+TjaJNJQpU=_vPqUZbusAq+6O7Hq9Q@mail.gmail.com>
References: <1476040988-11676-1-git-send-email-notasas@gmail.com>
 <CADnq5_PBtB=c=ycPRU-gOndt8C7HaZL_7SxKD6uEBFvWsSXz8w@mail.gmail.com>
 <CY4PR12MB16875537013AAC3A7C43B615FBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CY4PR12MB1687EAFA6B672B00C4C608D4FBDC0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c05dd6205f81c053ec0c6da
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CY4PR12MB1687EAFA6B672B00C4C608D4FBDC0@CY4PR12MB1687.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Zhu, Rex" <Rex.Zhu@amd.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--94eb2c05dd6205f81c053ec0c6da
Content-Type: text/plain; charset=UTF-8

 On Thu, Oct 13, 2016 at 3:45 AM, Zhu, Rex <Rex.Zhu@amd.com> wrote:
> Hi all,
>
> The attached patches were also for this issue.
> Disable dpm when rmmod amdgpu.
>
> Please help to review.

Patch 1:
+    r = adev->ip_blocks[AMD_IP_BLOCK_TYPE_SMC].funcs->hw_fini((void *)adev);
+    if (r)
+        DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
+            adev->ip_blocks[AMD_IP_BLOCK_TYPE_SMC].funcs->name, r);
+
+    adev->ip_block_status[AMD_IP_BLOCK_TYPE_SMC].hw = false;

You can't use AMD_IP_BLOCK_TYPE_* as index.  Some chips may not have
the IP block.  Maybe something like the attached patch.  That said, I
think longer term it makes more sense to allows the SOCs to specify
the order for init, fini, etc. otherwise we'll have lots of variable
logic in the common code.

Patch 2:
+    if (1 == PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device,
CGS_IND_REG__SMC, FEATURE_STATUS, AVS_ON)) {
+        PP_ASSERT_WITH_CODE((0 == smum_send_msg_to_smc(hwmgr->smumgr,
PPSMC_MSG_DisableAvfs)),
+                    "Failed to disable AVFS!",
+                    return -1;);
+    }

Use a proper error code there like -EINVAL or something.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Best Regards
> Rex
>
> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces@lists.freedesktop.org] On Behalf Of Zhu, Rex
> Sent: Wednesday, October 12, 2016 9:45 PM
> To: Alex Deucher; Grazvydas Ignotas
> Cc: amd-gfx list; Maling list - DRI developers
> Subject: RE: [PATCH] drm/amd/powerplay: don't give up if DPM is already running
>
> Hi Grazvydas and Alex,
>
> We needed to disable dpm when rmmod amdgpu for this issue.
>
> I am checking the function of disable dpm task.
>
> Best Regards
> Rex
>
> -----Original Message-----
> From: Alex Deucher [mailto:alexdeucher@gmail.com]
> Sent: Wednesday, October 12, 2016 4:01 AM
> To: Grazvydas Ignotas; Zhu, Rex
> Cc: Maling list - DRI developers; amd-gfx list
> Subject: Re: [PATCH] drm/amd/powerplay: don't give up if DPM is already running
>
> +Rex to review this.
>
> Alex
>
> On Sun, Oct 9, 2016 at 3:23 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>> Currently the driver crashes if smu7_enable_dpm_tasks() returns early,
>> which it does if DPM is already active. It seems to be better just to
>> continue anyway, at least I haven't noticed any ill effects. It's also
>> unclear at what state the hardware was left by the previous driver, so
>> IMO it's better to always fully initialize.
>>
>> Way to reproduce:
>> $ modprobe amdgpu
>> $ rmmod amdgpu
>> $ modprobe amdgpu
>> ...
>> DPM is already running right now, no need to enable DPM!
>> ...
>> failed to send message 18b ret is 0
>> BUG: unable to handle kernel paging request at ffffed01fc9ab21f Call
>> Trace:
>>  smu7_set_power_state_tasks+0x499/0x1940 [amdgpu]
>>  phm_set_power_state+0xcb/0x120 [amdgpu]
>>  psm_adjust_power_state_dynamic+0x11e/0x1b0 [amdgpu]
>>  pem_task_adjust_power_state+0xb9/0xd0 [amdgpu]
>>  pem_excute_event_chain+0x7d/0xe0 [amdgpu]
>>  pem_handle_event_unlocked+0x49/0x60 [amdgpu]
>>  pem_handle_event+0xe/0x10 [amdgpu]
>>  pp_dpm_dispatch_tasks+0xe0/0x190 [amdgpu]
>>  amdgpu_pm_compute_clocks+0x10c/0xc60 [amdgpu]
>>  dce_v11_0_crtc_dpms+0x7d/0x150 [amdgpu]
>>  dce_v11_0_crtc_disable+0x90/0x4a0 [amdgpu]
>>  drm_helper_disable_unused_functions+0x67/0x80 [drm_kms_helper]
>>  amdgpu_fbdev_init+0x13e/0x170 [amdgpu]
>>  amdgpu_device_init+0x1aeb/0x2490 [amdgpu]
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> index f6afa6a..327030b 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> @@ -1166,8 +1166,8 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr
>> *hwmgr)
>>
>>         tmp_result = (!smum_is_dpm_running(hwmgr)) ? 0 : -1;
>>         PP_ASSERT_WITH_CODE(tmp_result == 0,
>> -                       "DPM is already running right now, no need to enable DPM!",
>> -                       return 0);
>> +                       "DPM is already running",
>> +                       );
>>
>>         if (smu7_voltage_control(hwmgr)) {
>>                 tmp_result = smu7_enable_voltage_control(hwmgr);
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c05dd6205f81c053ec0c6da
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-drm-amdgpu-disable-smu-hw-first-on-tear-down.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-disable-smu-hw-first-on-tear-down.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iu8hy4xd2

RnJvbSAwZTMzOGExMjdiYmU1ZWI5ZGUzN2E0MTMzMGE2MmIwYjBmNWUxOTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMTMgT2N0IDIwMTYgMTE6MjI6MTcgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkaXNhYmxlIHNtdSBodyBmaXJzdCBvbiB0ZWFyIGRvd24KCk90aGVyd2lz
ZSwgeW91IGNhbid0IGRpc2FibGUgZHBtLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDI0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKaW5kZXggYjg4YTNiNy4uNWE5OWE0MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTQ2Myw2ICsxNDYzLDMwIEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJaW50IGksIHI7
CiAKKwkvKiBuZWVkIHRvIGRpc2FibGUgU01DIGZpcnN0ICovCisJZm9yIChpID0gMDsgaSA8IGFk
ZXYtPm51bV9pcF9ibG9ja3M7IGkrKykgeworCQlpZiAoIWFkZXYtPmlwX2Jsb2NrX3N0YXR1c1tp
XS5odykKKwkJCWNvbnRpbnVlOworCQlpZiAoYWRldi0+aXBfYmxvY2tzW2ldLnR5cGUgPT0gQU1E
X0lQX0JMT0NLX1RZUEVfU01DKSB7CisJCQkvKiB1bmdhdGUgYmxvY2tzIGJlZm9yZSBodyBmaW5p
IHNvIHRoYXQgd2UgY2FuIHNodXRkb3duIHRoZSBibG9ja3Mgc2FmZWx5ICovCisJCQlyID0gYWRl
di0+aXBfYmxvY2tzW2ldLmZ1bmNzLT5zZXRfY2xvY2tnYXRpbmdfc3RhdGUoKHZvaWQgKilhZGV2
LAorCQkJCQkJCQkJICAgIEFNRF9DR19TVEFURV9VTkdBVEUpOworCQkJaWYgKHIpIHsKKwkJCQlE
Uk1fRVJST1IoInNldF9jbG9ja2dhdGluZ19zdGF0ZSh1bmdhdGUpIG9mIElQIGJsb2NrIDwlcz4g
ZmFpbGVkICVkXG4iLAorCQkJCQkgIGFkZXYtPmlwX2Jsb2Nrc1tpXS5mdW5jcy0+bmFtZSwgcik7
CisJCQkJcmV0dXJuIHI7CisJCQl9CisJCQlyID0gYWRldi0+aXBfYmxvY2tzW2ldLmZ1bmNzLT5o
d19maW5pKCh2b2lkICopYWRldik7CisJCQkvKiBYWFggaGFuZGxlIGVycm9ycyAqLworCQkJaWYg
KHIpIHsKKwkJCQlEUk1fREVCVUcoImh3X2Zpbmkgb2YgSVAgYmxvY2sgPCVzPiBmYWlsZWQgJWRc
biIsCisJCQkJCSAgYWRldi0+aXBfYmxvY2tzW2ldLmZ1bmNzLT5uYW1lLCByKTsKKwkJCX0KKwkJ
CWFkZXYtPmlwX2Jsb2NrX3N0YXR1c1tpXS5odyA9IGZhbHNlOworCQkJYnJlYWs7CisJCX0KKwl9
CisKIAlmb3IgKGkgPSBhZGV2LT5udW1faXBfYmxvY2tzIC0gMTsgaSA+PSAwOyBpLS0pIHsKIAkJ
aWYgKCFhZGV2LT5pcF9ibG9ja19zdGF0dXNbaV0uaHcpCiAJCQljb250aW51ZTsKLS0gCjIuNS41
Cgo=
--94eb2c05dd6205f81c053ec0c6da
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--94eb2c05dd6205f81c053ec0c6da--
