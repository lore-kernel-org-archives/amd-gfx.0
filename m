Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90255C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D7022D75
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D7022D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAB46E3DA;
	Thu,  7 Jan 2021 02:48:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6854C6E3DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 02:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUoOpC4PiX0CYeVvsCeK6XkbZ1+BWFl0G5Q2XfqvXkp+C/X8Kuk4ljmDgbHUMktvovlqaAEiYIhdbOm9blPTFrOSmNBsNcsdfDzR8RwNT1nMOxXH6DqiFrt5B9qm5hA80FoWMmc/+yxo5moOQYi6K0Weocdzbe5sOn3BTuyFRMYUI2YAPWrNWK+nQe9LFaB4fXa4Io0M77FwYMktxAMIr5FokrWbL36xl7KBhrk6awlgobHm2ccuS1VRbqgO2rBQjYUKydnxEsAMK313dL51YsnfHTssxIL9qUzLfPqFTegpGSyHtG/COH5E7YBtxSzGirOabx5Dd+nOl+u0sEGnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dkaI9VrY70S7v3ENZi2OqTl8oFuhRgWbit8b2jSqKE=;
 b=T3wOi8AUujq7TtunyouCYufXr98iEcZu0Cd52O2FuqmywgyGjxKt25ZHIw+pq+8WmJSMd7E24DP+QWNlcip0vcExmKnAAldlpFpmh/84tLVnaiYhcvmuNSPa7/PK+Lz7UOrAoZEGuMIKE99y6v/oyLKdzbRQtVIhLBDeWgY6Q2kGeq2DlIpbt6MQLAq9jC+Ph62ZSIcyihnHVQfZJrdRcDQTehIA1A7Cjei9uPj+WgkjAq4Hm48LkE7utGN4lfK+AMM9tqDpM/pfhqg2+srB6mjmMSO8QPzbyvoaGr4nx02UH/ioRcruOIiNxYdjpcZZ0BvDjz5xBrje/Nym4ItcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dkaI9VrY70S7v3ENZi2OqTl8oFuhRgWbit8b2jSqKE=;
 b=H90wvZdp0iYpB7GKv475D2exlGIeYgOPVpoOaxpeUzXkKVQkIgid6f6Xv3LiCSQHK0rDX9BWJzJa4SziHwc+n2ddpiftITiW+9cNYZQBbxozndVO0xf3BZOoSHeq02PKEPnakxcCBsa5F9PfjdMw7AJoBDCA3OoEY7UuiID0il0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Thu, 7 Jan 2021 02:48:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 02:48:05 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Topic: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Index: AQHW48gJDtuMBnva90WSkOHToB2vd6obd1sA
Date: Thu, 7 Jan 2021 02:48:05 +0000
Message-ID: <DM6PR12MB26193DB3C6458645C22AEE63E4AF0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210106010515.486545-1-Emily.Deng@amd.com>
 <20210106010515.486545-2-Emily.Deng@amd.com>
In-Reply-To: <20210106010515.486545-2-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc1b4511-36c8-45a7-be83-de84e97514cd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T02:47:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0652e8c1-d6c3-45cb-1102-08d8b2b6a88b
x-ms-traffictypediagnostic: DM5PR12MB1259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB125930222BE0D48D83A05B39E4AF0@DM5PR12MB1259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M81h/dMSKDpnSZDutZp4TOMzJu1VgosRovquhABa42xbFti2XMYHkYzj9O3M5+bh4IBU8owrClfadb4ywWblaf8/JdqGVXuYC9BDdPUSlldJZtmN75or5JWNc0B//NigTAtoVMJH3YObsAuee19WW3b9QlZpxg6DX9zTn/FpiOjKoitULpJgtP4RPDJ2lf6kgmDUJdsvQ8CEgHdYcCdi4nKkoW2AayTAu1+lXorWJBOUyKJ2XxRVnTXAcDpxMMAPn7XvNo8zT6MBvNT3IuBRobJuogOzIOXv9aHWzpmFzb1BucOLdZDDNaXAzRJeW0XsUFQkZvfz+xOk0DRGoG+HBI7Mm0IBCjJEaxtMelKw8HKjMf9SdizxyEtk+f8NWsv8N7dT1o8noBmApBLPIt/bjKQmp0t11D/6/9BfqQlJNHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(33656002)(316002)(71200400001)(83380400001)(5660300002)(7696005)(9686003)(8676002)(2906002)(8936002)(478600001)(64756008)(45080400002)(966005)(110136005)(66946007)(86362001)(52536014)(55016002)(4326008)(26005)(66476007)(186003)(53546011)(76116006)(6506007)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m+ewvu/ijV9j3TPePix8WXN4JzRktWgn9WjWH21vQDFY1lM8DPP+rLXqDRU+?=
 =?us-ascii?Q?AoPeaALoHPZfQLwH4DbzjFVVRJB7U5tx5wkOhg2n6ah0FFku85a1RYnKf+VY?=
 =?us-ascii?Q?yy68ln2q/ucmhxXZyivsPZ33hXo2OFMT8gDidfLH5cOOWj6LEnzbnz/3k7Th?=
 =?us-ascii?Q?lPxH6u1UJ3iwSf/Um2+mwlX/kP9IKf+RRrY6Tn8cuBCuCqsdMsey7W5SJDD9?=
 =?us-ascii?Q?MdfuvR52JwrCae9i0UoAIUZL5yCMSQoq8SRWUDGQc02Ad/84ErDQyA+R1mwr?=
 =?us-ascii?Q?+5uFl0lCyyXAkQMYC9CML5KI0JsnLTcQlqheiaLN4FAnl0Z4gsdPPaUERgFE?=
 =?us-ascii?Q?KyH5zrIJK8gc6upszKweXQdOlO+qBtZuOlSZ/suN75syiJwCORHjKyv4cJPe?=
 =?us-ascii?Q?ayDH/7nND6AWldUHO6SQDFEFPL/B4IqkxQmxtGQcbeYUexT6JjAy9n1RK0dE?=
 =?us-ascii?Q?uLxyZ70MHEZFGp3ndqXK/mhDRIQsQH6cwN3VchfyMdYBmE7PijJIKZNVS443?=
 =?us-ascii?Q?Mqq3AcXLEomG/s6RHydeBMfpqFYIcp4AdE4VlDZZVx075xeuV6bmPgN6r9Pa?=
 =?us-ascii?Q?JeJXMUuOWInHzlTna1mwgUZRcB8FYzUFL5lVU6RkAGGlAY9L+XZ2EQ5FAL7z?=
 =?us-ascii?Q?bs2n8HjlbvhIork8J3E6AEWszVMvxYSNdJAGWLIa60D2LrbsUAbXcbBDDOmy?=
 =?us-ascii?Q?FS4DRi0Y4hVySy3vdUHIXXbWah8yG9tC6C+/1xd3tsJefkjDc7D8jGlOLBgC?=
 =?us-ascii?Q?N9WLy++1LdXR0STNFw/3Rm046YSAfIkz3jVitSBecp9zsBIF+pP4GO2GXlwV?=
 =?us-ascii?Q?3t5VM4tyldNJwkZMxMyEuyCvjlSC8/LD4KZt2904gj6Uoxjr4pEZcv1tz3Q0?=
 =?us-ascii?Q?Tm3b8/9BF17MKrK336hH5j3NFPUU3qnxpsHqzk2tVDcw6CEZApuR8NF+YKh/?=
 =?us-ascii?Q?WU2DVxLL8y+Ex2VObo6jlxruhAU64O1rROyxjJCmjxE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0652e8c1-d6c3-45cb-1102-08d8b2b6a88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 02:48:05.3463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JTkQqH/RhxIXcs8lWXrj8gmItw6WvugAhIXlSaGymmSK2poTNW2SY1FpMAUdaEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Wednesday, January 6, 2021 9:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10

According to hw, after navi10,it runs in dfll mode, and should
read sclk from AverageGfxclkFrequency.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 51e83123f72a..7ebf9588983f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context *smu,
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_SCLK:
-ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf8dd063d81db4666206308d8b1df2912%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637454919343172670%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gA1B8ytfQj0g5TMPHYYC%2FKNUli2qY7iY%2Fc1vn4M7vWA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
