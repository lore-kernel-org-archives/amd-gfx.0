Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCE5C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 08:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F47A10E70F;
	Wed, 13 Dec 2023 08:38:55 +0000 (UTC)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F1410E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 00:08:21 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
 by mxout4.routing.net (Postfix) with ESMTP id 262EF1014EA;
 Wed, 13 Dec 2023 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1702426099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nM2Bpbs2l9SiPcEMpCDiBRVVrw6oguTVkos4xwC7Zrg=;
 b=CMAcr59O5gynV4ZXra4CCTCx5TdPvwUXO8j26Twd9rOpg2YDq2Uwve50OGZmwtSzJq/ZqT
 mPDlAayonHnARGHuK7rZLnuypwBp/l+SoMZi4HpYXWbkfXIAxNz6pkfBKcwkgYV7zA9vjl
 dr0/mzs7w9/buMlnwMGj2Yoq3xMsUiU=
Received: from [192.168.178.75]
 (dynamic-077-008-155-155.77.8.pool.telefonica.de [77.8.155.155])
 by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 5C589360347;
 Wed, 13 Dec 2023 00:08:18 +0000 (UTC)
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20231205195436.16081-1-mario.limonciello@amd.com>
 <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com>
 <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
 <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com>
From: Oliver Schmidt <oliver@luced.de>
Message-ID: <24cd225b-df66-14c1-d951-72c4a5509437@luced.de>
Date: Wed, 13 Dec 2023 01:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mail-ID: 01fa0e6a-2c3c-4573-8fd7-47a81038bb6c
X-Mailman-Approved-At: Wed, 13 Dec 2023 08:38:54 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 Oliver Schmidt <oliver@luced.de>,
 Linux Regressions <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Wayne,

On 12.12.23 17:06, Mario Limonciello wrote:
> I looked through your bugs related to this and I didn't see a reference to the
> specific docking station model.
> The logs mentioned "Thinkpad dock" but no model.
> Could you share more about it so that AMD can try to reproduce it?

Yes, it is a ThinkPad Ultra Dockingstation, part number 40AJ0135EU, see also
https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-docking-station-overview-and-service-parts

Best regards,
Oliver

On 12.12.23 17:06, Mario Limonciello wrote:
> On 12/12/2023 04:10, Lin, Wayne wrote:
>> [Public]
>>
>> Hi Mario,
>>
>> Thanks for the help.
>> My feeling is like this problem probably relates to specific dock. Need time
>> to take
>> further look.
> 
> Oliver,
> 
> I looked through your bugs related to this and I didn't see a reference to the
> specific docking station model.
> The logs mentioned "Thinkpad dock" but no model.
> 
> Could you share more about it so that AMD can try to reproduce it?
> 
>>
>> Since reverting solves the issue now, feel free to add:
>> Acked-by: Wayne Lin <wayne.lin@amd.com>
> 
> Sure, thanks.
> 
>>
>> Thanks,
>> Wayne
>>
>>> -----Original Message-----
>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Sent: Tuesday, December 12, 2023 12:15 AM
>>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
>>> <Harry.Wentland@amd.com>
>>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.kernel.org;
>>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
>>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
>>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
>>>
>>> Ping on this one.
>>>
>>> On 12/5/2023 13:54, Mario Limonciello wrote:
>>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
>>>>
>>>> Reports are that this causes problems with external monitors after
>>>> wake up from suspend, which is something it was directly supposed to help.
>>>>
>>>> Cc: Linux Regressions <regressions@lists.linux.dev>
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>>>> Cc: Wayne Lin <wayne.lin@amd.com>
>>>> Reported-by: Oliver Schmidt <oliver@luced.de>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
>>>> Link:
>>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-aft
>>>> er-suspend/151840
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
>>>> Signed-off-by: Mario Limonciello <mario.limonciello
>>>> <mario.limonciello@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++--------------
>>> -- 
>>>>    1 file changed, 13 insertions(+), 80 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index c146dc9cba92..1ba58e4ecab3 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
>>>>      return detect_mst_link_for_all_connectors(adev_to_drm(adev));
>>>>    }
>>>>
>>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr
>>>> *mgr) -{
>>>> -   int ret;
>>>> -   u8 guid[16];
>>>> -   u64 tmp64;
>>>> -
>>>> -   mutex_lock(&mgr->lock);
>>>> -   if (!mgr->mst_primary)
>>>> -           goto out_fail;
>>>> -
>>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>> suspend?\n");
>>>> -           goto out_fail;
>>>> -   }
>>>> -
>>>> -   ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
>>>> -                            DP_MST_EN |
>>>> -                            DP_UP_REQ_EN |
>>>> -                            DP_UPSTREAM_IS_SRC);
>>>> -   if (ret < 0) {
>>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked during
>>> suspend?\n");
>>>> -           goto out_fail;
>>>> -   }
>>>> -
>>>> -   /* Some hubs forget their guids after they resume */
>>>> -   ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
>>>> -   if (ret != 16) {
>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>> suspend?\n");
>>>> -           goto out_fail;
>>>> -   }
>>>> -
>>>> -   if (memchr_inv(guid, 0, 16) == NULL) {
>>>> -           tmp64 = get_jiffies_64();
>>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
>>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
>>>> -
>>>> -           ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
>>>> -
>>>> -           if (ret != 16) {
>>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
>>> undocked during suspend?\n");
>>>> -                   goto out_fail;
>>>> -           }
>>>> -   }
>>>> -
>>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
>>>> -
>>>> -out_fail:
>>>> -   mutex_unlock(&mgr->lock);
>>>> -}
>>>> -
>>>>    static void s3_handle_mst(struct drm_device *dev, bool suspend)
>>>>    {
>>>>      struct amdgpu_dm_connector *aconnector;
>>>>      struct drm_connector *connector;
>>>>      struct drm_connector_list_iter iter;
>>>>      struct drm_dp_mst_topology_mgr *mgr;
>>>> +   int ret;
>>>> +   bool need_hotplug = false;
>>>>
>>>>      drm_connector_list_iter_begin(dev, &iter);
>>>>      drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
>>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
>>> suspend)
>>>>                      if (!dp_is_lttpr_present(aconnector->dc_link))
>>>>                              try_to_configure_aux_timeout(aconnector-
>>>> dc_link->ddc,
>>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>>>>
>>>> -                   /* TODO: move resume_mst_branch_status() into
>>> drm mst resume again
>>>> -                    * once topology probing work is pulled out from mst
>>> resume into mst
>>>> -                    * resume 2nd step. mst resume 2nd step should be
>>> called after old
>>>> -                    * state getting restored (i.e.
>>> drm_atomic_helper_resume()).
>>>> -                    */
>>>> -                   resume_mst_branch_status(mgr);
>>>> +                   ret = drm_dp_mst_topology_mgr_resume(mgr, true);
>>>> +                   if (ret < 0) {
>>>> +
>>>        dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
>>>> +                                   aconnector->dc_link);
>>>> +                           need_hotplug = true;
>>>> +                   }
>>>>              }
>>>>      }
>>>>      drm_connector_list_iter_end(&iter);
>>>> +
>>>> +   if (need_hotplug)
>>>> +           drm_kms_helper_hotplug_event(dev);
>>>>    }
>>>>
>>>>    static int amdgpu_dm_smu_write_watermarks_table(struct
>>> amdgpu_device
>>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
>>>>      struct dm_atomic_state *dm_state = to_dm_atomic_state(dm-
>>>> atomic_obj.state);
>>>>      enum dc_connection_type new_connection_type =
>>> dc_connection_none;
>>>>      struct dc_state *dc_state;
>>>> -   int i, r, j, ret;
>>>> -   bool need_hotplug = false;
>>>> +   int i, r, j;
>>>>
>>>>      if (dm->dc->caps.ips_support) {
>>>>              dc_dmub_srv_exit_low_power_state(dm->dc);
>>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
>>>>                      continue;
>>>>
>>>>              /*
>>>> -            * this is the case when traversing through already created end
>>> sink
>>>> +            * this is the case when traversing through already created
>>>>               * MST connectors, should be skipped
>>>>               */
>>>>              if (aconnector && aconnector->mst_root) @@ -3017,27
>>> +2971,6 @@
>>>> static int dm_resume(void *handle)
>>>>
>>>>      dm->cached_state = NULL;
>>>>
>>>> -   /* Do mst topology probing after resuming cached state*/
>>>> -   drm_connector_list_iter_begin(ddev, &iter);
>>>> -   drm_for_each_connector_iter(connector, &iter) {
>>>> -           aconnector = to_amdgpu_dm_connector(connector);
>>>> -           if (aconnector->dc_link->type != dc_connection_mst_branch
>>> ||
>>>> -               aconnector->mst_root)
>>>> -                   continue;
>>>> -
>>>> -           ret = drm_dp_mst_topology_mgr_resume(&aconnector-
>>>> mst_mgr, true);
>>>> -
>>>> -           if (ret < 0) {
>>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
>>>> dc_link->ctx,
>>>> -                                   aconnector->dc_link);
>>>> -                   need_hotplug = true;
>>>> -           }
>>>> -   }
>>>> -   drm_connector_list_iter_end(&iter);
>>>> -
>>>> -   if (need_hotplug)
>>>> -           drm_kms_helper_hotplug_event(ddev);
>>>> -
>>>>      amdgpu_dm_irq_resume_late(adev);
>>>>
>>>>      amdgpu_dm_smu_write_watermarks_table(adev);
>>
> 
