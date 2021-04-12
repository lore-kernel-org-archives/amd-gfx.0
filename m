Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D406C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 13:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DD36128A
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 13:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DD36128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694346E2F2;
	Mon, 12 Apr 2021 13:11:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06976E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 13:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jleLA1Z8w2+52jZlg5hOfc/hzuOP5oeqsSz9BQFw2Tq3DCYtcKbE27wXO1JwzsbkMignzcCXencpJ2NtsepA6oQUVI0Io16HFnlOqKL+mdSF4X09ZR2e5vbwy/ZDEO0Q/LaJge8RHppOunPE7oZ232Jh0n/c8IFf2GdsvulTkSL1o6QJSfLOv5u6KNQFLb7pM3INdVf44Oc2PwLglH3l26kllZBEvrmmdq8h0MO3BU0tYsn15Da8mMgCWXBd9dNsHlkgAcKMoUJZnAOAjqB/E9vPGzWkKbvvMXpQ0xbSqhmUdNOfnIdXyFhO0pwqkZAGljEjyhIWQ2KX6IjjKoUf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E3d0AhkJvwOuWgJf3Ex6WZzLXwvovxE4RV//EQ5+WI=;
 b=Tu/OlObeAzb4TGKyYFoUOdSgLYlS+bkbf05HIWkzvvUNwxzhV+VH0V7pbWsSqIIPE/Q8ujcAG/SMJ8HEDePXzdoy9qAZ+9426RkDjzaaRoxYeewgrCaoLLer2LxvrVV/bO9geTcKP0Iowcu1+zX+evJfJaTDHOQROz4qoEsUQb5dx/uuni3IusEz+fZ+tn1yphQgWwzorZmyWEr/d1GJEw0x+61bJuv7zdGpCEvv+LZ/MFKY/M4yABRx/ppL1dw6givSQNam6zfrQjBHNRzKbrnlXhpghlTq2Shm7crA/F3ecSm1W4EkhB2lwUtKanyoNio3fKGgmeJuTOsPOWrhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E3d0AhkJvwOuWgJf3Ex6WZzLXwvovxE4RV//EQ5+WI=;
 b=JptcoHjSA/vh5LSb4j2agoY1+YZUzMM+9AlVRFr2qrWzGR3vhwkzAma9QPq+4L3RHVIUR0k8XettHFCxIspsVSkiK9zzLAQrUZ5ZCSx0NczztE5sr4YlIOtmXJO9b11Jks1AkvAbrNVhVZJ2f9M2aKz/VXmeANdVFZghb3XMn8c=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3900.namprd12.prod.outlook.com (2603:10b6:5:1c9::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Mon, 12 Apr 2021 13:11:23 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 13:11:23 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: change MTYPEs for Aldebaran's HW
 requirement
Thread-Topic: [PATCH 1/2] drm/amdkfd: change MTYPEs for Aldebaran's HW
 requirement
Thread-Index: AQHXLXvIBGNu/rNwJ0CecWplLwYbYaqw35BA
Date: Mon, 12 Apr 2021 13:11:22 +0000
Message-ID: <DM6PR12MB27619D06ECB60B8DE6DD52998C709@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210409200527.30234-1-jinhuieric.huang@amd.com>
In-Reply-To: <20210409200527.30234-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-12T13:11:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f112e97f-f4c2-4f67-b4dd-813cd19cb385;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:59d4:5a5b:7272:81c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a813356e-02bb-42cf-a2bb-08d8fdb4789e
x-ms-traffictypediagnostic: DM6PR12MB3900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB390022CC5AFC38FCAD1404208C709@DM6PR12MB3900.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHrgTe5Vi2kLgAYaR5twRLz+sjMTST6Fxpy/hJTjLxS59br00Fql0T6a6TcTN3IRNY+SdMXK8HVCTn3hOI2T+jBjser21sEg1cQIIwtoUuVedPy4k5JMiAJ9EJmSOtuk+FE2ycH6zO9wUqsfkdL6+KGgcHiIwDElpztiGjq00NGlr2N3QKis5M+RuZYYziuvkpt6E38sBBxoa69f3mZShBgpXh5d0jeD83lZAlHRXTgBWN1voBo9WeSNp8Bn+5I7fAiILkmcTG2zZiDPun47K8KDhfWQD+ye4htQmmzQB/JuJhTvpM3oGPMoVSNgwGw+p4/a+7Ct83AOQra6Ak180lCmbNUvjkaH+IuhRs82f5RcuObDfXwcqPJdMX5H8clv1KYYse4KYbp9oTJCNx59seK4bq5wDR+euzzpraJa9RBcited+tflI1W9p8wAS/2LnIOQJlSzTT0Pn9q4qNWqc4qSzV0ds/0BRPQWawBJnd+5Jf0FIKU7KGvtLsmiASTYQarMRBM+Q2XA0ypZMDzvsVMmuCL4KiF2jxuYoETJpP3mn+qMJMQQ6IUimtHnge/LRll//wvCI695x/oH2ndfUBKX2poyjWBICdSgsOetJ9K7RUfdkFCEykaVp2Fnu5P34X3zsaiEoa583kWG1p4fFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(316002)(110136005)(38100700002)(53546011)(76116006)(66476007)(71200400001)(186003)(86362001)(54906003)(966005)(478600001)(66556008)(8936002)(33656002)(7696005)(52536014)(5660300002)(66946007)(6506007)(8676002)(4326008)(45080400002)(2906002)(66446008)(64756008)(83380400001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F8bI8EJKymFWbGWtxAor6D04ZIRil9uH1KLkzgIV9d28D28lyp67KfLe3C4s?=
 =?us-ascii?Q?oGxysD4//x24DPa/l1Lclj1hfa/nlRt6ffLfHbcrGso3fMZBbqVyNR283nsD?=
 =?us-ascii?Q?3AeUJnpm8Y5z1Pz9JQdN4BQ9GkEAQJbiDpcywc7g028sHiwvAETiqum0z9cq?=
 =?us-ascii?Q?t3YCUL+6eVfCAuzYrHkrNO8ZN4DwatmRxI9w6Ph+dgU8lBo483GoKtbi3Jlq?=
 =?us-ascii?Q?BN56tT5v53Qz1FoZR2L32zwVNCFq9QMDhdE2sYqTafp/9j25gnOs4x30s+sr?=
 =?us-ascii?Q?gfSyUppjF2BfKdTVLyK2iv5MJsU3mZrih/B1deS/MejvzKoDUOqIrWlCcc15?=
 =?us-ascii?Q?6k/DZaKbh+SWgJBJAWIHpazWmeAGg7iUJRVagvmUBPaavSG3+7yHnO40X9Qv?=
 =?us-ascii?Q?Fsb8D1ECOSwtLS+DEZ8rTGQ+9+gL7+tkTzVSD4i2Fd1kgFNLaPBMEGp11Xk9?=
 =?us-ascii?Q?WdXIAqdEy/C7k4uu9xX59rnRb7Orqo2+Jp6I3qSoBQGxTY7xj/DgYarmZY/a?=
 =?us-ascii?Q?mwlY7L4q9pO9r67dSeZUMlKQNYlqgznnnlJWsNQidPjIBREe1WXlrnc1XK8k?=
 =?us-ascii?Q?mnhGFpmeuyUo28Tzy+7PzaHf0h4Xe/MD5SoURXNuvIxK6/JMcq1vgzzc8HT4?=
 =?us-ascii?Q?acCvIzDqd9rg6/pOQ96jHCaoD8sz4+3W6UbKWrx2e2MWfgwOY21uwtqKF0aW?=
 =?us-ascii?Q?3ALA68+ZueFPYCP2l03N1B/caVzGWiKhr2eK5txh6AnWo47zcb4IMHBABX8m?=
 =?us-ascii?Q?54bi5Dgo0pZ8pgnFHgNg0SWBbo4nnd+MFMh8+e0Oky0oypObUJ6d9CehfJYw?=
 =?us-ascii?Q?4ci1cVVqEld1xi1m6PO7SryKfdzjfiFAu4+yspuROPQvWnR98cp/43LBHN/T?=
 =?us-ascii?Q?EIESUJ/oPaar7lkjizVlZREQ8OSZbMZFjgWNEpk53A1hwvc31750XdFX69gc?=
 =?us-ascii?Q?iAXgx83bSaTFY2AUYRUmgE/iRpsZ42sWXY3XZ7S6tvsObNCAGCF8t1S/D/Od?=
 =?us-ascii?Q?xTlGIPJpxmAAFrsyxbx9+hIPdgdvo9Dr6geYjgAaNBvCu1yCzy56yxpoMx76?=
 =?us-ascii?Q?Pgzd0GWjexWCmzkMX312g0+o3zYcAztbbmnWyrtZ/pMBCnPxF732BKwmr9Pv?=
 =?us-ascii?Q?4C80BWjoI1umZNItyQ/JBUi6PSOrgfnYK+yWuYh+TVprT4WKnDNq/Z6s68Ey?=
 =?us-ascii?Q?0rvlbGXHbKE/PnJxuCxPRFl0xa1AAgWiULX7Sl7KS5atlF+R3mgMb2ctAJsh?=
 =?us-ascii?Q?mltNOgBQz/EhjTUzSF8YXTc3VMSuvm/Nz/ExjwaWviX1bagSGSbR2L4awFmI?=
 =?us-ascii?Q?3Ahqfm7zf30CV0CWJmqNY0+X5BFXX4QOOTuBeVCpdqzrhxa5Z8K3poKDpJPO?=
 =?us-ascii?Q?bBROSjlrrng4u82A2RYxT+jOkOuA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a813356e-02bb-42cf-a2bb-08d8fdb4789e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 13:11:23.1048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+3PSzRCfA97kmqvAQMFGNqQVivRVyhbxgwO6Pir7EawdTerMdGC2YAoNBofDh773wEoEG0MzEcYG31GtmBO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3900
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
Sent: Friday, April 9, 2021 4:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Greathouse, Joseph <Joseph.Greathouse@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: change MTYPEs for Aldebaran's HW requirement

Due to changes of HW memory model, we need to change Aldebaran MTYPEs to meet HW changes.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7357c1e4d883..b6662f53c28c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -439,22 +439,19 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev == adev) {
-				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 				if (adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
 		} else {
 			snoop = true;
-			if (adev->gmc.xgmi.connected_to_cpu)
-				/* system memory uses NC on A+A */
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			else
-				mapping_flags |= coherent ?
-					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
 	default:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Charish.kasiviswanathan%40amd.com%7Cfccf86dba3ee4f08205b08d8fb92e9b2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637535955702309648%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=U8Uv2qoePy%2BQct%2BDgho%2BrkGJvbJQpcwE%2FuAjf7jREGg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
