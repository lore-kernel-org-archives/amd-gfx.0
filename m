Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EC9C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8171224D3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8171224D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2111689B29;
	Mon, 11 Jan 2021 04:29:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770080.outbound.protection.outlook.com [40.107.77.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A55889B29
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+toR85y7hiRXth9L9LV6J2A3GL8/O7Ta+0B5VQ9r1xgRV/9p5VcopKXzPU/9gKmgAm5LfVWFDN89inmRNpc0wzwttDoX5Y1uFaRd5IrqED1hYE6fmtaFoso+aCYAITJoxa6zQ5WU2mblh43jjcBnY2efg+tjYPgkP/6La3PWTxTab5UITIGeM32VaX0nnoirNM/ps4sDA6vIUyxDXolp4a66Cg7lr19VKD2b9TpCc/E79FzxJde73y+keZCXM9dz1Y5zzHrUMrcU+LrlGp9I8pb2y04qpxmQFrRArmauQRprojNqUVxNF5LRMN/hv2ANII51V/GXlefDgGiMNqM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTAlqkByOcX76vwnX+2yzGwQIm5jNVRt36ans1wcHXs=;
 b=KJHBua02FD73/Vn1lHzyAM8RdzWRWExfx9vdmsNlVQfsOflB/YW7poZ5iJwmMQwIl9Ss3kO1z01nZ5BHPWRTc0yykin6Diu1dGUv42/89gfUTaOdB1NWEtTQ3nh04BejWG6RTdnOJN9LwzbyfyAfSaygCbX5sRfrfUwOQ9EpxC+u+AL8RsbWzYtiessN2cmgWp/1M50rAJJ2yTH2ltxTFC0F/5V+Brzsf8S9TZhoPUtli7DTcurcf2+DmdT0Y5JnYAc/ywx3JT1nUCoqqng+IgzTp+5/ZGCgdZeoi0EnwyIYTylz3rO0xHK6U/mtOg/BQdtjkh4Oo4wlGGR/KXt7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTAlqkByOcX76vwnX+2yzGwQIm5jNVRt36ans1wcHXs=;
 b=3dOJRiqVlhaf6vEETzdNwrNFjzvxkpgbMnQ/WaQoXb19V4TX5TjjYUPAzYpHA0kDyDhMNd6p6q/EYEYcDUvqwEHIT8bFaHCZ7WJjrmX/5MR6U50ipsLEu6ZzleXQHmKd43m83J5rTOWXjYkcJ0p0iShuHHiloPFzPAfSyZssL5Y=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Mon, 11 Jan
 2021 04:29:15 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::886a:6185:379a:c41c]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::886a:6185:379a:c41c%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 04:29:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/7] drm/amd/pm: enhance the real response for smu
 message (v2)
Thread-Topic: [PATCH v2 2/7] drm/amd/pm: enhance the real response for smu
 message (v2)
Thread-Index: AQHW59IDmB0UmvlYDECbKTI+Kv2fC6oh1OHw
Date: Mon, 11 Jan 2021 04:29:15 +0000
Message-ID: <BYAPR12MB2615086347303B9457D83747E4AB0@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20210111042610.2234748-1-ray.huang@amd.com>
In-Reply-To: <20210111042610.2234748-1-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=040b561d-698c-4550-88e3-367163984bc8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-11T04:28:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60644a79-6d2c-4e45-3320-08d8b5e9746f
x-ms-traffictypediagnostic: BYAPR12MB2888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2888BDF48BB74E29FAD96571E4AB0@BYAPR12MB2888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXarrzUIrCbzd7Thad4NiO+PKjdyf6gZwvDQCoxWbFMnrUudVVv8DbHM/VSBn3ZNvUpdf2teE7f3YZXIMyhECi2sJNdWepAUceCCtim66M3+AvKBsfq9Uvu4ZM0iiRd+NFjgq8+ePO4kT63uvtNOtCYV/KbASsxj4/8/bxS1nY4T0XzRNiPh7pqom65DisUd9jK6YDA4fhX0dMjpN4hLlJ3spSVDI7SX1d09Dq3khcjePQZhcpKIEzZMJ7exl/lzu1htu2oNZAs94vhGTnQpfZApe1eGmvnE0IjoyIvIUTrb4odHM59X9brqSuMagBCtR3/nyI8YCSA6xvcWA7PJR+eC5Z640HYpEN4ppBizjeFf0/BQK1Tqk4cFei/oLIZZ/fL758uU+LE3CfWSRTB+zw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(66946007)(53546011)(478600001)(64756008)(66556008)(66476007)(186003)(4326008)(8676002)(6506007)(5660300002)(52536014)(2906002)(15650500001)(76116006)(66446008)(71200400001)(83380400001)(7696005)(55016002)(110136005)(33656002)(26005)(54906003)(8936002)(9686003)(86362001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vg1Kp6njPZ6SDYqis7cSXHeorjdBjZ/AZ+/0TX+Ec/Nk15PDA10ybx8R4dmg?=
 =?us-ascii?Q?Jm5ikbH99KJ2rq8FIL7DYoEcKUmGHipnEQsE4gLheft9pweHDMY4nq3Yljah?=
 =?us-ascii?Q?LaZoYJ5f6D3W+c8poK09GY4223lyZL/lx30YR94fFvNEkOnactMTNeygpdEf?=
 =?us-ascii?Q?+g1qGUKPafsoW9v6IhXLLa/zJYHiEXiF9d1phX3YF7ANourI7X0dlsXlDod9?=
 =?us-ascii?Q?g92XYcoGx2/GuyIdWRvtBlxhe1wQlXwPuU8cSYvPvyuAc2Aa9jtD1HAEzGvm?=
 =?us-ascii?Q?FEFPKd86keTmtoihCUFzM0yHPxyU8eVkUkqyoLGbI33fTtFI51zwDvM3AFPu?=
 =?us-ascii?Q?K1kHoI8QkVUEwm8nMvDvMJoqgtIhvut9L1iyqUNaBX902DdwmzcnQ/2ntOSx?=
 =?us-ascii?Q?WFFUuOA+8TPf58sQ2KglTBtzIGv3mwpwPq2uLvk76k5yBs6DemGds7QjisDF?=
 =?us-ascii?Q?jHbtYN5w2mgVQCuHyFISddfv4GAe7L7ewM3Ai5WFIsT8ZkHEJkpzg2obV7sY?=
 =?us-ascii?Q?tABW96wYL7UK2eyoEia3vHRmd+ba4iAQMbkrO/mzgPBChzPazBocsIFkoihL?=
 =?us-ascii?Q?nqhGZDRhtQdkdguoW0C/pXI2Fi5PAkcFFtbsrue3HL5bPfA4hdKYmzEXJYpo?=
 =?us-ascii?Q?P+4aiMuT4Bhx+4p/1/7aPB/OLDx3W2zQqg7yDJMwiOssWU3aoQtYUPdmvEGA?=
 =?us-ascii?Q?YlolM5wMEE03vq4NJJbSWvB7LPxOhTOK0bnN0aO1pNa5sqcl0H5GTAGk+Sxn?=
 =?us-ascii?Q?3f4Xv0QzP3ti8Y/HgOj0Rj0T9XjchJT/OWWJbVQfAOIBT+gaKbd82LU/CThB?=
 =?us-ascii?Q?83NgJTwl+ND2aowb9IOjlJ+jUZTGfjT3mc41oI9D8oeZzVe3JPMo5rn58rJI?=
 =?us-ascii?Q?LObL5Fq45pXMAyf4mn3SehF+qE5Xt9u/orP3V2aMNP78qxDCYUV0vpajmNmo?=
 =?us-ascii?Q?gD6qdTqvh7ZiCecXakIhH8fdqGVna1y1BpL/q/qq5H4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60644a79-6d2c-4e45-3320-08d8b5e9746f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 04:29:15.7777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UogtimAzoMn1HtbvyjuVo5/0CoI9wClxBZkwSUZvaPMVDmYaPN8tmuVfRIVDpdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hou, Xiaomeng
 \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Monday, January 11, 2021 12:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH v2 2/7] drm/amd/pm: enhance the real response for smu message (v2)

The user prefers to know the real response value from C2PMSG 90 register
which is written by firmware not -EIO.

v2: return C2PMSG 90 value

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f8260769061c..59cf650efbd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -92,7 +92,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 for (i = 0; i < timeout; i++) {
 cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-return cur_value == 0x1 ? 0 : -EIO;
+return cur_value;

 udelay(1);
 }
@@ -101,7 +101,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 if (i == timeout)
 return -ETIME;

-return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
+return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }

 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
@@ -123,7 +123,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,

 mutex_lock(&smu->message_lock);
 ret = smu_cmn_wait_for_response(smu);
-if (ret) {
+if (ret != 0x1) {
 dev_err(adev->dev, "Msg issuing pre-check failed and "
        "SMU may be not in the right state!\n");
 goto out;
@@ -136,9 +136,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 smu_cmn_send_msg_without_waiting(smu, (uint16_t)index);

 ret = smu_cmn_wait_for_response(smu);
-if (ret) {
+if (ret != 0x1) {
 dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-       smu_get_message_name(smu, msg), index, param, ret);
+smu_get_message_name(smu, msg), index, param, ret);
 goto out;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
