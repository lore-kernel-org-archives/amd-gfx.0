Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB56C63777
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 02:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F18C207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 02:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IBJHpfal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F18C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A1189CE2;
	Tue,  1 Dec 2020 02:01:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0427289CE2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 02:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnfJi28kJVIPo9Vs5w9MWqjnbpmZDU6ewR3JmRUxk+AQ+WOBSLvBZI+oZ5AOofzeX2gbKhoDGAYGlH1d9LeOAph5BRPfcOdUhLQ31ND0XzpG87GtrDwQ2p1+QseOS2TiuhzrZXS2iltpu7JBGW3FGbjV7jbanMX+Roc2rbo3vw8UiqDZavbVVt+FxBxsMvDEIp8NdYpClKkvhjYyWPLtyw4Lm7HaWEhG6squ7/7jfe5GEVFdKO+i/z2Y1saNzhPHk9+uj8yXuUSZwtu+L14J6zH91tl5LdyRfe6IQoafgk7DeEA/Fi6RZd1ltOsoyLQhZfUCK/JMsfKKhCF98qwV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUSBdMHbiKoMEGI+o7fpj/yqDlBPTkA8JN/3OauXG9c=;
 b=az6ThTLlF6xXJQYAlvJ0IryV9gFTzvk8U3Wp3V3TIl8j23BcrOTV5W2r3Fzuq9clAiahfLUZ7DpeJridUUBBrOLb1p1HnrKt3NPcQWIQoKHOAQ9omaC29UdyFuigIiV7X/tHIk1sAlZ2PQ+3zeXZzOymq8knGsWZYBUoTth3KGUztox3n1yl08ymRCOmFKqEpThiS8aWaRD2rGW5lv0ytw6QQdvJ7snkvhN4tskkShnVfhWol4XSg0563kxArb0O3fcjKhgH1PbWuWwXLsZW1c3Ih5XHzotxjuWce5+kK7TQXhE+ouzCkQOMmng3Kr0KySuX3dd9A7iHgEjTL0J6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUSBdMHbiKoMEGI+o7fpj/yqDlBPTkA8JN/3OauXG9c=;
 b=IBJHpfal7tA2D4xt7HuFNKYTzYFvIthRLsZtj+e6TCDBX5T2e1TbHKPsFl1btTSNynfYa98F2zAq/dwayMZYFoVu66/RZ6SSOw9nVihLx1ulKNJ+r2IbHAhX300KMbNvEJEaWUe0qWOp7jJ9GmwiFuwKObvihw/Vj6qgG22nOW0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Tue, 1 Dec 2020 02:00:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 02:00:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu/vangogh: return error if fetching
 metrics fails
Thread-Topic: [PATCH] drm/amdgpu/swsmu/vangogh: return error if fetching
 metrics fails
Thread-Index: AQHWx2wI4tOOMr+fcU+dOfMDXRIVK6nhfLyg
Date: Tue, 1 Dec 2020 02:00:57 +0000
Message-ID: <DM6PR12MB26198B9E3B9BFFE094D2425FE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130225612.155092-1-alexander.deucher@amd.com>
In-Reply-To: <20201130225612.155092-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d1adc56b-8f65-478c-aec7-a5e6dd3541da;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T02:00:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9753d327-92ec-473a-a5e2-08d8959cf199
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34664FA4E8261736AD50D20CE4F40@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eq0k7SEMMc6pefCABM+TCt5C5jQpgujMeSWei3EAd/h9G9MtfCQpq5LZTRIN5UsRiTpKgRlOLSXefUbF5YWeWgypWd2RaIh3+0edOOcGWWTHFeCf1DlqXGGmRP4L3Tu82Rdx0Qz6zMlU8ejv9X0oUiHKyYpAuRkRbrCF21IXo7J4XczhL8d9bkEa8PNVOWgvNSrNzfRzTYl/3WdbLrqzLRyrzhkHsChXSHjwKeA7b7LXwgQSPaxt0A3hPUp8ebH8zRdut2VFZev/7EpNbyQ3FHMgyoXAV2V4glHZFdkDrNmRcZorrfolJOnsLXJh3lQaqcmCwxgODaKgpHnwcNJcQePlRi1qVbmGXqt3PCPPUDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(316002)(478600001)(110136005)(45080400002)(4326008)(55016002)(9686003)(71200400001)(83380400001)(33656002)(6506007)(66446008)(8936002)(186003)(66476007)(7696005)(26005)(64756008)(66946007)(66556008)(76116006)(86362001)(2906002)(8676002)(5660300002)(52536014)(966005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wcq7fBGhJ+k80D3SBSgNBVizan81O0h4IpwNOocb8oTbC83ozJwddUMpgVzf?=
 =?us-ascii?Q?fG9oOrc93IKrby5UgcY6q0/WJLrSTZ/vLI3E8KSJaV1HcwPiXE7NI2uQ6/tq?=
 =?us-ascii?Q?yXYj/ZpeUAo4ppXnEGp6/hkPD8dKmj2/gBB6Y0xU61HHLIhV6OBgVXCNF1tz?=
 =?us-ascii?Q?fqJD6HghXn0PUQU5367a35wkFFBXnYo6upuGkznB8VRWE7Y3Ooy9aph2mpjW?=
 =?us-ascii?Q?SHyDp529ZSO3F8oS0nOZy1prUhhjVHMKTr9ditrEWB01USTUMzKDlu53uE99?=
 =?us-ascii?Q?0tnhgVpSiGUPnxUBzSygjaTq4+0f60dAYR3skjF6kEjFMdaIGTUxAQe18ut0?=
 =?us-ascii?Q?rXvC6V5G8/J8N9caD/RLTIOTA+qLHgbg6zdz/A7bywFochHAVDxTekK7iQCu?=
 =?us-ascii?Q?ao66FgJMOjaNcm+iX6s91XN97nUd2d1T0Kg6qfsoOl3XzKBdywJ1SfnLOqsT?=
 =?us-ascii?Q?esX1Kj8Lb5TMFqj1gYr4T6oqbBbDznFW3bZ41OX7ZkCHRQvheWJjILKr+rxj?=
 =?us-ascii?Q?LR+bJdt2Gma4W/KLCP+ui7+ttOTARPMwAnj5Efn/OCD4nTBM1Sp2bKMcbjUW?=
 =?us-ascii?Q?ngjdGOwleXX+OvCDf4ylkUfMFxlSuVL959sk8x14BcAKEgqP8usfbyEs5pXc?=
 =?us-ascii?Q?gxO7h1vqkQFkTjz2HTWHk3N4oTE65DkmLtQfbvBKu8/d/XpL9Qx/MaVWtM65?=
 =?us-ascii?Q?1+pNxbqJoArJSbTovAygBF9u+1qVNR6alAX/54StwPhAzaqBj2LrzFxbZr7K?=
 =?us-ascii?Q?KaUFUMbMf2kAx+HqAxvLjIsy4QYpelhcI+u8Hbx+SOsmCniu3KkjnygIYe4l?=
 =?us-ascii?Q?4f5+hL8toG7ONixko+NUpaO/Oh9N2Tp3apRdoHHM4WG6alRD416rduF2IAPM?=
 =?us-ascii?Q?WrDkveNSWYdw/m3rVYtYWHaOXm/DlGCPxTwkckiYBjNiqLeu71x6+x5bXROT?=
 =?us-ascii?Q?U0flWbeRipjsYY+o4lluew2Dcwbi/mjH9oMpFBu5l/c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9753d327-92ec-473a-a5e2-08d8959cf199
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 02:00:57.2587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiKLjx6pRV9iUSpaiX0fEHa/wX8+6jAl4M7zAL7B8bjohdk1NPysY1iSBUa2orHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 1, 2020 6:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu/vangogh: return error if fetching metrics fails

rather than just dropping the error.  Also fixes a set but not used variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3d4d27a304e9..56704181c5a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -410,6 +410,8 @@ static int vangogh_get_current_activity_percent(struct smu_context *smu,
 ret = vangogh_get_smu_metrics_data(smu,
   METRICS_AVERAGE_GFXACTIVITY,
   value);
+if (ret)
+return ret;
 break;
 default:
 dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C5733b7ad8c564980d55008d8958329c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423737869233728%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PmSi3GKae6vnbF7giI0W9gAKZRywhQO3PcAk7Qhjll0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
