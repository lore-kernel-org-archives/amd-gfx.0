Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA94C433E9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 02:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8559A2256F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 02:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8559A2256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AE089ADC;
	Tue,  5 Jan 2021 02:36:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C267889ADC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 02:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfy7UOxi6f0S+/O1jJf9ueKNfAPDKjjAvwMra0+f3DQPN7PerXeAngphcwGb4Mv+KrDFZqVUjR9zx9+IFWPQVFN65uCxHfVSgLolvMzuX/JVGEHJ2khxh18wQGe3Aekv9L11rCUxCmAzCR+VAGNYPHdtKzGoMaaC+2kQUSQyL1Ut6JLG2MN2XjKyJyiRu5Nppcv2I/E4nY0WjwyCsdb5/i+2VJiCQ7taCZX+g/8xNheylCu83lkU0RrPTtcCaW40/8CHRvwdozkGQ46S7OUY6hTRYq0/2PeJ3PaW9Z0m8zN/34PR6uHWucmiOJP3S3s3Prr4quqjZ1/C1JQTnOIcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/A7zucsBvcEIIUKzoEmPcKm4Tn1z08q2Pecwr8DW1U=;
 b=NofWe4STtSukospHKO1HN4RImLJMBLR7FQUSmmp1U1tBBaKNgYfJmsrr9Zr5fVdbBfFRi7B3cCJfgwS+YYilqyS6vRhENs+eNHtYRdJlw+4S7dQiy+GgGR8GMGT2uD1RUOyLoiGKrUL0PoK+z0JJv3YGW3p4IksKbKXGupe+G6DuRrzjdFNpcK5Aw/EBunS5hTkxzD1jsmDwnuNA0q1/hmdD3I0A+mepdesp9mlXgkbHNDoBFQI6Lct6SdyuQ3I80JHViB2AKbIbhXwKgBxeqSrHCM07Q+DnazglXQgpk/MepTWuLqdmgbBSr2HS+XFzim4NBIqAF9IKPXW4rFpVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/A7zucsBvcEIIUKzoEmPcKm4Tn1z08q2Pecwr8DW1U=;
 b=ZtCd/bo5V3F7KoJZGjPWFX7KwvxASGak2ouQffn+7//BrDN3uGMBAQtoCzhtG5aVyozJbUlaH+IM9Un3U1VkEpLpgtmPL5y4EBqUDdGJMI95vVlpQiLRXHHRProYfXS5nkJcf+SfB8/zZ9QJ+Ov3eYkDBNr5XV0j6oHS9F6Seic=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2548.namprd12.prod.outlook.com (2603:10b6:903:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 02:36:18 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 02:36:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Topic: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Index: AQHW4lYt7eveuvOQHkSTMfUhjQQnMqoW/00AgAABNDCAABafAIAAARIAgAE54NA=
Date: Tue, 5 Jan 2021 02:36:18 +0000
Message-ID: <CY4PR12MB1287899382331B8A482C7B4EF1D10@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210104045741.22623-1-guchun.chen@amd.com>
 <DM6PR12MB40753D9F3AD6F45122AD08EEFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
 <CY4PR12MB1287B5959D62E8554A1B4CA6F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB4075FEB348FD9E5E9BF33309FCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB407585D3743AD60150C5ADFFFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407585D3743AD60150C5ADFFFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-04T07:51:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cdfbdbad-02bb-4862-8a8d-c469d16352e3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-05T02:36:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e3009f71-7da0-4388-a00b-0000334442b1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f7c74f0-216c-42eb-f6ec-08d8b122ae9c
x-ms-traffictypediagnostic: CY4PR1201MB2548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2548B2E45D73CB5D0CCFF67DF1D10@CY4PR1201MB2548.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qg5yXli8jiAMcOmfrcnRvGnAOJ8iWigjy4AS8zjnTzp0SpqgAS5Rh+gO0dbUOSWZhvC7cNkQ0BPMJX6LJWJCmFXJkIFJmzAmKPmeTCgxWOAVBCZ0AeyBudFKUQqgRng6hrc7+yC3BgrMIHAX9BKl1YCkrdN8v6SppDEJ/eMwADkROCYiR9MN+APt2/1wqfrv2APs8lBMk303kwRWrTGQCfbiKj4xf7X1sOd4OkAHbErQCXf5gnyTJnsOwBZbxdEUyuNyYCTpk8Iz3botzMvFh9y4L4kzZRCefTKwULjV1kt0nDHN/VLV30k84wq1g+vQ1PwT//IpSLDpbHusn9vj3e3/i6rlLNsaATrgwLzDK8BoyWN7dofxU54dGmNlzpuXTXv9PZQzY+MOGMdDb7MOEUgkDuPc9+NFuOy3YJ58Z/WnLxgc7kXil5ih9yc6T6NUxZy5Gnpy4eWZxvhAcRLvOY42fQ2rzew9cToPyL3G67w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(64756008)(66946007)(66556008)(66446008)(66476007)(8676002)(921005)(2906002)(52536014)(186003)(76116006)(86362001)(110136005)(966005)(6506007)(9686003)(6636002)(45080400002)(53546011)(83380400001)(26005)(8936002)(71200400001)(478600001)(316002)(5660300002)(55016002)(33656002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jauxV3M+PAHvEeQBJO4ZDRJ5F4tTGkHUEoBbWRyQlJmT5YL+fJwZuPvA4R4l?=
 =?us-ascii?Q?T3lzzTRshSEaM5EBQWCYsiC//DzD/q1bmeL1NUfPYoRsd3zqsNjOrJ42mt29?=
 =?us-ascii?Q?82uVYnqBqSzFPmpH3CnKszlCEi8KyMGrniWVcwv+DeT2JcbLit3cdnmWCf3Z?=
 =?us-ascii?Q?Zr8ExNVsnEW1l584OpJrtJtSlVXU+pqvjVs3+fcw6/CGWjPoYdaCUdW668LD?=
 =?us-ascii?Q?21RETmUZUdWNVvRYL5HuIppf0tt0JWBRdT3TsG0OsmoFjYyF0bgkrfSjDAUp?=
 =?us-ascii?Q?ZCTZwxLVgcaRDyI1W3B/YWLVeVs54uWwpy9lo/CnP8hz9gb4zGriIVUGKTlv?=
 =?us-ascii?Q?mJDnXRPBR8YupkG1yLkegMGKvljt82n6wt2xevu6LPqjBPsrWbf6FXF3Y6wG?=
 =?us-ascii?Q?oku/e1wg4I1hp62fy58sB8aDiJ5/crK9wG53cTzsKoKsrWwN2WAUjObaAIIs?=
 =?us-ascii?Q?j4vQfzKKTWbtlOSBkrs0V7F6rA1Gdacgt6tcqxXr+SdmbkggP5+lsMC56PwH?=
 =?us-ascii?Q?7QiVmDu7vfzPEB7ogT9JKdCFNnQ/zDprK0ISs+9SAPbA5d53dOaqn/HK9YIp?=
 =?us-ascii?Q?aHZmFx0bGpKph+xXo0CmpXXd3F8nshR70xjrrjLU0KbJujnKPqik/MoTtANs?=
 =?us-ascii?Q?onxzOTZ05k+CN18KKoZviajZGEnTAXtJIKkusWKsX7QcqCr5z9MsN4Vf9HkV?=
 =?us-ascii?Q?qJQdb63tysgqnIMi+QG5CaQxGgomB4VSa07upSGTQ/ZsWGGas9NcEx7TDMuU?=
 =?us-ascii?Q?PfyiLcvSaJB1jyhj0Xt5UMJGgDRCSICCk3Kla0IUJaMDwNYLLR78q8IGtc01?=
 =?us-ascii?Q?5dgqE3xVqPiBSvs+CVARPRQKdPizKTgE1xu3QWUCJTIxqcaoebuKSNHtTyn1?=
 =?us-ascii?Q?WE7Ng1IsqwvDeb5MB+eKdTZl4qu+vnEvXG8Nqr/tACrJ7uU3I9zdcJpY6wk6?=
 =?us-ascii?Q?g2ujEafWcE4zdwh4I1ddW9ez9fHnxf39Dy9VRMzz6rz58TlAqk2KSZIuSt6w?=
 =?us-ascii?Q?RpVc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7c74f0-216c-42eb-f6ec-08d8b122ae9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 02:36:18.7312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnZJYZ2qh/0CN469yvJzVI1gPcKgM/s5Ardks9z4cLOEHFj11p9q9eHhOv1xxxnMZuhNzdbyJQOFWFpvbjwimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2548
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Hawking.

Then let's skip this patch, and I will work out another reasonable approach.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, January 4, 2021 3:52 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

Btw, the original purpose for the asic type check is to prevent any further atombios call for RAS capability check. But it's not necessary to be there. We shall consider to change it in a more reasonable approach by dropping the asic type check.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Monday, January 4, 2021 15:48
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

Then we can refine the wording, or make this to be debug message, although the message already states explicitly this is "optional". Split amdgpu_ras_checked_support may not be a good idea since this is strictly not correct -  RAS is not necessarily bind to ASIC type. 

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 14:57
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

Hi Hawking,

Yes, these kernel messages are indeed not harmful, but some audiences may feel confused on this, as they will guess why kernel said " ras ta ucode is not available " during boot up, and furthermore, if the users miss some FWs? So this is to exclude the confusion on the ASICs that don't have RAS feature.

Asic type check for ras is not introduced by this patch, it exists already as it's used in amdgpu_ras_checked_support. This patch extends its scope by moving it to header file(amdgpu_ras.h) for wide usage.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, January 4, 2021 2:23 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

We shall check ras ta firmware image size or/and ras ta binary start address to exclude ASICs that don't support ras.

Introduce asic type check here is unnecessary and the functional also need to be modified every time we add a new asic with ras capablility.

Kernel message that indicates ras ta, and other ta are optional one seems no harm to me. this is not limited to ras, but also hdcp/dtm.etc. If people have concern on this kind of messages, we can leverage amdgpu_ras_checked_support to only allow the message for ASICs that support RAS, although I don't think that is necessary.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 12:58
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

Otherwise, below confused message is always printed during boot for asics without ras feature, but with common ta firmware.

amdgpu: RAS: optional ras ta ucode is not available

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  5 +++--  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++----------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..730bc1fe2036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1135,9 +1135,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 
 	/*
-	 * TODO: bypass the initialize in sriov for now
+	 * TODO: bypass the initialize in sriov and non-ras case
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) ||
+		!amdgpu_ras_check_enablement_by_asic(psp->adev))
 		return 0;
 
 	if (!psp->adev->psp.ta_ras_ucode_size || diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..41d97e56271e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1897,15 +1897,17 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev) -{
-	if (adev->asic_type != CHIP_VEGA10 &&
-		adev->asic_type != CHIP_VEGA20 &&
-		adev->asic_type != CHIP_ARCTURUS &&
-		adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 1;
-	else
-		return 0;
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /*
@@ -1924,7 +1926,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*supported = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-		amdgpu_ras_check_asic_type(adev))
+		!amdgpu_ras_check_enablement_by_asic(adev))
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 762f5e46c007..06b5f9d14bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -629,4 +629,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);  void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev);
 #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C3e86b4dc4a59450b440208d8b0850d12%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637453432786828013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=JVlHoxp6CK3QUCrNMfFT%2FOrTNGll%2FKP0z3HOrpy5z3s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
