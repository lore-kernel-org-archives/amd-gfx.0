Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F3CC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF956115B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF956115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78966EDAC;
	Thu, 29 Apr 2021 08:31:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453D06EDAC
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d38lb5G8mmY2cf4IokXMGKnA2T5MCBaPWBZPy3U+Vh1K6Coycca1HCEe/+39o75wwc2o4pUr8+WGsQF9NDkC0XeP/O/fRfYr+ub56B6vEmWSKbXA4aPTkPQ8yaIA7oM2Jgx5M6apa07eCQMSaXGC5/oeDjTKfPkM1FvWuJHZZiR19iHwv8gK7U2cJxjLey37Oon93e+tTFgwP0FDW9ny/Prlw9vLdQUqgJrsgw9L+ZkbUrWjostTVdYHXqruT31EOrdm+J68GsZ8Q9D99DqO1H5YfVw446ed/EI/m6Ny3GjmrfXlwmpxOsylB6ukzPuo8M4+x1P/WwYeXjo1lZi5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQSVCQKbhhPBxsP97kBRT4cLEdh/l4Nqvo/DGABRkkg=;
 b=LtX5xj5nLGprHaDlEyx5MWCDTxLGR/tZ+W2nUu/Y47t7qI85JHlkmeaW/1Hafa5hyEO8sgD1JyiTkMOGvabdVpRQvWhmD/btHIyLTsH6+mD1ShZp2J0pJmQa1RU1EE2skXiypHKpklF1DB38Bw7I0sjiBKjXOp0PpqN53sf+2Hrg1zwlEBBUCMiiR1lkeDYkmWZMFq0S5TDu6YnSVH4g2bKj4RCSS2sjTm6Fz1+5rvHprdP9ZStVPzUybt7FgCmcVD0fVXzV22FBJGTx4QdCTkEt0ulJ7fe9AsdyYWUPdnc2/qnbIRuTVuuRxUA0nvbuHRtQOI1n/5LFImmeN11u/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQSVCQKbhhPBxsP97kBRT4cLEdh/l4Nqvo/DGABRkkg=;
 b=2aKx7tbnK6FvIbtts4KfbZzmNBTGOJ6WCfkVnaWf+omBGRKFIUkivl3ZfJt2R2q88CbZpI5t0XXgaEYpMBCsPdmpM90sLneAa5/h6d9n6x3WDjmZo28xdH6juFSWo6zzDxTX2MKmn/wTithVMiirg3eEMlemwpphv/czo6QQ/vI=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 08:31:10 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:31:10 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/7] drm/amdgpu: init/fini hdp v4_0 ras
Thread-Topic: [PATCH 5/7] drm/amdgpu: init/fini hdp v4_0 ras
Thread-Index: AQHXPMCLZMMPVIGhFk2xK2Bn9RiGSarLKnjg
Date: Thu, 29 Apr 2021 08:31:09 +0000
Message-ID: <BL1PR12MB5350F28BAB169BD2E7BDAE04ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-5-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-5-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:31:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=293bd053-ce8c-4948-a42c-149891c0bfb3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec80e83-74bd-4bba-1c29-08d90ae92432
x-ms-traffictypediagnostic: BL1PR12MB5223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52237DAFBE829E40BE87B13DED5F9@BL1PR12MB5223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kL/9aQ5SAUPf8WxrIrYOg+T4zV6ulx54cZ155T0NP2ux7rdxoYseqbEaRS+jjqyRMFHkIWH5TtnvIuZq2pv3IigBmpVzzAc2ZIBcKPptuXQORw0yH9beSeyQkU+G+jWeB6H5cpylS3Tvtu3dEW7+KK58Z70ZqxU9bU79x66VWc9TJHn40ZwRelDf9b1Bvbe5xHC3vNundK2EYrgCCZjjMGlBDeZ++ew5idpOVYgquKfd4mcp4Pmio148fjArWd1kRWplLM7o09LcJa2fQVR4igHPW18QbG0PoyP/3a4NA14HbvalpoRok6/PfewJxTwNW2R6VPclBbN5P+VBNw88ROeMj4SZ72SMsZ7/zY4TAvX988lYqzvxY7xefg/7HARqLiUSfvMFoNQdJq8p9o8mHBeh2Yiq9u/iCrcMaE4LvDvHQrIPmDJulM2fftnuCUpq8jtLkbiOdJ/sOh8dgDnUUU9h578knIn58rq7KWcUfbVt8p8ZSB8aV9k9lIjSjHABmEUm3IcRzBd03Hqfmwj0ZRggpepNsZ6ArUJVoa/Vr2ZKbEK7oaDOE+GW/KP7F+xZ6zwIkqaY5uvNziH5YR2+DiVAvNJOYdwA2np1V4qbcT8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(7696005)(86362001)(66946007)(66476007)(122000001)(186003)(9686003)(26005)(38100700002)(66556008)(478600001)(33656002)(53546011)(6506007)(64756008)(110136005)(316002)(5660300002)(55016002)(8676002)(66446008)(76116006)(4326008)(83380400001)(71200400001)(8936002)(52536014)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?blR6Kys3bHU1alVKTzN6S2NINUJCYVYwZitTRk5Ca0RpWmZjdnAvb2Viam1a?=
 =?utf-8?B?V3hJejlITzFzRGY4b094UHlIQ1NubG5VblFKeXNSaXJIZUlzeHlzQThLcTRj?=
 =?utf-8?B?cDBCWjJQamNTemtJV1FZUlBjekMxMU41VnZEcjNwU01XQnZ0Y0JLamg4bmts?=
 =?utf-8?B?L2lOUUs2RXA2N1J3eEVFWlo3eVRKSDBjZWhwRkZsaEhFbTcydGw3bnZ3Z2tK?=
 =?utf-8?B?bU1DTzdISUVOSWVKUzNXanQzUTFZaTA1MWUwdmMrYWZpeEtacWRCYnV6ZEJP?=
 =?utf-8?B?cm0rd0lVWUEvN3FTVUVlc1FNZmlYT2UzNmwyZGI0a3lPTTRuNnZmellTbk9n?=
 =?utf-8?B?N1FidWdEd1Z0Mkd5YnA5TkNtYm9rM1JUVHcveVpWU3dYNmZpdDRnVmVYQ1ZG?=
 =?utf-8?B?Y0VPTS90dlBiNXVtR3dONm5iaURKcHNEWFZxNXFTMnV5UVdDS0tjVkxmWHlu?=
 =?utf-8?B?dy9TdlJCcWIvU0xEeHhkcjJwSko3YU9CRnFEY1ZrQnZ1bFJqVExYNzBvVlov?=
 =?utf-8?B?L01PVVl0NWZQSXc5ZXpMN3ZLYXV1ZXFWMFVUdHhmbXZ6TmNFZDRYWTZoTklh?=
 =?utf-8?B?OWxkL1ovNnRRUzRTbUVMVm4vQzJmYWR5dmRFcGlIaSthUWZ1ZWFWcEVKa0ln?=
 =?utf-8?B?ZmZkVzFrVGwvd2UrbXZUT0cyY2JheTl2K0FISC9HSWdMNVUwaDRKekkrcXdx?=
 =?utf-8?B?bFpwMjczSGNCcVlJY0ZLcG5GQ2tVQldrQWRteGVVYnJscW9qUGxwMFZaamd2?=
 =?utf-8?B?azFmMUY4akFBN3pqTFh6L0Vpb2VaN1dobFdTMUJobDRwU25aV0ZuUmloRnBN?=
 =?utf-8?B?OStsOGQ3Y1BOeXRpRVBjUVdhOGpybDk3ZHU1QkNjaWlBZ3VEcVhiWkNQeTVa?=
 =?utf-8?B?MUJ5NXZSeGE0Zk9BUkhzWlNBbG5pam9Yb1dYc1llckFKZS9WbTJXTzd5QWdT?=
 =?utf-8?B?citYNVRaTFJNd2RwQkJvaG1FN2l3Vmo1V0piTEZ1NzZPQnZ5RXJEalEwamZs?=
 =?utf-8?B?UFpKSkdHaGFVU1RpaEJpWGFmZDRqRWh5V3dlMjdUYTZjTmZuUGxOeGpvMXU1?=
 =?utf-8?B?dG4zREduaUdhaW45TTVNMzByVUpIeVlxMFRqS00xa3lucmhFWnpVeGEzbGRq?=
 =?utf-8?B?bnZEYW1uNFZpVDhhZXpKR1c1UnFGNjh0aVFoMjRnMCs1NUNUYkNaQ1dOdFFk?=
 =?utf-8?B?OTBpNys3QktZNXJSeksyZmpxRXVBQklyRzRMUGEydVVQcmJ2MkhZbW5RcUk2?=
 =?utf-8?B?OGpMTnMwNEtzTWFTN09YZ2R1U1ZxUHNzZThOYjJYYTNUbWJvTjBPNStwbHI3?=
 =?utf-8?B?cjhsMzB5MGovcGJ4Q1NvaVA5L1dCM25KRmVTVjhiYUo5Ylg2WVdROUxZRzQw?=
 =?utf-8?B?aTlSaU9XWWFUUjFlZVllUm5pY3F5UWo3dEtWTDVPVUxuM0xTVXVKSW44S3hU?=
 =?utf-8?B?cTV0MW9OYkt3SE5FYjV0Z01PaDU5Z3Zxa3gxSzFsMUN2NVczQkVMOXJWRDhB?=
 =?utf-8?B?Um45Qkh6aFhNQndWSjdGanZDM3dySitHR3B1clorNFAySlhzU1Zmd3NuaXJa?=
 =?utf-8?B?WnNXdENjc1RDbHFiNDkxMTNHM1JRUFNFdXdoNkRuWHRBTXlNYzNlQWd1Q3Fw?=
 =?utf-8?B?Sy8yenZmREYxR28zN3o2WU1GOFVTK3B6YzM0NVVYMmU5MzRaV0VrR1dUeUc5?=
 =?utf-8?B?S0VHblppMVZOcGtvRzRMbUxoQmZhVmp2ZUxNOWUvbUhCUFdTOWFlcUkyQU9L?=
 =?utf-8?Q?dq6FU0d70lS83ppjBIUsNneZox43DgjqrTpq+Sh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec80e83-74bd-4bba-1c29-08d90ae92432
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:31:09.8526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO0uP5tOy7KEX/+HgKGcwrM3lEFjHCdLzHfzl6BeKN17+1dOPOenLKH96B+RppwT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Subject: [PATCH 5/7] drm/amdgpu: init/fini hdp v4_0 ras

invoke hdp v4_0 ras init in gmc late_init phase while ras fini in gmc sw_fini phase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index dfa67c2..697ab26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -455,6 +455,13 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+	if (adev->hdp.ras_funcs &&
+	    adev->hdp.ras_funcs->ras_late_init) {
+		r = adev->hdp.ras_funcs->ras_late_init(adev);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
@@ -471,6 +478,10 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ras_fini)
 		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
+
+	if (adev->hdp.ras_funcs &&
+	    adev->hdp.ras_funcs->ras_fini)
+		adev->hdp.ras_funcs->ras_fini(adev);
 }
 
 	/*
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
