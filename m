Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DC2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 07:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F346E822;
	Fri, 26 Nov 2021 07:34:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B065C6E822
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 07:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+TdLZLlMDyrB3R/cs73j49axvqsECPhRaTpuQ/S2+8OeYmv053zUuMWNIaAuV9uB85izuP9Vk6yxM03qmW6uABoMYYvbggRvZ4lSt906q2XxQJbal2JhHC7JOY9dEbxoFTU6RQXTE0xJJgEk5JRvnamD9SHA5KEaRhL5uEmhcTd1Xzm3URMiowr8dHyt5sg/m1ImeyEqutd6glM3xrK4dlCnqxPlewBTIyfbWopQcLat/JvGN1KGaNbrAJhWUJk6f+ejLZIIFCrivx8jTzMRdfZaqmd0y4VHdfRZaz1ShBF7RxX0eDjTe4N/9xZlELQLN2PHDKtTGO9eyT7GZtaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/UztWEItI7KUmXfhYHVlo0qifYEEwJ+BdfjoFmise4=;
 b=UnRcZJ2pnKvry6s+J/qS7Wgu9Vga0bWwQTKaDVZFscqEJTMH61+U0NGGVdOAujoCIuVZR80cgmPMKFzf7cnJD3wwXL/P/cqMdqEFEibkvVyyhWTJ28RSFLh4KFultPFzSClAqhDY0KgiAMFRGOIyok59di4cYexfjJnL//9LFgJ4Y1OSrHDWru1pAAkzp6MPumQwaqwpJK5vbMj6buR+t+uLl1e/VwE9huYPqoEUTkOUVaQFPGRx1aSsG/pp7rw1mVxMzz7q3UchEboXSLbon8ljY01kYVfZZPB8q4qiNXFBv3IZ6ZcERQRyfFL7XEVKZiZ1n/865jKb1dR5/7k0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/UztWEItI7KUmXfhYHVlo0qifYEEwJ+BdfjoFmise4=;
 b=JYU3Z0eOyKXHDed1LezAgKzY/MEEEwapUmjjYbTf3yxygCxwTaeGf2ZqibbBDEMUSRwTPVirnXOLEn5TN0HWEDY19d5t/Lvzhqc2qDNPCRMFK3UGlN2bPSovIbWqkw27bHZu2xP6m2hpGbxR4ayp7oWGno2wFTYnfivX8Z0dLXo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20; Fri, 26 Nov 2021 07:34:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 07:34:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX
Thread-Topic: [PATCH] drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX
Thread-Index: AQHX4pDtihnslJ8Z9Uq4s3I7SJI6RawVapmw
Date: Fri, 26 Nov 2021 07:34:05 +0000
Message-ID: <DM5PR12MB246967CF300FA565DA6EFFE8F1639@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211126064305.141948-1-lijo.lazar@amd.com>
In-Reply-To: <20211126064305.141948-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-26T07:33:57Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bb7df9de-80b0-4b12-9133-dafc364b2f40;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-26T07:34:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4b50cee4-db82-4e49-b6c3-7d34a2a4e6d5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50a9d0da-205a-4d39-c7b8-08d9b0af204b
x-ms-traffictypediagnostic: DM6PR12MB4435:
x-microsoft-antispam-prvs: <DM6PR12MB4435F3BF09E48D7FC01D1B5FF1639@DM6PR12MB4435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZK/9wxSOHnr1Z/FUId4RH0gRi74k/6X1cqXio+mNluRGnpmQbNin34BZ6MEzOG/4SdnPOaLCjo3CCtaTAcBWjUxDqJtPOuWOXRTVlKb1vOjjFgkwnxQT7bNHokYP2Q3M7yztwbQI3GQc7/n+BWHszs7DkgDxf673QUEuX/Pao2KS/GHTIQ2QknYfdPQdVRXEbvjDKWtbiOaC2Z45KWQSfi5IQ1ojzpYowo/RA494HPwZYjYsjiE1/lWSyI4Njekk6iXKa6n2k8V/z3aZph127hsuLMxHitPGrhktmhhdx4OyOtt7dNOnI6Jl2gZ3S/mC018hKcdbnfcvebKyjgw7uFT+orvzIAdrksc5E5S7CBJO2huH4HV1JOB1f4p+mOYvDgm8+ZiK8BaRHtHixdhBefa33grG75IH3KGSvfxAY1YF4EGVLli7MQWPV/jVOk8wtiYBKhxpoqpT9b4pUGw+cvNeuu8BtEFhTZb7f+cboyzgxFmYiu8FZGorDMalX7YwAcYhEVJ6dcVbtBgps9X8jcST5IezWKY/UmDEKALoCbH5m6Yg4MHUs7nD4s6pQkUBxWqfFCb3Bn6s/is1rS8y+MpzYoTRvoeLo40nCGDEk3RM/rfQBYUnc2sDuknmeY9M0Khz95HcmEfxof5UTTRjfWxfbdVO9qAlBjZNYNJGwaby4S7IhBOTZKt3+uLgpp4S9E07Nyqe7uYiiQymfHSXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(5660300002)(122000001)(2906002)(66946007)(86362001)(76116006)(186003)(83380400001)(9686003)(38070700005)(8676002)(66446008)(66476007)(66556008)(6506007)(55016003)(8936002)(4326008)(52536014)(508600001)(110136005)(33656002)(54906003)(26005)(53546011)(7696005)(316002)(71200400001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lqH2tQ1/W5CJgk+xIlTPlFpE88+HHvJA9Xlb9ui3hOtuk39fHfaaveKgKFIo?=
 =?us-ascii?Q?4ZFAuL5mLsstTecYSSSAP/YPNkkjjM3yrb1YcoUFEDTXkFQ2lJfipwcDFbm7?=
 =?us-ascii?Q?71fUWXZ8lkL5abGfRx9z+5oC6kw6rYhNoGzhrUxtp/NiUGe8JIxclmP5RkrE?=
 =?us-ascii?Q?UyqfaPALKV7nLU9jk49fOrI7nk1CMHTdlv3804tEqxKIzm9Tu/rtrZHPLwre?=
 =?us-ascii?Q?7qoyx/YXLGIjK/ocWXUnEmuCCsYQqLBlCBzjaED4huZqM1iefUASvVSV0vjh?=
 =?us-ascii?Q?GNJtj+NFyiIHPt8hRj7BwT3PYveZoOWmZsQgqNtfwcTafTSajjxKeFE9RU12?=
 =?us-ascii?Q?QErrgbC5QUjgjRIvT/PBwGXd6vfv+Sn/rQZ81JxJ+7e/R3mS2shJ5psi7HGy?=
 =?us-ascii?Q?R2bmOGy/bK7TUfRXo+A4gt8BRv6BNtiC5FlNUPiSuVeGJ3Dn9OiXewJLC/L/?=
 =?us-ascii?Q?eGsqab7GPgtKb8Uesi8RGj+767lFWJhMgybCEcxp4YrJPwKMCuF3baiJ1Iin?=
 =?us-ascii?Q?Gwkj2FrwbwzDwDuxnUPJrLjw8X+2Yaqw6o9d8M6XS90mbRW3d3kPmEt1MsGo?=
 =?us-ascii?Q?cFvPnxpSVcmRPbT9r172lJ1kog8eSQrYrG9MnwhO8ArWYFzZCXMqTUPsQQ1P?=
 =?us-ascii?Q?tpOgcTDW5MINZBh2N90YJXsv5QvAIacfwur3sAmhzy73Kbgptfmi0VHnJgs5?=
 =?us-ascii?Q?zD4Za13qxOeQldlB+pog6pALZJ3MC72G1kZPo/wNB9JertOFdEyKliXWHt5R?=
 =?us-ascii?Q?EwhiNR3XfaRIsGNnfdGKgGtn1dM2yc9jurBlYdjfDjVvd2M2RfCp0s02RtF/?=
 =?us-ascii?Q?51w6uNpTgAzl9fqI3WeAhB7iw1xxeZjBX/UgJozX0XlxIUViU5fJiFZgAK3z?=
 =?us-ascii?Q?7hfRg+kUejEOH9wnkIxYTj4YxRnc9PpCcx+fMMXcOorcCKQEDNbwpcR3W587?=
 =?us-ascii?Q?/XkCv9JWJjdtzn69d4444GhmkaDvAKJQS3PcZZfnWU+zGSgJi2dx2pdyeO6U?=
 =?us-ascii?Q?oDSygSSammWj2EikgrqS3DjArQXYcb/zwHiNr+i7HQn3FRymadAOZ0bmlhPU?=
 =?us-ascii?Q?xEzhP3fQyGvZ5a2CK7F69W0w4BqsDM3Zy678ujq9eUvugOeS7iC0jMh1NnfV?=
 =?us-ascii?Q?A/5+0iNtnOWew8NsAKzY1b2VfbM1oUa6EDW8IsVEDBdAW/dyDRyqnllXUMcq?=
 =?us-ascii?Q?EKpPubdG+qU+IJr56iv/76N24Z+rHhgpmsZNCF84sTIxg5QIA2pFecn6I0Q8?=
 =?us-ascii?Q?U/JgWMJLyqjmP6wWnYrQM6Y7gsxeDlnyTS7nZGtqGDOfinjaZ2R+da6o3sh5?=
 =?us-ascii?Q?QknZocBa/iqebN5Vl5QqP2802f//JsieyJvs18W7JRElra2OR1aeslyHdcyX?=
 =?us-ascii?Q?xeoQedP3ejO1yl5hDNFcS4/oZkcpzZgcIloxpGVsfg6nbPScEVh33NLIYTmH?=
 =?us-ascii?Q?OyrnHN5BGayrY2n8lpKX7nzizoMEbh34GSpzHVhaSCQgZJ+YWR+nXEE0860y?=
 =?us-ascii?Q?NntqJUrzW1c1GuGsjbXNwGUQ4O4cZeDCI1kroHnl251DDmsWA6+5JPKzUlds?=
 =?us-ascii?Q?eoVYko2dyKjEaSvs4qhqpP7Z5t/vzxmST0OjoKznw/XpgiKVikUr+DN2LyWg?=
 =?us-ascii?Q?6ganuIPjsr46AlE0Oz/VNu0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a9d0da-205a-4d39-c7b8-08d9b0af204b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 07:34:05.5719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFxulZXPY8Y9RQO5MJaCi8/CUdCHNQu+tXgIJkCMftwKhwUuXFbtXiq+3N/J4kGOtfqQBRPATgSvxqUh+m8ZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, November 26, 2021 2:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX

HW_ID_MAX considers HWID of all IPs, far more than what amdgpu uses.
amdgpu tracks only the IPs defined by amd_hw_ip_block_type whose max is MAX=
_HWIP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index b85b67a88a3d..c5cfe2926ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1096,7 +1096,7 @@ struct amdgpu_device {
 	pci_channel_state_t		pci_channel_state;
=20
 	struct amdgpu_reset_control     *reset_cntl;
-	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE]=
;
+	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
 };
=20
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
--
2.25.1
