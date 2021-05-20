Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68D0C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4892F61163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892F61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018936E13C;
	Thu, 20 May 2021 12:49:11 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD70F6E408;
 Thu, 20 May 2021 08:26:51 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <colin.king@canonical.com>)
 id 1lje14-0001aS-9X; Thu, 20 May 2021 08:26:50 +0000
From: Colin Ian King <colin.king@canonical.com>
Subject: re: drm/amdgpu/acpi: unify ATCS handling (v2) [uninitialized variable
 error]
To: Alex Deucher <alexander.deucher@amd.com>
Message-ID: <89aaa652-7e9b-dee1-cb8a-2fb11212a100@canonical.com>
Date: Thu, 20 May 2021 09:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Static analysis on linux-next with Coverity has detected an issue in
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c with the following commit:

commit c1c4d8efdddec8a0ccc8525b29740640bd652ce8
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Wed May 19 15:47:42 2021 -0400

    drm/amdgpu/acpi: unify ATCS handling (v2)


The analysis is as follows:


805int amdgpu_acpi_init(struct amdgpu_device *adev)
806{
807        acpi_handle handle, atif_handle, atcs_handle;
808        struct amdgpu_atif *atif;
809        struct amdgpu_atcs *atcs;

   1. var_decl: Declaring variable ret without initializer.

810        int ret;
811
812        /* Get the device handle */

   2. Condition is_acpi_device_node(__to_acpi_device_node_fwnode),
taking true branch.
   3. Condition 0 /* !!(!__builtin_types_compatible_p() &&
!__builtin_types_compatible_p()) */, taking false branch.

813        handle = ACPI_HANDLE(&adev->pdev->dev);
814

   4. Condition !adev->bios, taking false branch.
   5. Condition !handle, taking false branch.

815        if (!adev->bios || !handle)
816                return 0;
817
818        /* Probe for ATIF, and initialize it if found */
819        atif_handle = amdgpu_atif_probe_handle(handle);

   6. Condition !atif_handle, taking true branch.
820        if (!atif_handle)
   7. Jumping to label atcs.

821                goto atcs;
822
823        atif = kzalloc(sizeof(*atif), GFP_KERNEL);
824        if (!atif) {
825                DRM_WARN("Not enough memory to initialize ATIF\n");
826                goto atcs;
827        }
828        atif->handle = atif_handle;
829
830        /* Call the ATIF method */
831        ret = amdgpu_atif_verify_interface(atif);
832        if (ret) {
833                DRM_DEBUG_DRIVER("Call to ATIF verify_interface
failed: %d\n", ret);
834                kfree(atif);
835                goto atcs;
836        }
837        adev->atif = atif;
838
839#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||
defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
840        if (atif->notifications.brightness_change) {
841                if (amdgpu_device_has_dc_support(adev)) {
842#if defined(CONFIG_DRM_AMD_DC)
843                        struct amdgpu_display_manager *dm = &adev->dm;
844                        if (dm->backlight_dev)
845                                atif->bd = dm->backlight_dev;
846#endif
847                } else {
848                        struct drm_encoder *tmp;
849
850                        /* Find the encoder controlling the brightness */
851                        list_for_each_entry(tmp,
&adev_to_drm(adev)->mode_config.encoder_list,
852                                            head) {
853                                struct amdgpu_encoder *enc =
to_amdgpu_encoder(tmp);
854
855                                if ((enc->devices &
(ATOM_DEVICE_LCD_SUPPORT)) &&
856                                    enc->enc_priv) {
857                                        struct
amdgpu_encoder_atom_dig *dig = enc->enc_priv;
858                                        if (dig->bl_dev) {
859                                                atif->bd = dig->bl_dev;
860                                                break;
861                                        }
862                                }
863                        }
864                }
865        }
866#endif
867
868        if (atif->functions.sbios_requests &&
!atif->functions.system_params) {
869                /* XXX check this workraround, if sbios request
function is
870                 * present we have to see how it's configured in the
system
871                 * params
872                 */
873                atif->functions.system_params = true;
874        }
875
876        if (atif->functions.system_params) {
877                ret = amdgpu_atif_get_notification_params(atif);
878                if (ret) {
879                        DRM_DEBUG_DRIVER("Call to GET_SYSTEM_PARAMS
failed: %d\n",
880                                        ret);
881                        /* Disable notification */
882                        atif->notification_cfg.enabled = false;
883                }
884        }
885
886        if (atif->functions.query_backlight_transfer_characteristics) {
887                ret = amdgpu_atif_query_backlight_caps(atif);
888                if (ret) {
889                        DRM_DEBUG_DRIVER("Call to
QUERY_BACKLIGHT_TRANSFER_CHARACTERISTICS failed: %d\n",
890                                        ret);
891                        atif->backlight_caps.caps_valid = false;
892                }
893        } else {
894                atif->backlight_caps.caps_valid = false;
895        }
896
897atcs:
898        /* Probe for ATCS, and initialize it if found */
899        atcs_handle = amdgpu_atcs_probe_handle(handle);

   8. Condition !atcs_handle, taking true branch.
900        if (!atcs_handle)
   9. Jumping to label out.

901                goto out;
902
903        atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
     CID 114228: Uninitialized pointer read (UNINIT) [select issue]
904        if (!atif) {
905                DRM_WARN("Not enough memory to initialize ATCS\n");
906                goto out;
907        }
908        atcs->handle = atcs_handle;
909
910        /* Call the ATCS method */
911        ret = amdgpu_atcs_verify_interface(atcs);
912        if (ret) {
913                DRM_DEBUG_DRIVER("Call to ATCS verify_interface
failed: %d\n", ret);
914                kfree(atcs);
915                goto out;
916        }
917        adev->atcs = atcs;
918
919out:
920        adev->acpi_nb.notifier_call = amdgpu_acpi_event;
921        register_acpi_notifier(&adev->acpi_nb);
922

  Uninitialized scalar variable (UNINIT)
  10. uninit_use: Using uninitialized value ret.

923        return ret;
924}

The chain of gotos end up with an uninitialized ret being returned on an
error condition. I was sure what value to assign to ret for this error
case, so I'm reporting this issue.

Colin
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
