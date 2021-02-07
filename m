Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7EFC433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 03:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0FD64DDC
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 03:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0FD64DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894886E32F;
	Sun,  7 Feb 2021 03:49:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725E26E32F
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 03:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs3cQ0wMkbs05WPHUdMtnIS7nvp+Tb6xmj4jTxenDGV3P75L1Bn43sFZnQq+s08KCW6LLGLflquWOgkGsgQzWpRjZflMwgZHKb5jagH1HSwAVy5LUIyaYn42/Xu8GstCBc7UsPq4LXNaMucHK07+1ntnaEKNDX8zsnzXQOCuJPOoAh1qr8MD5JAKBvHpxPLLiqL4KqNl+8WdqoefPJbV/wqceuSnUad5sQ6w+IAfoxp1j5wEhMbiozBIBjMIUUB+935Mohon6C4haRrsZJjfl9CyjJuFczmLsrlSUMPBS5GiZ99ixGMDOKjb5xcP4BcFgPUP3Iwp1T3BvqbtzDqm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNjsHwob9prA0kBGELMfrPGMnEO3oErVWlZNBxA3KgY=;
 b=kyZO+QmSxj1XDQVoEYKFX68IoJzbr3oT/gqu5v6q8GOQ9Udcwtd7KDsgH6EOpSQYb6/YRDwKPgwk2GM5WvwunAVUhexQ64U7YPd+Wd8kQ9evMlUy5XuKIhldGHGrrggvKzTmAlHlK0WHjE6tezyQ/AesfM6DG3m2Tjhz4mXZ5oSuadyEi9Z/hkCtzHAUcRp2Q5lOwr9TRxIyuT53Myx4z5x92VVBDhuI6vedGEfXLFQd9QAGzcWLDO6hJ/TkUr1nx5FdypIQIlgXdQssp11rqgsG1GONglgJM4gAQ5CRPumbaugE5e69BaCx8Bfa36JzJ9fif3hb+I8S8EJ3KhQBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNjsHwob9prA0kBGELMfrPGMnEO3oErVWlZNBxA3KgY=;
 b=BYMZz1M2FVa9sDLtKTpYts/RMXXQlDg5kfA0TecMpEOUnj2HNoEgiK6a3WK2RdpHR2jeoUKwqZCpdrC1uzGyWNlmissG/c/WHjZ3gN/xyGNGCAsVto5CL/zv+TktpSlX8YDYXPI58sj9kiZdlQGtilGJv4QB/hbABoBKU0PHhX4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.9; Sun, 7 Feb 2021 03:49:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 03:49:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: enable LCLK DS
Thread-Topic: [PATCH v2] drm/amd/pm: enable LCLK DS
Thread-Index: AQHW/P+XZxN10T5ruUeA04fLZibOHqpMDkrQ
Date: Sun, 7 Feb 2021 03:49:03 +0000
Message-ID: <DM6PR12MB26197CA96517922C7640E14CE4B09@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210207031556.19436-1-kenneth.feng@amd.com>
In-Reply-To: <20210207031556.19436-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e57ad8e3-aea5-47dd-8eff-29ac1a704126;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-07T03:48:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fb4ebc0-1680-45eb-2cb2-08d8cb1b4f89
x-ms-traffictypediagnostic: DM5PR1201MB0217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02172ACB290A0CBC69EE1434E4B09@DM5PR1201MB0217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/IjrgHAA30mKw8osKO2Cc3DBwHo3OizhNKaSm+xnMvmn9Y4VIx5kzWVwF87Vym7ywK43BfSkuSWSrhRG1Qxd3Hr4BVLoGzzWMBOOVbSpFdsP6kXonGVgByadaBwrMus0OFYUyu0gFqKqoXSiSaq3l56CBDBOcnVD3ENmnU2GC2li9EQf0+aKZ3khJo95Tjl6lCb+1/dbdfpwUW0opxD9bruG4zFydj/wh0r8Ot94admk8sySrp+QLF13nNlu+4kwJFvZ770CePYhvMN1KSJpTej8iERBBEPVNvZwyESerM77SH6xn6XSpYofEH+y/S0inrQ9arzwZJcxuWJs0k5UglFN6UdVrnQDvj/7nQvo2Ho/x73i8oC/KeLEL7uLSJDzc50gKKCFpLwAiA+pCjp27lyW4DxGRaijL8GKcPawPmRHSLdzUeicaKGf/qAztphj3Yn6DQ7d/Cm51qSbJfenSeDF8dnRKhJjSGfpa/rX4ylMowdddOPSQFWYeiR68SCErBQkGHUOGwI5+4hCiHFl1+tadkH9/BXdQKeVgskyNquqJ6tyCUU06q+yARNow3N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(966005)(9686003)(8936002)(8676002)(316002)(33656002)(7696005)(55016002)(4326008)(2906002)(478600001)(71200400001)(52536014)(86362001)(76116006)(64756008)(66446008)(66476007)(66946007)(83380400001)(66556008)(26005)(6506007)(53546011)(5660300002)(110136005)(45080400002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UBXpIuaDCookITcsaGMRwD/C+2MtClBt0/hS4VVp1xKSKomPD2hNO7RXPxIa?=
 =?us-ascii?Q?/U8MDAQGorkuxtkZToXh6GEGqIP0m2NoaVPOgUAwG2Z53yMFPeIAoqtNDM8s?=
 =?us-ascii?Q?DB+0lJQAIm7e4kJYc1CweJd8Xdmdsb4GPkY8+ft/0wDVSevmOiwM5NSIIEUa?=
 =?us-ascii?Q?KGzdzYqSW60J5JPuBm8qXZltox4G1KzSs81BCzJPCOw62vAX8qoVY9SflsOl?=
 =?us-ascii?Q?fnN+SLGZtKEFyQL9gV6XFJH+dynT1k6PV8uVp4guFiAPgJLWbh6kCTYwhT34?=
 =?us-ascii?Q?cxqM0rz3HC0PkjrRChMXvJFTl9JQevxvenOpsXBuTZtpeqnkB5E2SB/k0F9y?=
 =?us-ascii?Q?2vZiWSnCkGmJocfyXRicE6XIeFYHiaaLzEABNClrf/7Xk8YI7BfhsqJfVsS/?=
 =?us-ascii?Q?iMSG7MuZ1dMbICAQjXU547vwblI32L7Ezj1mJlNXsW8aY7hJcWVo2l6bZAaj?=
 =?us-ascii?Q?DJQBke+XRCT68ajuRJkfiBM0keOEKQ+p4vsa08dSyxkuv36jBTkWREkZtP87?=
 =?us-ascii?Q?GFfYU2Du5BuxgpJmbJSWcRxgHq92YMc7a6nPdtHX/1BRFHURaWRUxAfLtOvB?=
 =?us-ascii?Q?HCp5SKqokmQc9IUb9sychrx69L32laNHc38odmL5f3vtM8W+2kCzHiyqoKT1?=
 =?us-ascii?Q?Daw1935w34ht34dcO/Psq9z07GLnCB/qdDCbxU5p7q7xSTW7fAAgzEbadmc3?=
 =?us-ascii?Q?mww+/tYNT27IKbPYRLZ+/y1MmbwjqzaohjescwuHj+PVlthB/3cNMl+zqE5c?=
 =?us-ascii?Q?B0RU1uBmPSGhFfCqbIC5InDIP58cM2fqQmxEe5EDIcrDcUYRdDvLhoihzzl0?=
 =?us-ascii?Q?9p37LDk7+sspQPQXMBOuvvaZ0sMjuetIkHRSmiIyFEJlJIMD6FhNoZrSIYnt?=
 =?us-ascii?Q?VsdkRpgqWsmD66Gn40o784505udweL2PBq47zg0F+OxRe4OXqTpPNrJ0gkRh?=
 =?us-ascii?Q?IKBV5iKM67YFwoa3MAC3KyPKKmXxUDuK3LS9K3a7rxrvoRmgTOxJ18CgFC52?=
 =?us-ascii?Q?hr9pJdS9AbSRht4Qe3S7+seR4lTFd4KmJTiM2bk7hJJj3M1aWmx0q9NlByJf?=
 =?us-ascii?Q?MQlDIjDWAYb5CY9iXoiTTX+WhOFCXZ9Ur7rtjp6kRy/7SX6L0/MBXNr5qx7e?=
 =?us-ascii?Q?Eph5ejy2+YZYJMbNA+hOKa5MZgxwgi2WH6zJJBy82Vgp/JjjcukxCyfR47d+?=
 =?us-ascii?Q?ZUJ9a0jbcWtMgazTN3d1TcmBGR+edfWPvyaxOBnOn86A2Yz02MCygkALSB1d?=
 =?us-ascii?Q?27mladO59ubMh6MsfEvc+B2TGpm4F1Z1WUbHDYkYLoN+eK3Dvb9uFx8KNCGM?=
 =?us-ascii?Q?DNFVxto4YJtgvq69aH8ycRm6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb4ebc0-1680-45eb-2cb2-08d8cb1b4f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 03:49:03.0511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZOE50QXfM9GNM/P5HZAI9NGS/hikfaZ+bmfrqlcQLNlNXnuM0rbfgbhyg9gIP/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Sunday, February 7, 2021 11:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: enable LCLK DS

v1:
Enable LCLK deep sleep and it works if we enable ASPM:
modprobe amdgpu aspm=1

v2:
Add the amdgpu_aspm flag check

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b9e47f3b0231..af73e1430af5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -302,6 +302,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 if (smu->dc_controlled_by_gpio)
        *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);

+if (amdgpu_aspm == 1)
+*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+
 return 0;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cefc5d77f73174dca068808d8cb16b903%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637482645750459900%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=e2RbIxZdsRt7eFr2hTgtCj6lABPanAZoyI7ZnorYzks%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
