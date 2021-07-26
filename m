Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD8C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 19:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B4060F5D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 19:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89B4060F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A71A6FF41;
	Mon, 26 Jul 2021 19:05:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5346FF41
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 19:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em43hpSscYVorVo2p+Jl+w5oqHenzRmbybx2U4YoGk16PGUs48OgxBAmBInAOgysv+f8y7oVBuj+vRp6SGAMnsNaQx9NRgU9XbiuOXbidq+2ODyLOWTgQ2aqrBsSJdMEjgOJX3ZiZuJYWNw0IR+/jBh5FAOzfi3cxPh0GxxsMGbUw6Xbys9vZVGyK0Uai8oA9h4W/PYmk4dcOnEYnJOxjlc1dXa5gSG1Bxxjty13kuv6Z0IfXsnPRxDy5M9ow5Bf9o0cg++CtOV80glpkMCj5LZnCdOE2xAd2w48mOkudNwlN19HnDlIT+8+eD3BF7JhW8ahwFo5xIObVocD8yg2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a8Ovj5Qpo343AoMj/cSkZk6HNXg7pvtAXF0vsQ5FPw=;
 b=DjOU/3N41OcaSvsJPd3voy0pDFcZh0N5O2H5sPnZfmBrRgGif9FjD3JBG2IGfzvNo8T6+3y5Rgr2e/mNuAnZOQyViDRKMlFf6X2pHbirtYQkCChKDJy8FvUFEsTfxQedON8tN6DMjTF9o0fME12B6gL3F9FTXpbLH5ONJRURffytEcUKWCUhjd3RqWuZx4FiNqFEup3Oh6zodAtBz2JeD1ZwgmNvDvWlzwtBHWYzLjwaaWMPJAMmoqzQ1j/2MYf/xqeLzWa+xvuXHEIZ3DLo37ZS1DvobYgHuWuHh/N3V5bE4BUialWb8Wxvvts/TZdoBwPNSsJQmoIWgCkwoEffMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a8Ovj5Qpo343AoMj/cSkZk6HNXg7pvtAXF0vsQ5FPw=;
 b=VYk4swvnMT4SBjZm1sUXUDz1yvUQBdtGvQkKqjrVxg/rqpLdFyBNUKXdB5tvHbZNbP9pyOsv8tL42HRpie8YWhoqntLExB+mEdiQ3GVNqg/00ax8RrgD42pbLtL/+TtvQ8o3YdiVwUYZEa6xzRB7nGeH9j39nCY/0Lpi0Jdox6Y=
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Mon, 26 Jul 2021 19:05:31 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::ec:57a7:8def:e21b]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::ec:57a7:8def:e21b%9]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 19:05:31 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/display: only enable aux backlight control for
 OLED panels
Thread-Topic: [PATCH] drm/amdgpu/display: only enable aux backlight control
 for OLED panels
Thread-Index: AQHXfn5YJGn+qDV++0SJUgXeUELBkatVo+ZQ
Date: Mon, 26 Jul 2021 19:05:31 +0000
Message-ID: <DM8PR12MB5413ED907C2F754FDF89133889E89@DM8PR12MB5413.namprd12.prod.outlook.com>
References: <20210721221809.216742-1-alexander.deucher@amd.com>
In-Reply-To: <20210721221809.216742-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=76cffe7c-e7d3-4dc6-a7fa-12a00e1e36c7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-26T19:00:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ed5481-3db8-4b03-2146-08d9506856eb
x-ms-traffictypediagnostic: DM6PR12MB5519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB551952D330A65F961F412A0B89E89@DM6PR12MB5519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpNSZm+WNmuPxDjbYuo+ljV/h58KzvmLgkEKyM6Ab7cblBzBQVH3N+MLRpUlL+H+4N8xdvwPvayzgwvhlZrVgiIrUbBj2d9n7FQda6fXPI4t90CMVtZEHk8XzbKPVLqt1n1r2TbKfobw/ON0H8vVbZ8Vmt4kBtjvjMbjU1FwWakN1udDpIXUIAv8GFo6pa/IG9ncimE7IpB4sWQ+PTtImsYesbxEkHEgfaQlSsMjSZbs+lwy6mIk/GSyqRve3QeADeOk8GRTyTfgQDNKkTwBQjmU5DfD7xiqMCzPUV2QUfnhu6e3Ucbvq58XC24tEpKZnGPbnwAG+2MxxnOf9FvaYQC8gGxZE9wokGLfpOaZGTmJgh54DaKkk3Wv2noQOxFRk6PXLoi6kOpN0C7MzeFQKi4Q8MQjXKxkgBg5mkTpUZN+l22WsPjrffvkgJT1dzG2ihXv58hp6ywQRi528ju12P4TZBZ1CRuxNHWbDy/zKHV9If983mkr8b7ec7PIpdh3HOdx3mUaxBpDwPXKeFRrmVzcfZGBR97w2BI1PEVT8LP7ehxWvu2gpLTIF4EWoOIZsHNdvTHDE2nuKybbF8524YgI9exdp4Ys/t6DzvrPTmNmlB3C2PvJMAfCrKZs1Ft+Arrx/XBOogbODCLa0VZCTATZ+rQpIFpoU2DBX1QVROaUjAfKogX/o94YRwaurHC8HmEB2gG+63fb7UPh6tinGLbSQqJ8RsuSPiTYlNwGBbjixFguYvQUqcJZQDB3AhvXJUBdNj3zPdqeAzEV3HKV/6vTbXFCSmhtak9hEYi6qco=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(86362001)(8936002)(7696005)(8676002)(186003)(5660300002)(966005)(9686003)(52536014)(4326008)(110136005)(55016002)(478600001)(316002)(26005)(6506007)(53546011)(45080400002)(122000001)(76116006)(66556008)(2906002)(64756008)(38100700002)(66946007)(83380400001)(66476007)(33656002)(66446008)(71200400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2eK4YArmIoDFe8+ndPcHtqVe/XuVd2Gn1C+GO6RIV8mudrQRpHiZ+VT4L6Ez?=
 =?us-ascii?Q?p5PKL6xnvDQCoSWo/515w1qPOBEBMQprxOct4bu+D9xG1/JdVnP9RI2tC/iN?=
 =?us-ascii?Q?X3esudGcXUqD8M3lq4i9x4WF5Kxi9tkrHX1TMsPizvZZ1WdPHLdiBNxpNKYQ?=
 =?us-ascii?Q?5F+BrwYdtE1IHTjnLMDf31m+f4JcI+7wLJNHmATe6kl8+6g0nGO8J1S2MLKq?=
 =?us-ascii?Q?kEbMTxNhKfRqtmSDHAM7UD3t74fW60t9y74uO14UTo2R1riA4QVSYpiCUsdN?=
 =?us-ascii?Q?aDbiHJJR4CNaAWpLKLCKDxtol9Rom0g6Y2bcQunSUM0e2Zmc72BwkJrcWtcm?=
 =?us-ascii?Q?t9qfW9SOMHOyH9JLZKxVKtwiqUIPn6NmzgMu979tQktb/niJHq1oD2eHPh/3?=
 =?us-ascii?Q?3hsTeeiRYrwEHowL0zcD1nFgNTJJRSVh2HLUxO2zwL6iDHPe+n+hAy3+Cz37?=
 =?us-ascii?Q?I0YQi0EiWMom0ywFZOLPTFmo2QEXYluGN2L9lfa802M9A4YAqBtT1vNY6/M4?=
 =?us-ascii?Q?l1pP7auZdezPWI7MOdSojGKCk0KGHjA74DazXQYLmLsGhaHotMkpdtzLmNnk?=
 =?us-ascii?Q?JR/PGMB/A9kz1HwckqoF45e92EEAxnyPAiPm5Lt1TwA1pmyxnXkPl8r6KUGb?=
 =?us-ascii?Q?Pzty5HAP38PLsgjCgZIK9hrGma46pNaYGB3yhZAfVZNI4T/UftexG1WXyqHx?=
 =?us-ascii?Q?LIDMhZ4P/nfn2kVebc0t3AZ+wTcmdS21hJ5mR73IVHTWkKaJ3DeNXgmQ7XPa?=
 =?us-ascii?Q?es6hP4w/rq+/IaPhahRZhhumeqVVqP48czy6Tokbw6M0WeCTvwdcc4PvEhn/?=
 =?us-ascii?Q?a1aiiA30DRiYGnfUZYqpPpHc+tXhFr/y7DgGgaNoXCK0fK+bG6kHyUPWADj9?=
 =?us-ascii?Q?mZ2wEmHBZx3ai9nCi3u1TQKNvHz+lOmPRd84vHs+cZ6Zbv6r0rjE3p9bfLz7?=
 =?us-ascii?Q?0HXb/Yv2mVy+xmWTg6HMbODWInIC9hGkuNtX30LdAgZPPI6FOf1Qp0sWtLmf?=
 =?us-ascii?Q?2kvUxORzdW1xhfo48HoQTR3LbFTTchhMTRP/Y4YtS46UeJKWA59xBNQZPfcn?=
 =?us-ascii?Q?kuD5gqRLuxCm49hwHlQ/9YVFG9i8xaLhPf9KSFFeCkwWGz4RH1cITw8MLsz5?=
 =?us-ascii?Q?qz4FX+Wu5lWjkc2i3CMZRxFy8rCad8H1aaNS/Egx9wsDPLxnczT9UIszfK8Z?=
 =?us-ascii?Q?Fv+y68MJtKOE4LU/GNqQw4DyAEPUCs3/cs43ITzCwvmTFfQD6feu5PiPFRDb?=
 =?us-ascii?Q?d3g7Npk3ImEpDa/SNfxw55rLr+rC+ZuqZh1bwdp1cfhWdiumTzGdK0whCBpI?=
 =?us-ascii?Q?7aIhGXMPOi/uYPh/ewEdfnko?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed5481-3db8-4b03-2146-08d9506856eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 19:05:31.3541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9fUJIbGQ139K/8cCuiKlgONEpwYQSpejJDw2dMHlV8KxPiuKdGKx9lCX27tqGEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, July 21, 2021 6:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: only enable aux backlight control for OLED panels

We've gotten a number of reports about backlight control not working on panels which indicate that they use aux backlight control.  A recent patch:

commit 2d73eabe2984a435737498ab39bb1500a9ffe9a9
Author: Camille Cho <Camille.Cho@amd.com>
Date:   Thu Jul 8 18:28:37 2021 +0800

    drm/amd/display: Only set default brightness for OLED

    [Why]
    We used to unconditionally set backlight path as AUX for panels capable
    of backlight adjustment via DPCD in set default brightness.

    [How]
    This should be limited to OLED panel only since we control backlight via
    PWM path for SDR mode in LCD HDR panel.

    Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
    Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    Signed-off-by: Camille Cho <Camille.Cho@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Changes some other code to only use aux for backlight control on OLED panels.  The commit message seems to indicate that PWM should be used for SDR mode on HDR panels.  Do something similar for backlight control in general.  This may need to be revisited if and when HDR started to get used.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1438&amp;data=04%7C01%7Croman.li%40amd.com%7Caf093dc8782244c1a61008d94c9579a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625027141336218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lSPNjXlohpn%2FZ4kRFp0Y7Ir4qY8pNBSbHiGlccvBSRY%3D&amp;reserved=0
Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D213715&amp;data=04%7C01%7Croman.li%40amd.com%7Caf093dc8782244c1a61008d94c9579a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625027141336218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Km4sba6yF0UFMd8mTCamMJ2SaZrFQSkc7PNDLmptsO4%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12db13d2bce9..986c9d29d686 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2436,9 +2436,9 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
        max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
        min_cll = conn_base->hdr_sink_metadata.hdmi_type1.min_cll;

-       if (caps->ext_caps->bits.oled == 1 ||
+       if (caps->ext_caps->bits.oled == 1 /*||
            caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
-           caps->ext_caps->bits.hdr_aux_backlight_control == 1)
+           caps->ext_caps->bits.hdr_aux_backlight_control == 1*/)
                caps->aux_support = true;

        if (amdgpu_backlight == 0)
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Croman.li%40amd.com%7Caf093dc8782244c1a61008d94c9579a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625027141336218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ttvmpBk9TOJvgr3HBPIW0VFFHvxiAZ4nvNx2pJfpz08%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
