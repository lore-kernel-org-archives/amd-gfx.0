Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E5EC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 18:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8E020719
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 18:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yNOEpK0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8E020719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303286EAD9;
	Thu,  2 Apr 2020 18:52:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6CC6EAD7
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 18:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvS4tOopzG/FiC2LXblyoAw8ibzGMZ5kQrS9rOuTPRo8JBLsvDKXKMv8T1ZWU//7t16n5OzXKGdw3zh+90BM5tRJpn++2PaO6hypIQqzSGuDo+62H2Ro/UkQ/1Ewdy3+dGrwzLg9G/acJ3oFcBgsY9zjP50CrRNQZTHCgM9vQ8Ab/0g6cXJU23Fx2P/ioshOXRQoECV9wmCK4ijSY+fAUDGvOErgTrm9XdCJbDeNuknGGtbhgrKkIQD7hQ5prUeN8uImLsu3lBgSMuimgKP2V8v829WsrRV7/AzMjA15/QPHGkW6ouexDNKsFJ9DjD72u9lDeVieImvjP+48ZY4l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbZIwEyQC45I0mrbIUEDto/7mA0tVLyySKbz6BiwkZo=;
 b=Zhs9HDDSU5Y7ZqhKkSOh2SD3CoyimUFlPTBQ5BxionHKZXEGvg1/If1+nNjnW3OLw7MZMGWs9IakoL9PU5ekS7vZ171An9an5XkfQbgiLEdTnoMgp8wK+IZ2Ys1f333Eviz1d2VWZY80Gve/LuxJal+MVCX1NsznliMk9G1uQUj9anwl18nh+dHguEJiSu+bQIWK7aySQEG4Lr9NdIvGdpRmyFk8QigN8kVxIe8YunmDB3B8gnD4Y1cBzmXAKgQhuDXj51033168GabAWbb2nVIn3tEvAku0GFOTigY4jsm4vkdKyeUD0lxAZ2JWLjsPrFbX3teRrj6LQvY8vJ8lGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbZIwEyQC45I0mrbIUEDto/7mA0tVLyySKbz6BiwkZo=;
 b=yNOEpK0u7eMWaAcfsqp+YDXIrTOrVIKOi5fPUIidMemcuGRRxwaH/gLud7MG/IQzKABs4gmw+arAf98fH5oVLxp/ogu6rid0wbjElUP8HsVkSS6u3u9AiE4Tog4q83pGh9gDMUk2lOAByPv8NW8zbnGIU9nQuCxR2RaJPNyf9iQ=
Received: from DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28)
 by DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 2 Apr
 2020 18:52:14 +0000
Received: from DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::a9c6:293a:cefd:69df]) by DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::a9c6:293a:cefd:69df%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 18:52:14 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, 
 Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: Re: [PATCH] drm/amd/display: re-order asic declarations
Thread-Topic: [PATCH] drm/amd/display: re-order asic declarations
Thread-Index: AQHWCM9xhfngJYBNMkCSRTxrmpXVXKhmLagD
Date: Thu, 2 Apr 2020 18:52:14 +0000
Message-ID: <DM6PR12MB297140D7733C77B4ED6314339EC60@DM6PR12MB2971.namprd12.prod.outlook.com>
References: <20200402091515.121824-1-shirish.s@amd.com>
In-Reply-To: <20200402091515.121824-1-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-02T18:52:14.001Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17a43510-c9d7-4c2d-2dda-08d7d736f5a0
x-ms-traffictypediagnostic: DM6PR12MB3611:|DM6PR12MB3611:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36114EBFE0CC60D2AE8EAB599EC60@DM6PR12MB3611.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2971.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(966005)(81166006)(81156014)(8676002)(4326008)(7696005)(8936002)(53546011)(478600001)(6506007)(26005)(186003)(2906002)(9686003)(33656002)(316002)(55016002)(110136005)(66556008)(64756008)(52536014)(66476007)(71200400001)(6636002)(66446008)(5660300002)(66946007)(86362001)(45080400002)(91956017)(76116006)(169823001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4zKjMS+psXi7jm8KFXdoRs7YwMw3u62GH3O73VzFe6Pau1xx5vv6AIxPA7CogfB8LEPDqQoRYlLfUBWmypaaq7GxHBcz49xHFG3dgeXA/nOj/H+ahbL0L2xKrwjoYEx9W89H8vawQmQ+ZULIAUuACGUjFMEnXl1Oeem7dCH5ZkuoF7jef0zvy+gZDWR32kILuEiDj+q9FvXJ3obmQBI9f3jk0mEP9MZemmtrudmNHjERuq1AhI41coO6+Tbae+Vq27D3tW/32xCylK+StORuB5dx2HpVDvBgpO3EsOvMj+db/bHm//sOsYD+La5aGX5PKu6cQJtfahzho5ikUej0wIrMpuXVX/ZU3vbARjabuhfSJSwfr7luCk6KRt1b2bECEzOfGWnCSOZOSQHP9jf0aiYUM8iwydS8b/cianGgm7357MeFBsqqGF/sDQEfLBp8JjxvoVn2cz3sasZ31AVcxWa3GzdnLHg8yRiG3sX5EqPNit9xAtBxfyuEV58nUDmM5J1rDfMjNS+ruJY5PDhmA==
x-ms-exchange-antispam-messagedata: 7OQab6C5GyzEl81DrSuTHWR37solRI+IRj0Xn5C2Q2eWnZjZ9L4MinpG9DMUnxTInGmQPTqhA04xWEy2tAUYn8MT3IprzYjXnVShSIWMXAlPk74EcRrbOFh+CA56XYjg3P6H3ym7ZiQ5zie86r11ig==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a43510-c9d7-4c2d-2dda-08d7d736f5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 18:52:14.5005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IdoE96GIVoAxgPpPyHvO9SsOttp3Qd48LL2KB9DJVahz0EN1v3LtHeYfY2ORmSM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3611
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Shirish S <shirish.s@amd.com>

Sent: Thursday, April 2, 2020 5:15 AM

To: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>

Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; S, Shirish <Shirish.S@amd.com>

Subject: [PATCH] drm/amd/display: re-order asic declarations




"1382d6409891 drm/amd/display: Fix RV2 Variant Detection"

introduces build error of:

"use of undeclared identifier 'RENOIR_A0'"



To fix the same, this patch re-orders the

ASIC declarations accordingly.



Signed-off-by: Shirish S <shirish.s@amd.com>


        Reviewed-by: Zhan Liu <zhan.liu@amd.com>




---

 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 6 ++++--

 1 file changed, 4 insertions(+), 2 deletions(-)



diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h

index 8a87d0ed90ae..2359e88d6029 100644

--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h

+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h

@@ -136,6 +136,7 @@

 #define RAVEN2_A0 0x81

 #define RAVEN1_F0 0xF0

 #define RAVEN_UNKNOWN 0xFF

+#define RENOIR_A0 0x91

 #ifndef ASICREV_IS_RAVEN

 #define ASICREV_IS_RAVEN(eChipRev) ((eChipRev >= RAVEN_A0) && eChipRev < RAVEN_UNKNOWN)

 #endif

@@ -171,8 +172,6 @@ enum {

 #define ASICREV_IS_NAVI10_P(eChipRev)        (eChipRev < NV_NAVI12_P_A0)

 #define ASICREV_IS_NAVI12_P(eChipRev)        ((eChipRev >= NV_NAVI12_P_A0) && (eChipRev < NV_NAVI14_M_A0))

 #define ASICREV_IS_NAVI14_M(eChipRev)        ((eChipRev >= NV_NAVI14_M_A0) && (eChipRev < NV_UNKNOWN))

-#define RENOIR_A0 0x91

-#define DEVICE_ID_RENOIR_1636 0x1636   // Renoir

 #define ASICREV_IS_RENOIR(eChipRev) ((eChipRev >= RENOIR_A0) && (eChipRev < RAVEN1_F0))



 /*

@@ -183,6 +182,9 @@ enum {

 #define DEVICE_ID_TEMASH_9839 0x9839

 #define DEVICE_ID_TEMASH_983D 0x983D



+/* RENOIR */

+#define DEVICE_ID_RENOIR_1636 0x1636

+

 /* Asic Family IDs for different asic family. */

 #define FAMILY_CI 120 /* Sea Islands: Hawaii (P), Bonaire (M) */

 #define FAMILY_KV 125 /* Fusion => Kaveri: Spectre, Spooky; Kabini: Kalindi */

--

2.17.1



_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org

https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Czhan.liu%40amd.com%7C5d6f323ad05349e58ef808d7d6e66ade%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637214158105886093&amp;sdata=tjvt8iuzXrd1rg0y%2FIzVNfSGpAFEJL59R04fcqi3UzE%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
