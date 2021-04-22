Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B88C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4ED46144A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ED46144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF2D6EAA0;
	Thu, 22 Apr 2021 14:12:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B3D6EAA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 14:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLMUY3EMzGZ9grnkLX6g3jELsx4qb++ItcmZH1/YOklTCJBQz8nSYz4W9rsrDmXuMuSu2Sfncc4fs+krQtgc3HS0d1zFYeYbHakGy/NbTUCe/77wkdE8uj4NkUWQdACcHxgmkc+Ry8MNFDGYhJVMCkg1RT7BGLLauPLJbempcbB5xyeTNSrL1OT+8Ja14PykpDkTocRFUxjq8LXgtBaohDteZvCHPRsRsOWivJPAx/US/8lsyV2nKknhmOYviW8NzE58EZ9fu1sL8Gn8HmrBTJquPQshUMp6ywyFRea5/tgv6Et9WZAN3YVPwcoeeMsdGchkY5vJ3JsjWS4BYCVURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOYZr06udNZosq/gCG3hBNt1zMUaOgsWeiwhkyj6SgU=;
 b=LrNJeNkJqOb0Hex9zdCYUdJ/kScY8MtXx7fQeeioKWw/hy1vEMgw0xNcf5jA+XrkjuhmAQLwPPfQLLrPE6q302kNUniIxycMQ1v8VNuX+XRfY4kV8grkPSGyheP7pbAGqSB7oNBeoy5mYlAmNf55AakDoDiz45J2tn5uGRQKRTyWQlEbwnzapyYL6k+cYs/tcLODpmTjuZXGA2yDZvqvZ7QPBKw2ueyIw09/dUmZp9sQxHE2HLvY7DC6DZtBRNOwil+j0oTjR5gRNOUWcKcZTQEH+F1wTaZtQG6/KSFbU8eddDOFfG1CRfpNkYVi0duO1EJylVApv4lVTclw66UldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOYZr06udNZosq/gCG3hBNt1zMUaOgsWeiwhkyj6SgU=;
 b=xVeHzWnjAKffZbL/SmLUb798ZHrMcF7HJty4MjCrTPnHmzKv/v2vhldNKedovkK3DFEkAWRcScl72s67ngS4BjqldxCpEZD6LeyrxjUWht6y4YwDAX2rn0u/W9gDEnNloeROjg34TqGYeIR0a8Rcv7Qmi4OMr0onkdzaa5sooD4=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Thu, 22 Apr 2021 14:12:09 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::155a:2920:d3ab:e18a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::155a:2920:d3ab:e18a%7]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 14:12:09 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable gfx ras by default in aldebaran
Thread-Topic: [PATCH] drm/amdgpu: disable gfx ras by default in aldebaran
Thread-Index: AQHXN4CvAJqtFB2JSk+iYeb4txdV4KrAk6rw
Date: Thu, 22 Apr 2021 14:12:09 +0000
Message-ID: <DM5PR12MB2533231A6CF6D04DD83A589AED469@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210422140622.15260-1-Hawking.Zhang@amd.com>
In-Reply-To: <20210422140622.15260-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-22T14:12:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1bbef46b-644f-4a7d-b68d-1ba0bf185129;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:388:845b:1100:d8b5:3891:486c:ac46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9752c05d-121b-41e3-40e7-08d905989e17
x-ms-traffictypediagnostic: DM6PR12MB4331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4331E64C11A5048016C45A56ED469@DM6PR12MB4331.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ld6ZcxzM1aOotm8TUF+UiadBbY6R9CFKwW3/ROUYlv15bHqPGHWfXXqIJnvlCCt63gWZL0NEZpqMrm4XNCqktLVzfZaMAVUpRzIhXB9th9D/pqLQxgrrZfC61ijEn4G9bwwCFiYMHLkCa23k6hLZAJQIDy9azCWblnOWj3uw7M/3IijptOTFT0VwpnX5Ct5/N+s9AXDm3STOjOPsG5BSujh7oLjL9BK06hmfzn03bGD/MJe+dEha/dC/qxUkNQ6Wc/za8/p+iQkJGvbdfnzV/iJDH4Tewbkt3NxW5PBIK0vbqnRVcYLeaFEJXK0pNqQOraVMqg+bpius5el45f2lsxZfuNBkJg6rQXeJaJknLk8DLWHANH4Bgfwg5nBgrd3xDT9trz4ZrlVmn8FoTpUpHVpEH7wZ7bckt/xbxVMWv1hHWf2ItwSf/ZYVdVJtMWljAHKsjqgcw1KGhGXhwQsQrhhKy0TJvypkbWaIdq3nWpatL8eZRHmkfpHIFTa1SNGMDhmnxVOtheamtRHEq1aMRU5TVB8arJIE3wLyw2wPKRJnkLXK5bLov5fVfL2q+hFtPjcbyq4n8dUqpDFufo8N7BBYYGZHCDHwAolZsBtDxmI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(76116006)(122000001)(38100700002)(478600001)(64756008)(66946007)(4326008)(110136005)(66446008)(66556008)(53546011)(186003)(6506007)(8936002)(8676002)(7696005)(86362001)(9686003)(66476007)(55016002)(52536014)(71200400001)(316002)(33656002)(2906002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ekRqNHJ3QWFIRUNYUFYvMzZ0UzdoUkU1dGkzNHR3ZmR3VFBRMFNvUzRDeTNy?=
 =?utf-8?B?LzhmUzI5WkpDY1VPTzN6bXozRHNuZzZZSVBTZVowcVBHZ2liQzNOUlRpVW1L?=
 =?utf-8?B?Um1OTnN0dUg4QTFQbjJTb09SYXZKc1BNR2tyTDFZSDg4N3QxT2pBSUloQ3hq?=
 =?utf-8?B?Vit4WkpzaVphYVh2LzY5UVpSSkxSV2RXVHZoSUlkVThPOUkvZWZCaHFFN1E0?=
 =?utf-8?B?a2lMZ29BRWdOSUJ0bE5qK2FOM3VJYTlzNFZhS3pJV3hSREFCRmdETy8vZ05L?=
 =?utf-8?B?Y0U3NUJJenFwN3hmTWdUMHFnZjJIOGxYT0tvNXhWbTlEVWNJZ3ZrV1RteGVN?=
 =?utf-8?B?aC84Zi9rUVRvYmxFUSt0YWRYazlTa01KelRYeFdiZUQwUExGR3hjeVcvK3Ex?=
 =?utf-8?B?c2pYdXJscDVZbGEyUUZFOGs4VXZ2TW0vbDVyREFVb296dzBXM1gyeURxSU5Z?=
 =?utf-8?B?aWgvVDVlU3NsUlYraHNGc2FsSENCdlpxUTlwbm0wYlJTRVBraDdETkxSUzNI?=
 =?utf-8?B?Y05qYnpNN3Z4bzBZaU9TaG1aWnhGRE9DV2k2MSswbVBhelI3eGhuNVpVS2dq?=
 =?utf-8?B?cm84bWlmK0tjZFdhdjB2RHZQWXZkbzJqYnBJS2RVRmV0cU14MHEvelFzL29P?=
 =?utf-8?B?d0F3cDhYMTM1T3ZjNHVmbW9yTTU5aEU2UDJUZlNNTUpKRGovRXU3M251TGZh?=
 =?utf-8?B?WFBHSFVncU1tZE1wSEdNNHFibDkzRDhJdzRqTjRwUDVrVk0xcHFsMnQwRnNE?=
 =?utf-8?B?QUlSdjZySDBGSUppSHlkTk5nMTkwbkNRRVhsdDA1QkI0cWdXM20wenVMVTcz?=
 =?utf-8?B?ZmdURGxhRGp4UWFveWNZQjl4eTV1Y1E3cTV5U0lLNm9MVmx0VkR0OEtuUUs0?=
 =?utf-8?B?bzVRWEp4QU5abVc0RmN4L2NrT3ZSNG9BM3UzN2VmSXpHdFR2WnlUVWNQcG5Q?=
 =?utf-8?B?Zmh3ekszdEpuR2tZTmxYWDlHN2xUaThiMkg2WkM5RytaakFaUUFzaGpLemly?=
 =?utf-8?B?SnZ3Q1lQcWtaMlRDSElNRGp3dWx4dDNkejd2Mlk1MGYzWW5JVVhrOTRERU9X?=
 =?utf-8?B?Qi90RGpHYVJYZXpuQkNzMWhQaXRrdWNMek5xT0JTMUFNM3Z6Q0wzSVpidGE2?=
 =?utf-8?B?czVvQSthVVA4OEhNem9JQ25ocDcrQjlidCs4ZTZiZmFVWmxqYlY1QURaM05j?=
 =?utf-8?B?WFpsT2ZvVVIvNDR4RGszUU5nNk93QzZvNjZyQ1N1YU9VMU1leUVXWTJmOCs3?=
 =?utf-8?B?ekZ1ekxEN3VkdXJyMFhtb25SZElVZk9zWGg5R1U1MktFSVkrN29hU2lEWDRR?=
 =?utf-8?B?WGdPSXQ2ZXZXaXliSldNVTROQmFXNmJXMmMxdG1nbXFyMkNydG9iZzBMNlY4?=
 =?utf-8?B?UUhPM01jb1FmdlJxeDU1TFMxeXR3L0owUzh5RFQzZTY4aE15NHk5VU1vSnlz?=
 =?utf-8?B?TzVPblhjaFdXeG9NOGF0dU9KQkFtbTUweG5WbXQxaHF3RWtaYnlKSU5vOUhw?=
 =?utf-8?B?L2YzQUdrc205TEsycGQ5ZzgxWFc4RytJN3BCZGRBVHBlN09JbmNLU0pnT3k1?=
 =?utf-8?B?NngrUUEvbENkcEJHRGlNemU5RWlHN2NKbG1XRzBGaTBNQTlOb1BQaDZpeFU4?=
 =?utf-8?B?bEF0VGJ4OCszRHZobEl6UXRMQ09nTjZXWWlTRjByQVpWbzdSM05qOWMvbDdr?=
 =?utf-8?B?OS8yN0prNTZKK3ppZEpOeUZSaVdXY2xKQ1JhRGs5OC9XNlZwZ3QxUTlvZUFv?=
 =?utf-8?B?MTJsNjRiWnVTY2NzR3ByNFRPTU14YUxxQ1NkZ2x5ZFRoVzRXUTliVEJjMGFC?=
 =?utf-8?B?eVNBRXBWMTBQWWVtV3UzYkhhTHZoZVFyVnlNTnhBUHBodzIrcDlJT2JrL3lj?=
 =?utf-8?Q?OasDCMVu5jm8o?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9752c05d-121b-41e3-40e7-08d905989e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 14:12:09.3318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OP0d0944teGW5ZlvGkFL9U8P1zDbsZuTypSqdoUXWRxtlhLgbXBFxR8y/S5Y7R6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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

Looks good to me.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

Best  Regards
Dennis Li
-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 22, 2021 10:06 PM
To: amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfx ras by default in aldebaran

aldebaran gfx ras is still under development

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bb0d027..f62873f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,8 +2066,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
-		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
-				1 << AMDGPU_RAS_BLOCK__SDMA |
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__SDMA |
 				1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
