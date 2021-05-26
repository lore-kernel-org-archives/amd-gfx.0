Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A8C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 09:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3473C6109F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 09:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3473C6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60246EC3C;
	Wed, 26 May 2021 09:57:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337E96EC3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 09:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChEEb5BUJXIHcR+zLSXoxvpAEAnLFJTExqGAwPfUpO6OMuVLtWTa+rsnCM8xiDObKna8GlIHjJpWSQunyqIjtyWqB1/AHE5yd3V25qPjuEU1t+zzuTEH5XfAeTonWBVd2Xyf2ofHWEiCp0ApQokcRocMNIFOLqMmwYYR/GX39wtaQ988oTpJgJeJsztoU94+3OPRZamADq9YZkc4L07Z/RmMor9GfjNQpM0PWO8F6kSOOkKkhLV60GUC6vu6Y/NVZMKsWPmI0kQnht3mFgN7isj1Squdc0Julyod6YxFYARtN9cEkc0ZESSJnvBRrzjpcIjYXncima0JvuSPUD0LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uBAQaCFez4wyc8Mxqtyurx/+Hzg+a6+xBYFZhYKOI=;
 b=c/ZB/YR2j/tNTFHZzsJvqe+U5QbSI7NoVfpDbR8cJ4vV/Y+voIz6xGOgoMjB6xao+4bi2BxWOFkse7yZawZ+f4RswKGwDQIGjiYMeqvvH6DDBl/cbIyh+rfTTZxHlSylrqM/8Tx7anunYy8QStMq8c+hkao7vyFtSh/gWzm4krpEY9yxYLZW2hHYkYjBucUsjU/98lOaiqGsIE2E621WpyOiPrX2xaA3d2f62pvGXTyzVDtFlclsCAtf0JvzdhVaMzq1IfEv24QZPGkFnT/HIciCpzt20CZGr9qU1R5h5oziKJkOvEBKN1isdFeJkEWykjIRuejwuEYUZdNm1HVA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uBAQaCFez4wyc8Mxqtyurx/+Hzg+a6+xBYFZhYKOI=;
 b=fJ6bXNlEydPYnk3fN83xpRv9tNPrOnNZRv02sdFS3P0tpoD0RY1B9/g1qBwBcbTZSnxVLMPbiFiIhBk3+KFS0n+3B7V2GvKnR0qjB1XgwPP0BfUmYRND/mw24anXeqZh81ITEcbWKNZvJpHezKlMsA20YtSv6kl5IKnvKkvMWAU=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 09:57:34 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::24b2:3327:2142:b2f8]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::24b2:3327:2142:b2f8%3]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 09:57:34 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correctly clear GCEA error status
Thread-Topic: [PATCH] drm/amdgpu: Correctly clear GCEA error status
Thread-Index: AQHXUaNxUHQIWGHAhUeCICUJiKkcBar1h60g
Date: Wed, 26 May 2021 09:57:33 +0000
Message-ID: <BN9PR12MB5226EEB3DEAA53D6BE0DD433FB249@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210525202020.21280-1-mukul.joshi@amd.com>
In-Reply-To: <20210525202020.21280-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-26T09:57:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d8af18f2-8b6b-431d-be01-f5f7b4ad1e67;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4164b489-68bb-49be-d785-08d9202caf53
x-ms-traffictypediagnostic: BN9PR12MB5322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5322667C31335108D7A2D468FB249@BN9PR12MB5322.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:415;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFt6jqr/JL0H0vGjenQ89TKUETvyQx6Fz8gL5PLr9c7QEGezwugYJrKpADjZpHBSgKES58eIlPGGnCppQoSl6mV5pt8/f99MRD/ZVGNocheCbZPatx6d76rCrYPV21GXZE+JkW4tkup6vFO2dMmRPIzGFKX7DYLqZagINI7tduew/jMB5IQZ3BFojoNvQ4QXv6RzksH7+vZPv+Buww8qB0BjnabnpYSAhJC0p4bT8B3Pls6g1xQmKeuB1A4jfFZohxMGVt6xjcNqoCB3sMaME9xeSOKH5xZC6g09nHOUzcDSjLvK6XMiriMcyPFnUehTo+F4Fp1NDluovfHAIzIhCnVnJTV+9jyMK/Npml+hHQhUFK9EMBmMJ4NrOYDWLbndxBKkERvig8Xizplw6+M8jzhW3uhsWbDT973fdnxutF/HbH+ZmcaLXOsL6v3wFYiF/cGhpECREOOmPKOawAm4WADpKiUYDceOoSXgULskFo3XZk5OMZTg/Q0nspEozfr3+5zTCZnxedKC8Xkby1YRIXywKJMH5/5WOug9VQh/RlGDVLybt+vxAJJjERmmnrUVUf2OLNTpxaSqb1mhk/tYEYjFkVOlhT67dWaLsx5tdu0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(55016002)(122000001)(53546011)(66446008)(64756008)(6506007)(316002)(38100700002)(66556008)(66476007)(186003)(71200400001)(86362001)(478600001)(8936002)(54906003)(8676002)(4326008)(110136005)(9686003)(66946007)(76116006)(33656002)(7696005)(5660300002)(26005)(83380400001)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?URMm4+gV/aMGsM2Vbb5AvRebWOnLBOEAeHcUp/nqJA4bBZRU0m9t8L7IUclK?=
 =?us-ascii?Q?uEUYy+oUUNfGZH6faiiZOR4zRBvFX/YgnS+7N69i4WiHdbUGySmyc3lQaOiI?=
 =?us-ascii?Q?//wxyBcgYEeuMEwTnKk4c65vUwRzqgMj/YHahtqVq2MRtg6O5lRtweO7kr3y?=
 =?us-ascii?Q?leWySMzM9N4aApP9Fa7VErNTzdk2XDtjhQ7syxZa60y4DUvdWSvJSDDfYyFa?=
 =?us-ascii?Q?007J0y59Ie9VtVNLJrWiAIUwutAu69cT0X4Gcw6dKxDWwtVxOiidpIVMvTBz?=
 =?us-ascii?Q?dE4e8mtoDDFqBqqzX2zwuiqqHSQqzWt00anh1BMyfb7JWH9aH3M4XVoLU9id?=
 =?us-ascii?Q?9P2cJfFQ6shMkfxmBocimD14hrQyKl2zQlIZEIjWlLg4ZxLsPvp3u7ULMpVV?=
 =?us-ascii?Q?/+7lXdz4jFFzi2baEWjPUZP2/6a9IG4PzSWTUU9EaeiuPdMwSKFa4VJ+M73O?=
 =?us-ascii?Q?y00l/5jxmLD4owuzoS58fcuFxdDHYlJ24UhFpLoLFu7/dRDo6P+YlnZ/f/ev?=
 =?us-ascii?Q?FBHkcmKfCqcBWo62C+2fqiPiNcxlMMxJZQOjDmgAmtVUIAry3rBFw3tRzkbv?=
 =?us-ascii?Q?SbEFonKPbhkGxub247szVf3G1aLslLY5yDTUlR2eHs00/o/S8Zgsz94Acmqy?=
 =?us-ascii?Q?Lf3Xj1HuuGr6zdfIcgqEDQl5+Shph6aH3Ap1HVpZ6HdR8NoTiTWc0SGVoqaB?=
 =?us-ascii?Q?jo6AvsCX8TOMs3qjQLw7DTMT/737PnFmnZL5/PpEQMCPqQ/QnND6qhqI8e02?=
 =?us-ascii?Q?m+Wsv7+7tz+pCwa1/CoVwtCtH0cADH9JpmhEf+ndcHWVt3/ApRKQhfbha1IF?=
 =?us-ascii?Q?/BOE8CWcZKNEcbl59r1aL9fhjyZ2JrW0/jKR5qZq/3uQUTjtJu1SuHJ8n5Kb?=
 =?us-ascii?Q?ObfI6IoweZHSnpTElOYYRuhsER8kwiqWhAxsPUuTknNCHV/tCvJMcmOg9gh6?=
 =?us-ascii?Q?C3AnvTNHXQxHvpRBXozPrWl/q/8M2hgYoh73zZTCJ/84m4Mj85HtKs2NtgoW?=
 =?us-ascii?Q?TZPsUIb1YEtdGg2Jv6A4uWDCCkSqrV8na/nRJ1L156n1wKR57pL6yOAbjzQz?=
 =?us-ascii?Q?GqpiaIVXvUUdZgE+YpYrk7rUkVB6HQ9CRvHCujaAZUajkPnMdvrZlYB2+UTd?=
 =?us-ascii?Q?0epfgusfqLsMCQHuXtTxtnJLJKWVTy1m2aBK31Fxt5zLGskG60Pj0e6hz8vd?=
 =?us-ascii?Q?JwC5j7V9EaeNH2w1L2zKxHzB2z1Uzx63jHGT4z1hK3aN5rkWF4QaSkBVapkW?=
 =?us-ascii?Q?+Y0MtEtgjOfr+Hphf8bEFSC6iSlfgCkn258ALRgzkzZjUPwR2TUAaj3ymS5Z?=
 =?us-ascii?Q?Onv0AjnXg/qTU/ry/WqzeCxM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4164b489-68bb-49be-d785-08d9202caf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 09:57:34.1136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54oY/8/FwGEqVPueN/dUYvIz0z9/LQQXTr6WF3GIbjWn9h7RjDbsnAKFG46gDPPkmohaU1XWd0dX2md5JJb/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com> 
Sent: Wednesday, May 26, 2021 4:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Correctly clear GCEA error status

While clearing GCEA error status, do not clear the bits set by RAS TA.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 87ec96a18a5d..c0352dcc89be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1676,13 +1676,14 @@ static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
 	uint32_t i, j;
 	uint32_t value;
 
-	value = REG_SET_FIELD(0, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 0x1);
-
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
 		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
+			value = RREG32(SOC15_REG_ENTRY_OFFSET(
+				gfx_v9_4_2_ea_err_status_regs));
+			value = REG_SET_FIELD(value, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 
+0x1);
 			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), value);
 		}
 	}
@@ -1734,6 +1735,7 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
 			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
 				gfx_v9_4_2_ea_err_status_regs));
+
 			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) { @@ -1741,7 +1743,9 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 						j, reg_value);
 			}
 			/* clear after read */
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
+			reg_value = REG_SET_FIELD(reg_value, GCEA_ERR_STATUS,
+						  CLEAR_ERROR_STATUS, 0x1);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 
+reg_value);
 		}
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
