Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F42C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 21:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9251B60FD9
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 21:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9251B60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2062B89A35;
	Wed, 25 Aug 2021 21:01:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C7A89933
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 21:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwShK+VfZtNzkMVDRrytD2P6WHx7uqnuP2GxgQ+oAbU3S0dEwjKM8GLzRpFIgkhsPWWrzvXS08EeWaMDEKabu29CvqmwBlI5KgqRYk+h2tCHd5QL6XJS409KRX3Ueeojl2rTCDokP0e4jkIRVt4OBG4fvfVC2PbwsueYb4kksZmFU/5ydHfDkJyWZk6f/eLH4VcM0lTHJvO/VBzwZNomuUf9GACWn9O6vxSZXxm28UANCJCXZbaZpdakXTH/w0U4lNKR/CjnJtUb3rEJhXKjsxJ8UoGy69XJOMnosbq5axzUZbbd/03GkmgS7MeC4O9qzn+9g7+GOMTZQOWZZEtuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyHmWcXl6s2Ad8FkWjqHShAavuzaJp9B0L7KobX5gjI=;
 b=nGoWz96amqfXbUSkvnivV9v+vCKfVOlVOjgN6b96Ix9Tk0l0EixpPFg2rZyGan+vQrlKm93TxXU2/Yg2BpLxoFEI+MlGaKqT+Klvvfe5nXIfiVxWmk5r9x+x24nV+OydwGxEX6rlJ6+xrYFW1BrkkNMzw8BdwwZcX1oRHow83a+tFDhUY7tDGTlCpg91WheFynJgPBDZvWBuZvk3guEU3XlSThuBdU5MPyPOEkqHd7lxfwCzm3877YH0qm8JCwEUL2Quc8bS2zJp8oqX4pdBQIIgVycfYgclEpe5psFjMkWwYIU1yKLUmlDkCTHTSDRB1R9GSosTT0QB+erFHWidVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyHmWcXl6s2Ad8FkWjqHShAavuzaJp9B0L7KobX5gjI=;
 b=2/h9GbLbO8LZaDHtfOX2zdhwSEM+ZTLTpjIewnrjan/IC9pBobAMP+CnFUvMUYvzajxH6FPNFCRoHGxaTi1jwhfUiglZOK284oOWO8by4OhS/16R2HntZV+XCmV2rvLay9a7f0pDuvZeULf04MBP0aT5jqMqzLO17MOSLhrE4sw=
Received: from BN6PR1201MB0148.namprd12.prod.outlook.com
 (2603:10b6:405:55::21) by BN6PR1201MB0210.namprd12.prod.outlook.com
 (2603:10b6:405:59::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Wed, 25 Aug
 2021 21:01:23 +0000
Received: from BN6PR1201MB0148.namprd12.prod.outlook.com
 ([fe80::d4f2:79a1:acd6:8a6b]) by BN6PR1201MB0148.namprd12.prod.outlook.com
 ([fe80::d4f2:79a1:acd6:8a6b%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 21:01:23 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/display: fix logic regression in dce110
 apply_single_controller_ctx_to_hw
Thread-Topic: [PATCH] drm/amdgpu/display: fix logic regression in dce110
 apply_single_controller_ctx_to_hw
Thread-Index: AQHXmdOhk9Bnb1OrfEG4FH42Xr3X5quEtMTA
Date: Wed, 25 Aug 2021 21:01:23 +0000
Message-ID: <BN6PR1201MB0148F72ADC17E5972F22F65BE5C69@BN6PR1201MB0148.namprd12.prod.outlook.com>
References: <20210825170648.2567071-1-alexander.deucher@amd.com>
In-Reply-To: <20210825170648.2567071-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=de077b33-59a2-457c-91a9-c8245e307ad1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-25T21:00:18Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5f3746b-9df3-4f83-ed47-08d9680b7f09
x-ms-traffictypediagnostic: BN6PR1201MB0210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB0210C20F5E1D54CB95C1B830E5C69@BN6PR1201MB0210.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +C/h7DwzvIEUXbqYHYRtK7tBYhp25KEmZsdez4UzBAA8wByYiR1SdgpgQ/s6BG0HZz8VJc7Zmuyi8xlAjqTleUIjHVNSgPxkE7u8KzW7Uufr872g3Ivnay5VJIlZ1cLnTX0wBEFxzi9Y1/WFlxLd844SS6GWl6ycbENRWmlZeQCnSejfAghE1fPr4xIg5LwDjS+46SoPc+3MisBwAheV47Q+iBdgC+bG//pUQ2m30KjJ+Xr7zIabzvwqEDsCPnH15K+qije2/VpFmkqeWxTknXlYfvV2Y8TgFSF4sFDtApbYkPRyu8n8uTdrAbuZjjJZC2NJofvsMVwp3UNJbKodODwue/EB05EPTRcShxqst+SiRHMCZSGp0eKOw/cVddNHvEqShinIgGbvjccS+BvuZzp29EmhtJp+E6aAhPHCXJwEYpcgzP5kiB5klP8p5UE0DL1zkPLSE7v0zazmvHxvnu71mzN2Kmv5XqSBzZqokQpyhZu7EVpCWUxaf1RoMzdZXq+Sxq77qKfJaqgzD+Qw9ggYdo8GKcVZEtafz4mSVe/GXWBajJK/dbOs6738zn7ybSLP/+PfuSfnF4K1b+1jD49XimDNN1JIUDXStknSo63TUTqVNDCak4xhY3MotwoQAQ7QUK4Xxtoq2Jy2vAOihzJn7emMyZNTkuqLoOURpWsS3OrlSFAhLZFsXXjOUcSe2Vs/GBDRSmHwdqmu2fgt+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0148.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(76116006)(52536014)(66476007)(66556008)(86362001)(66946007)(66446008)(64756008)(110136005)(478600001)(316002)(8936002)(8676002)(122000001)(38100700002)(71200400001)(186003)(38070700005)(5660300002)(83380400001)(2906002)(26005)(6506007)(33656002)(53546011)(7696005)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4E36e5D2VXTMbdSoiGpbj0YLk1HxlDixUAn9+wYH+v05ZAOHiM1Qw07GenY?=
 =?us-ascii?Q?V633Mvb9pZvBo3tZXPkevpcZfHoS3ytYovlpvFCwjoWUWBb3vogV2zWw8F3b?=
 =?us-ascii?Q?yLzFiBM1dfJEN1G+CrXm5IwqiAe5WBDWQx4or71PBmpMoDicqc2ciSWQfAdR?=
 =?us-ascii?Q?afZhG2j7yaJJi2ZcxBqqCbG0GirXC435fr/GdgHjoihRwpW64ecQ/6KFnDYB?=
 =?us-ascii?Q?mHI4DO6MUd6GabfEnVdyq5Jt84KLZ72KijTzJpCmiL1iAtKZK88XHCeqeFvU?=
 =?us-ascii?Q?4IiU18iChk143laUxu+v0wV6bv+c8xmXT0ceChNhCs4y+tKpui5URmQE7Gkf?=
 =?us-ascii?Q?YVpoEQUs7nC1ZCdTrSWh0TY8REHNOKga+LPTjY90Mo4zrx+nl8iI3n7//CfK?=
 =?us-ascii?Q?Sb6vHQ/qP3oVPlSbq0tvAQ9IXSxQjyfVlvbLpBbPADDdIYeoq4xXJRMUs3rY?=
 =?us-ascii?Q?eEcTFMU58RbBqTN+DsA185ZKy9b4MAs5nKXBHfuNV8rH5rfNBjnXGS/Sqkzx?=
 =?us-ascii?Q?94878qlLNvu5pK4t5n+38mJcsHWjdYyHppH3v2XDygO1ehBHDpandLXyS9df?=
 =?us-ascii?Q?zuLzDA8y+touO44+HTnRrs4wiEU07yvIAEqNhCESQlkDzZdDabOZgak+Gaoz?=
 =?us-ascii?Q?FDsKXgNFB6JfzGAqHRKnwtqlioPr/OpZteLoLE74J2o4Op1YdgUzDWSfdz0m?=
 =?us-ascii?Q?UzzO07qXyJg9Iljdj3igOwwH2BiRHN8E+eMyo1hZTIa6Z+ZrThY6/FMj7UVd?=
 =?us-ascii?Q?w8B6jXsv7H0bFll50cuw1XC3xFt+O8IrE8JDP0qD90P6R+5shl2cPR2ZIK87?=
 =?us-ascii?Q?UR1d1FoS3aLTUCixqwK7NPE4nPLJfLg2QhXpMZpkqryYhpSgJfhl5AnsngB0?=
 =?us-ascii?Q?xTXSm9MKzOan4Ap5zMphT8ORlmUjMcOZP5lvZDdwrsQHoPmBpnOaeuxCAZQ0?=
 =?us-ascii?Q?fEB3N6RcMrFeGfYM1n+8scJr00PtLc0wWuAPNfTo8fODLgrI+Jt6RXgOG2s5?=
 =?us-ascii?Q?qJL7hfZfW0tAk/nI015M6IdGqCHUZmNTSm1RTLgnkruc7Utywz83wnTrFTxh?=
 =?us-ascii?Q?UnkKq0Rqk7lHmM1lbXQ2p4qf46aJSMdmJIrneNXMPdt5je5ZNEg9DkLmyFwM?=
 =?us-ascii?Q?hFYCqSoLaQcq5ywcEpyiw6ExkGlGFXUfeO/8s+tE//bP4wldRWHcODhnQbP9?=
 =?us-ascii?Q?ZkQXeRFHYD8ZTrphtBpc3z+gqmIK0fEzSguDKZausnNtF9NVkdoNYe9NLEqi?=
 =?us-ascii?Q?jBbQWnd4WFQKmn+Gc6NMNQ2wYF3x1IfDjONPkLhlrL2NK1aXAO41jVNB0FCd?=
 =?us-ascii?Q?wLGtnTn0dCizqv9mUqkOlzxv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0148.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f3746b-9df3-4f83-ed47-08d9680b7f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 21:01:23.3462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfhthXxN8Az6+CrA3z90bG6xQN6bqV0Dd9gQiuuotNY7UuomieNg0fv61cdV0Rva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0210
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks for pointing out the mistake.

Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: August 25, 2021 1:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zuo, Jerry <Jerry.Zuo@a=
md.com>
Subject: [PATCH] drm/amdgpu/display: fix logic regression in dce110 apply_s=
ingle_controller_ctx_to_hw

Commit 5de27e1d6755 ("drm/amd/display: Add DP 2.0 SST DC Support") added a =
new check for DP 2.0 with a CONFIG_DRM_AMD_DC_DCN check that removed a bunc=
h of logic if CONFIG_DRM_AMD_DC_DCN was not set, restore that logic.

Fixes: 5de27e1d6755 ("drm/amd/display: Add DP 2.0 SST DC Support")
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 33743dc2631c..f660472e71fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1545,6 +1545,7 @@ static enum dc_status apply_single_controller_ctx_to_=
hw(
         * function core_link_enable_stream
         */
        if (!(hws->wa.dp_hpo_and_otg_sequence && is_dp_128b_132b_signal(pip=
e_ctx)))
+#endif
                /*  */
                /* Do not touch stream timing on seamless boot optimization=
. */
                if (!pipe_ctx->stream->apply_seamless_boot_optimization)
@@ -1558,12 +1559,6 @@ static enum dc_status apply_single_controller_ctx_to=
_hw(
        if (pipe_ctx->stream_res.tg->funcs->set_drr)
                pipe_ctx->stream_res.tg->funcs->set_drr(
                        pipe_ctx->stream_res.tg, &params);
-#else
-       /*  */
-       /* Do not touch stream timing on seamless boot optimization. */
-       if (!pipe_ctx->stream->apply_seamless_boot_optimization)
-               hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
-#endif

        // DRR should set trigger event to monitor surface update event
        if (stream->adjust.v_total_min !=3D 0 && stream->adjust.v_total_max=
 !=3D 0)
--
2.31.1

