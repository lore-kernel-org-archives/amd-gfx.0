Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B818C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8377F61158
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8377F61158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2E06EDAE;
	Thu, 29 Apr 2021 08:32:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81316EDAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+tfVBVGpFpD1bLG7zUoQTJtUSCKG2VaAXGPYrdohNFG/iYiSBZMTcqI2JeEKFLpgcPqx3XNxR7gd1b+DS6S1ZCNN/fzHw9uXCZTI1hXSZa5p4vq2tvOnKFWrV2CV+jvvXTyxooHl1etxQ7e1j7hUOwS6UafHJcbt9LCDufwK7T7+QSJayeQEvXRJuHRXn5XRAj1V6KwEPV0ORDjghfx7kFycrVfB5YkZL3TUGpaURN7HUQ9uGWe/7spa4SSQ0UPJLsQwoQIrIxjGMoj0qJSDMIAmxBD0DioPSThQmpR+XhO9kSQLdlpqHIoPHOZJaGRwnaPZRZkt5/GJSeSJGumbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKMAzJr7PFStmRzIGpqWuWWwcBBspKktz2NH6gKWuW8=;
 b=cBbuPNlsRnvb9s12JOKCweyUsOkqa//NpJxbZf1ND/KA07VZG6WuXngqP6Boau1Wi94lFnaGx7e+CX8peaQ61eVkUXgWoNnx1Ff4+Fu6Ky8BBGOgpGQErDgavi0/mqlF6GvD517HkN8Pkh4C9duAdvyW0o6NXrox98ebkBHBPJvnnkpte1F9x3u71k4xnWf72YG3OKOw8uQg/M/3qg963bGg/lBw+6mLdvpgu6DIboRsGnC3LCxoUY660gqxU5y+OBDWeSKlF7Vwc5Ml7e9bCbZPmqzeTsabvGTSYi9fBRhjAY3GbV2MruMjiN9RxAXocUYCT4y4XCBCJjF1bUmS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKMAzJr7PFStmRzIGpqWuWWwcBBspKktz2NH6gKWuW8=;
 b=axZHowwcEzbb65dBe1WB622CnWqYFnHNsrK7/ilF8OwOTE5JjLplOPEhrsNaWWfC0pYwytQwOh0/0kHjpBUzQ1id5X/MVmWMdaFHaMYuA+C6KOpL3qsdv5EzeLpA1yXd5cGHcnsNAHdE3KclZwPNmjBMwWFpV3Ika3F7YUFqnQo=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 08:32:34 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:32:34 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/7] drm/amdgpu: enable ras error count query and reset
 for HDP
Thread-Topic: [PATCH 6/7] drm/amdgpu: enable ras error count query and reset
 for HDP
Thread-Index: AQHXPMCOeTeNlgZdFkO39cNUJz+N8qrLKt5Q
Date: Thu, 29 Apr 2021 08:32:34 +0000
Message-ID: <BL1PR12MB53504BA1B92ED4948ADF207AED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-6-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-6-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:32:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=348aa18a-052c-4546-9d52-8516f4102ecf;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77a42ee0-4d4d-438b-ee93-08d90ae956b0
x-ms-traffictypediagnostic: BL1PR12MB5174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5174FA84BC2B33CDD2B77F12ED5F9@BL1PR12MB5174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4l4LzNGJ+SukrqartCvFPvO/g9ZDgZPLHWADaFuotg+Av6IuqsgycrM4Ra2UdutHIJbax2i9dzHkULjL3Z0AyaUB8hGidspRvBnMc3ZtHWEM1xP/bblENgvwdRIOi3HbNPr5S0ALBa4ROsrz4tCdkYWFRaTVNYXDJbVcyAqTWRb3mHhBtl0qAP1BpDYDTI9zxV8zSVqaA7+4JV81/QxExwH+DEwx3wq6XJKNtHqYTpXTyke+XnErOqVClGCQ31Iiecra3gbevP+na7sNLfG98N/6avNBIvD9OjWsfbaGJ5FtjoR2V41Fxvr5NFzt1ByKw+aIOSqmBodmVUpOyjKcu0fj767JIrcwhvc74I67A/B0rwdRflpVeiTGP2N3thOX5ZFsN3+Ufm37rjLc0Y8eBU9EQ2db3fpPYg1VHMUmVRAZYHnqLCe8R/hdNURhp6DIXPpVhShrnpDm8A1R8cjH/hvgcl2cEdBfL+x+SMIX9B8vQ7axZ8JgANxOkyjNjcXTNh6Utx9AYrlKm8nq7PcGGEp9vHn7eEEJtYoFDfsQVx5rM8wqf1ZvYB4hdLotsac6LeCDkUAL1dDVF00hOKfreg5iDTnCfJ/2IIlrL47zx8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(2906002)(5660300002)(478600001)(8936002)(7696005)(83380400001)(6506007)(53546011)(64756008)(122000001)(55016002)(186003)(8676002)(66476007)(38100700002)(66946007)(52536014)(66556008)(86362001)(9686003)(110136005)(76116006)(316002)(4326008)(26005)(33656002)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UTA1emRmdm5aVmlneXJ4WFlCNGE0SFBBWUpzd2RTbmltNTRaMThPUmZlN2gy?=
 =?utf-8?B?c2pDSEdHUEQ2L25vOU1nYXZhcnlKeFBKbjhYYTZ2dTUxS1RqbzZ2SndnK2F2?=
 =?utf-8?B?R0xXYjJZV0JoNHF6YVdVby9EUXdJbWI0SEM3eXl4TnFmVHRjZ1BoQmVWU2hO?=
 =?utf-8?B?MEZYVVpubVIyQjZ1Z2VjRkROOE0rclZ0NXprdUQ5TDV4M3ErQnJJZGxTR21h?=
 =?utf-8?B?c3NLTGFjQ09RUkFmaFd4c0Ixa2UxRHB5bkZRU2dOQUFXeFJzRytDYnhZOUJh?=
 =?utf-8?B?OVRRdFNKb21ncEJaTEFkYW0zV2w1OTY4dEdmZWJvYjBFNlRaR3l4SmhzcFc5?=
 =?utf-8?B?Z2w5bHdORG1CWjlzVWZjcGE5NTI5M3dtRm00bFVVcllJTjEzYXoxSGR2dC96?=
 =?utf-8?B?czVMbVZTYllnaVlpellKQ1psY0VnbEZvdUtTNHNkQ2QvR3RLS1RqS0F6VGJu?=
 =?utf-8?B?T1BJQUo4dVpYNnVjZG9nNThZUWZmRk1TNGFTWU9jdk82M004cUZjR09Qenow?=
 =?utf-8?B?bkY4OVdsVGNNZnIyRnBEbjBNUlovcmIzUzduLzlUanVkRXcyOUwrLzBDdDRR?=
 =?utf-8?B?aFpKbVNibFdMbDVzTW1Ldk1mcm1JQ290TmxDYkM5WkZwMHdHWTJLTDZCZFFD?=
 =?utf-8?B?bkhmUEhjelZ6SHAvQzIzelAvWUdNSUNPWHl6clhraGhOeXVsQTFhR0VtZDhB?=
 =?utf-8?B?QmVRbjc3a1JJL3I3eXlQRXd6bDlvYU5BY1lQRi9VWm1Qd2NsZGQ0cElyZDI0?=
 =?utf-8?B?ZHB3ME5hZU1hbzNoaGgzS1ZHSjRtb0VvUThBR3ZzVHlpUi95TEJGYys0WXFp?=
 =?utf-8?B?ck83bUtrU1N5ZXBHcERsTGsxQ2RpOGhWVHkyR3hWOG9CRzB4bmNsRWZuaWtr?=
 =?utf-8?B?ZTBLOExjUC9tNHJhdVdkV0kxeXJabWVMMEFqQ3ZTb1lucFRGMG1ZME5BVGJs?=
 =?utf-8?B?aDlybTZQQVhMbyt3TXZCeW9KOUsreUkxL3JDb2h4SkJyZDVZSEJHZ0d2bWkw?=
 =?utf-8?B?VnhrUnJZNmhqM1Z1dnYzbXpBNmF1SWs5ZGVqNmhBc0pkSzVISHNEUUJKMUtw?=
 =?utf-8?B?R3puZDFiOFd3Y25GZStPNzh6U1NxNGdRdDlKUVBVSW5jY2Q2VVIvcDlaM1FT?=
 =?utf-8?B?MFRWa1cxSFppVkVhbFl5L1JWa3NFNDdFVWRZaTlmTXVsOWw3cGJESXN1Q0Vx?=
 =?utf-8?B?TVhRVzJmbnZKcnVXZzE0ZjNBaVRtTlFYbGM5UzFHbW9LRW85U3JJN1BHY0kr?=
 =?utf-8?B?WDltMmNyRmZIc05RVnBoc3ZqSXgxMktBd2h4S3pzWHBoVHltN3NSenQvWm4y?=
 =?utf-8?B?S1c4dlhWM0YvRHhXRksybTgzaUM1VURYblM0b3N0bjBiRVVSMXJaTGREa2Zl?=
 =?utf-8?B?Q0tMQVRwK01uUC9uSTBZSmhSRzdxUzBCYi9QdkRxT2wzOUZYUi9vR2krb3VB?=
 =?utf-8?B?OEtPYXhFSTE3OXBSSCtvVHV6d3RuZE9uR05VdmlxcUlGN3NnOVNwbGoxOGVy?=
 =?utf-8?B?T0g4U2gyMDNieHZaWms4TE4vL0Z6bTNoOEdwLzg3R1JtWnpPQ3h6SlRUV3pm?=
 =?utf-8?B?MG94WEl6dUFFT3VwVW5rUnVPOEI2cmtkWmRKdTJyUE5ZVlR4bTNBRTJISTll?=
 =?utf-8?B?NXljaC9vMHdRVlhmblBWWlVVMnllU2N4alBIc28vd05KS1dEQ0FnbFZxM3pZ?=
 =?utf-8?B?T256Q3lmanZ4S2ZCRWpqSnBrd090R3RUK2E3OGU3dVprcnB6TlJ2cXJYajNp?=
 =?utf-8?Q?HqhFPoGCTPRrBLB572Arytb4XMDqP4AgXNs46Ih?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a42ee0-4d4d-438b-ee93-08d90ae956b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:32:34.6146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhNuwvPOO4jJ17sIfHPMdVX3yN5ThcACojVRXL6eiP76FnNibJZaFsDQyqhFvyK6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch looks good to me.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: enable ras error count query and reset for HDP

add hdp block ras error query and reset support in amdgpu ras error count query and reset interface

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  3 ---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ae9fb20..984e827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -890,6 +890,11 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		    adev->gmc.xgmi.ras_funcs->query_ras_error_count)
 			adev->gmc.xgmi.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
+	case AMDGPU_RAS_BLOCK__HDP:
+		if (adev->hdp.ras_funcs &&
+		    adev->hdp.ras_funcs->query_ras_error_count)
+			adev->hdp.ras_funcs->query_ras_error_count(adev, &err_data);
+		break;
 	default:
 		break;
 	}
@@ -967,6 +972,11 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		if (adev->sdma.funcs->reset_ras_error_count)
 			adev->sdma.funcs->reset_ras_error_count(adev);
 		break;
+	case AMDGPU_RAS_BLOCK__HDP:
+		if (adev->hdp.ras_funcs &&
+		    adev->hdp.ras_funcs->reset_ras_error_count)
+			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8e0cab5..3daf806 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1276,6 +1276,10 @@ static int gmc_v9_0_late_init(void *handle)
 	    adev->mmhub.ras_funcs->reset_ras_error_count)
 		adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 
+	if (adev->hdp.ras_funcs &&
+	    adev->hdp.ras_funcs->reset_ras_error_count)
+		adev->hdp.ras_funcs->reset_ras_error_count(adev);
+
 	r = amdgpu_gmc_ras_late_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d80e12b..28e9f6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1521,9 +1521,6 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->hdp.funcs->reset_ras_error_count)
-		adev->hdp.funcs->reset_ras_error_count(adev);
-
 	if (adev->nbio.ras_funcs &&
 	    adev->nbio.ras_funcs->ras_late_init)
 		r = adev->nbio.ras_funcs->ras_late_init(adev);
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
