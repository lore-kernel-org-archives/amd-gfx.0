Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347BFC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 10:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C21110E3E4;
	Mon, 24 Jun 2024 10:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HffeTe2q";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F7D10E3E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 10:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BItBfZ8Ifu27sDoajLFHfIYnEuYmUugXOzMhGngoQnFhzaj+q83QK5piqeYfy14QN4CDFgPCBO7U4d+YQnNwpMMk7zaGSIpZwfN0ZPZ4hVXNeMRL31Dlb8ssbjUxzb4drAM4PZCztucXtemBa3cGk1Qosotav+vUDFb/uAVoceTYrgK9GR0QudFRkeSE86tFIyllN5pus6CObeAV4PwqrYVdtciJ21VD4jdqltlxJqwNbxMrfBUHaK/CjHUlVVAn3mo82HrBb0SQmlulj3t6B0jgRZ75pwSsBOeKn4Rfzi56lKVCLTn68cEw/pcuroAjJ4TuFduKtVH8BEGmbeGBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA/OSDu9ECTfRQeE0pI8XG6gwNbeRQMs8YHxn6OS8QI=;
 b=B0XxlsCTOTb5B2aKcIJ5c9i67sRA/W84RlV06MDioG1+HtEXlDyEKSnM0FyQw7fhzS+6BTdKI5N7t4Gyq8TZDyl1+E06BcWMv5aDlvkD3jVT2wRNCk4GM9vyJUdUYk0YWSEx6l10FRgu9Vm+zhTJ0j72kZjvhiYvJRYUCBz0qqkm0Wbqzob9HDuj0BKW0NjNUFzFJrePbTVzD3526QIH/VYUUdhsHIP+2SpNxKn22+Ol2RRQodlpSVMitkbSWeXUfjhKzdEDAUkQgC8WSVHjrxTgvSloZbTU0kWV7SxzzZ/1B8jl1XELR84v9Vkc8JGl62bI+fY9aXgqM+R5IeEDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA/OSDu9ECTfRQeE0pI8XG6gwNbeRQMs8YHxn6OS8QI=;
 b=HffeTe2qKmmpZZE+IIiwe37+5guGx+nqKovDWcj19nTLqAQ0QqBYU5TXgvFbMGmFKV9DgmNcxe0YiLcWG5hizGHCly3dwf3qdN4MLsGxyymTt65MH+XL7T7yNvlNb85ixFWLcvMxWc5K3xgSsI5VZkRSUl9GS3AtBfLhXhg6TPU=
Received: from SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:16:17 +0000
Received: from SJ1PR12MB6316.namprd12.prod.outlook.com
 ([fe80::655b:63e9:1a28:ae65]) by SJ1PR12MB6316.namprd12.prod.outlook.com
 ([fe80::655b:63e9:1a28:ae65%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:16:17 +0000
From: "Slivka, Danijel" <Danijel.Slivka@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Prica,
 Nikola" <Nikola.Prica@amd.com>
Subject: RE: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit if detected when
 enabling interrupts
Thread-Topic: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit if detected when
 enabling interrupts
Thread-Index: AQHaxgK8ZeXQZeBJjU+uJ5FNSQI2aLHWpokAgAAL0QA=
Date: Mon, 24 Jun 2024 10:16:17 +0000
Message-ID: <SJ1PR12MB6316C3488A33D8501D52C94698D42@SJ1PR12MB6316.namprd12.prod.outlook.com>
References: <20240624065854.17711-1-danijel.slivka@amd.com>
 <29f9f8f1-5fb0-43d1-89f4-744682e852fd@gmail.com>
In-Reply-To: <29f9f8f1-5fb0-43d1-89f4-744682e852fd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=38f2e6ed-466d-45e2-96ad-e4d22294ebec;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-24T10:13:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6316:EE_|DM4PR12MB8558:EE_
x-ms-office365-filtering-correlation-id: a8edb9c6-8332-430e-21df-08dc9436af68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?aFY5Snl1eTNNQXdEVVdqUW5qaHJGMGEySVRLdlhxTGwwdmViSm96UHE5Qnln?=
 =?utf-8?B?ZG85aG1Tbmd0ZVo3cW1JV1AwbXJuS2lOdEFzWkkyLzNtVkhXd3RabmpyY0tw?=
 =?utf-8?B?MGVMcGZIQTBqNnZMRXdyeVZsN2xUZnBPUFZkSmlMb1IxTldBUCtWZWRqWS8x?=
 =?utf-8?B?b3VCZ1Q3bEN6MzlJeWJmVjkvNGk5czd0S1RVNTBOWTlZVjJyYkZEc3d2Z3hL?=
 =?utf-8?B?Q1hnZlV5blVPVXhNMDZJRVMyaGJTZzhNRUFYWGIxYy90Nk9aaVdhSmVtdzBx?=
 =?utf-8?B?eU85TWF6S0ZFYVlmcDVVdnlyV3lrT0VkZTN0OXppOWlLSE0vR1FEV2U1UnVM?=
 =?utf-8?B?YWlLRDYycE1qV290UHNsUTNzYzI5SEVCMWt3MFZPY1VPVXd4ZVdPWmwwVEdk?=
 =?utf-8?B?QStqMFFBVVRwOVB3alJ5VFZ4Mk0wN2Y5Ujd2SG1TU0ViaTkreFlTb0RQbmZt?=
 =?utf-8?B?ZHRrU1J3eGRJQWhpWnZ2NTFlRi96WWNYOWl0a0wwWTRZbEkrNnJGajFSbndm?=
 =?utf-8?B?QXBHNjRkZzVXRFpxSXJsMW82TnNZLzRlZ0VueTNhYXpsQjJOZzZtU2pXanBG?=
 =?utf-8?B?N2c2M0M1cys0NnJSNExvY0V2aFlRLzlWdUVyRVJucTRIRFg5d1Q5NVZIWGpM?=
 =?utf-8?B?Wm8xZUFoa0JHTUltMFA0VTdGT1M3VGR3NUwrd2NzMmw2L3B6NDdQK1p5aFJm?=
 =?utf-8?B?MTR2UFpMY2tMWFRkS0pFUGVhY0V4RExzc2t2ZmovaGtSaFdlM0ozQ09yc2FZ?=
 =?utf-8?B?azNoN1doVFlFbjgzL1o0SUF4Vnhlc2wwUGJhMW15T0dMeHVzNU4xMC93bVox?=
 =?utf-8?B?Vms1OU8zNlJKUHBTWU1BdGFPOE5vNHZPSTUvVTJhWW9xY3ltK0hXOVhnTmJu?=
 =?utf-8?B?dXJsV2R5ei9Ua2ZCMVdQSzRqYUU3QUYvUERERE1udVdNVFlIejUySGNaOE1H?=
 =?utf-8?B?SFQxOFp6dDNpcTBPVklzQlRXcm1GMUQ5cDhCbVVBVERtVFllY0VMd1MvSnd1?=
 =?utf-8?B?bUVTSGNQTVZrK0h4Q0VhT1JtN2NIRktJUjJqbHluTk5UMWZxeFVyQWlhV2da?=
 =?utf-8?B?SDVkMTh0NW5CbDl4MHJYTll3N3JZbTRNaDREelhjNE40Q0wvN05ENnpKN2NG?=
 =?utf-8?B?UVhSTjR6Smx5eGVKSUN3dkxNM2lIOUZJYklPYy82cmdrTzhjeFBYbFRYMi9E?=
 =?utf-8?B?VDROQ2tBU1luT1NZdG5mZTlUVWxWa1BFSlJzc0N3Sjg2WEgrZkIwUnp5SnRy?=
 =?utf-8?B?aUVuY25LOVI2eFpGdWdCNzB2TzVJMEYyS3BkT3BYNHRDc3VqREYxTnlpTEtq?=
 =?utf-8?B?TGovYTM3a1d1SG9oVVFhZnRSNUlQQ3cwVlRPajYwMmFGWnMzc2FQTmhJTTBO?=
 =?utf-8?B?eGJiZVp1YkdYVm5GM2x5cEk4UU9XM2E0MGRhMHRRb09sTittSnhLVUQ0S1Qx?=
 =?utf-8?B?S0JyOU9VVkcvQVhqWXJPcUhnVDNxek84RlpXZEFTc1FLNlorcDNtOTJ0UERs?=
 =?utf-8?B?THAwcnVETC91TEZ1cUtoOFZMTzdJcXAwS2VyYXB3Tkp5aEExUGk5Z1A4Sm9L?=
 =?utf-8?B?WG92Q2p2WTlDVm4yb1JuQjJLR0xBaHYxcW04MXdGOUJ3SXAyYktxMkYzbk54?=
 =?utf-8?B?WFlKWDg5OWs3MUxNVS9La1hyZTlZRHpsN1hvS1ZQV1dQN1k1V1FTdXM2TWVl?=
 =?utf-8?B?QlRxRFltMzRvR2tkeFBhalVwWm9XWkR6NzczeDNUaXNqK1FkUStqNnlkZnFJ?=
 =?utf-8?B?ZE5tdmoyZjNNUmFlenZuWDV0V3Y0ODNsMnA3V2FXVFJxUnJIRW9uN2RHbWU1?=
 =?utf-8?Q?RotdnZlf1lXuQcsbKW6m+Z9sou3SZKun60TKc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6316.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkt2Ym1XZ0NIMGxHVmxtazhrTmxac2pVQmloZ3NuRzZ5WkdYNXc5bHdKYXB2?=
 =?utf-8?B?eG95U3pBL3EzSzdNZ0VXM0djcUNkNjFmcmtYY3Z5Yjk5STFNcUg3SEJIN3p6?=
 =?utf-8?B?U2FQa3Fmd1doVEJpTDVEbUwyZndtZzFTVUptNUxDa2oxbVp3aTQzbG5sdnBC?=
 =?utf-8?B?TnpGOVVLTndLZ0UxVm1RU1dGSGk2NXlCNXROMk0yeWw2Q21CVHdKSitKKzF1?=
 =?utf-8?B?RGg4dC9kT1B4TGNsQTd1cWQ2NW1CdTRDQjNvWTlBQTZjNHFCTFFFdG1oVzdp?=
 =?utf-8?B?WUgxSVBCWkgwSm9wdE84czgxL1pDamxnSk1BbHJ5ZG5RczNpdEg0ci9iZ05x?=
 =?utf-8?B?cE1hNEdySzc4c2ptQjk5VDlKb1JPYjZQTjA5dWhTNk5HSzlTRjlBMmk0eE1o?=
 =?utf-8?B?WTUxQ0l0UFlsc0w0bHdneGNqUUlTdGhRRzFJV3cwNEg5ZzFUU0U4NHl3QkRY?=
 =?utf-8?B?bXNwc1pMM1UyRnZBL0RSNWd5MlpENElKcTBKOG5qY25CYlVsVHlidUtaMHV3?=
 =?utf-8?B?S3FScGFOc29NYjNpRTEzT3VJaXhtSzg0WE5mNkFDdWx1MCtGa3hZUU1QYUdG?=
 =?utf-8?B?TWdVNXBvZzA1UTZqR2V4REZhZVVYVzZiRklYTGVkMk8rS1JLTGRMVE1jNVJF?=
 =?utf-8?B?RHdJSWh4ZE5BTlNYQ1l1TmVDMHlUV3hjR3RMa1ZSZ3MvTTdlVVdYVFpURDNs?=
 =?utf-8?B?ZFZpL1MyaTVPcElzRVFXYnRjK3JWeWs1M2tiaEVtN2t0RVM2YVlLeDloZHBI?=
 =?utf-8?B?aGQ1bWUrVCtxaHI1eFQzbVlDWkd5TjZOVzcwM1NqQytCY2RhSnpjbU44bHRm?=
 =?utf-8?B?MmVGdit1Qm9Md2RVZ0srcFc1dXNQWG14UGFwSVBvZzkrN1NjdzA2TEFoYW9I?=
 =?utf-8?B?aWwxQm1MaDZCU1NHUGV2SHhvWkRib0NHS1R3WFBLVHlGNWVOQXJrdkdrS0Iw?=
 =?utf-8?B?THNrdW1OcFhrZVBjSVRHNGF6R2RKcGxZT0N6T3M5Q2pyVHNEK0c1K3JjNnZE?=
 =?utf-8?B?N0NBUm9YWGVac3VsV201WE1SVStUNEVIYlRGRG1JK3NqT1hyT3BpNWxvYzg0?=
 =?utf-8?B?T1JrdmVFY2NPeHB3UDlVWFQwaS8xT2NRazcvMWdUWko5ZDFNeW5Lc3JDQk90?=
 =?utf-8?B?TVE5Z2VjaHBJSU12YXBZSkh4MjNUNXlsdms2aWlFVVdHbjNsZGt6MjhnbGNj?=
 =?utf-8?B?VytGK2FOTEIwamZTOVR5dlh3ZWZBNi9ybW9oQlFJYmI5UXIxeGRhTEhEd1Fr?=
 =?utf-8?B?ZFVkY3EyaEtuMW5LbktUaGVCNWtlOSszd0ZBRmdyKzh3NHVPQlFneFhzU3pk?=
 =?utf-8?B?UndoUkFGOVA0Mkl3c253K3NLWFk1ckxPeGRtNk1POU1PZ0Jpa2YwcUpoaFdO?=
 =?utf-8?B?V2R3Q0lkUUQyYlNxZlA2YkhCTGwvWTU2SEF0L1VSN1dDY1NjWU5oekpCU0Vs?=
 =?utf-8?B?aW9Lb1RuTmRoMWRzY1pYQmR2b05nb1ZQcFhlNkhTaWJxbkRYaVJ0eFBLb1py?=
 =?utf-8?B?STAxekM0QUFPNjdyWi9wWlpRMVlwOFBVM3ZJWktFS2pMZVZVY0d2UGVJTFp3?=
 =?utf-8?B?RzhEYTlsR1A2SXdoczJkMmNOWklKcXhIbGEzTGh5bE1BVmh0YktxNXNkWEN2?=
 =?utf-8?B?WTJtV3U4L3ZvSEFpMDBDVEZlQ2kwV3JKbWtrV0V2eG9DQlRDajFBODlGL2Ry?=
 =?utf-8?B?ZzNqN1VtczFBRmhPdkg3TDNzQ2d0THorWCtRKzJ3WFpqR1V4dlFKdU9YWVpD?=
 =?utf-8?B?cHd2TFZSUmpsZjhCSEJaenJvK3Joa2ozTXpoNSt3enVZSmdxR3lQNDM5SmJa?=
 =?utf-8?B?a3hadGhNbUUxa0hiazFtZzhFSkhNbEhBNG5uSVRDMjRtVFdTMndENlV6Ym9u?=
 =?utf-8?B?ZC81cjZYYXd0Tkl4d0s5T1dnam5uWHZrb2xBSGdjS0xwK2hCWEZQMzc1a0xq?=
 =?utf-8?B?OGRBRkxyWWl1RFNqTGxqbUdNNjNsTTBEc3JXZit3QUdyU3RsQm1qSlRnT05D?=
 =?utf-8?B?dG5wNXpQUTh1NElETSthdk52emNIdzltRmNZR1VmU3N0N2txV0w4S1FHWkdK?=
 =?utf-8?B?aC9BMWx5YllxaWNHY1U5RWhydUZCdVk5d2VPUVhxSDRVQWUrNklUNURnd1FF?=
 =?utf-8?Q?Y3YE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6316.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8edb9c6-8332-430e-21df-08dc9436af68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 10:16:17.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzcmQaLtXI1+6IYK2xr1fXX5nO4nnYnWX1fOIsjTKQkFi6RILkceTIJyR5YrzomZTeDp537+fi2TAARuL7gn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+U2VudDogTW9uZGF5LCBKdW5lIDI0
LCAyMDI0IDExOjMxIEFNDQo+VG86IFNsaXZrYSwgRGFuaWplbCA8RGFuaWplbC5TbGl2a2FAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPlByaWNhLCBOaWtvbGEgPE5p
a29sYS5QcmljYUBhbWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGNs
ZWFyIFJCX09WRVJGTE9XIGJpdCBpZiBkZXRlY3RlZCB3aGVuDQo+ZW5hYmxpbmcgaW50ZXJydXB0
cw0KPg0KPkFtIDI0LjA2LjI0IHVtIDA4OjU4IHNjaHJpZWIgRGFuaWplbCBTbGl2a2E6DQo+PiBX
aHk6DQo+PiBTZXR0aW5nIElIX1JCX1dQVFIgcmVnaXN0ZXIgdG8gMCB3aWxsIG5vdCBjbGVhciB0
aGUgUkJfT1ZFUkZMT1cgYml0IGlmDQo+PiBSQl9FTkFCTEUgaXMgbm90IHNldC4NCj4+DQo+PiBI
b3cgdG8gZml4Og0KPj4gU2V0IFdQVFJfT1ZFUkZMT1dfQ0xFQVIgYml0IGFmdGVyIFJCX0VOQUJM
RSBiaXQgaXMgc2V0Lg0KPj4gVGhlIFJCX0VOQUJMRSBiaXQgaXMgcmVxdWlyZWQgdG8gYmUgc2V0
LCB0b2dldGhlciB3aXRoDQo+PiBXUFRSX09WRVJGTE9XX0VOQUJMRSBiaXQgc28gdGhhdCBzZXR0
aW5nIFdQVFJfT1ZFUkZMT1dfQ0xFQVIgYml0DQo+d291bGQNCj4+IGNsZWFyIHRoZSBSQl9PVkVS
RkxPVy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pamVsIFNsaXZrYSA8ZGFuaWplbC5zbGl2
a2FAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9paF92
Nl8wLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9paF92Nl8wLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZf
MC5jDQo+PiBpbmRleCAzY2I2NGM4ZjcxNzUuLjQ0ODcyYThjZTZhMiAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2loX3Y2XzAuYw0KPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvaWhfdjZfMC5jDQo+PiBAQCAtMTM1LDYgKzEzNSwyOSBAQCBzdGF0
aWMgaW50IGloX3Y2XzBfdG9nZ2xlX3JpbmdfaW50ZXJydXB0cyhzdHJ1Y3QNCj4+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+Pg0KPj4gICAgICB0bXAgPSBSUkVHMzIoaWhfcmVncy0+aWhfcmJfY250
bCk7DQo+PiAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9SQl9DTlRMLCBSQl9FTkFC
TEUsIChlbmFibGUgPyAxIDogMCkpOw0KPj4gKw0KPj4gKyAgICBpZiAoZW5hYmxlICYmIFJFR19H
RVRfRklFTEQoUlJFRzMyX05PX0tJUShpaF9yZWdzLT5paF9yYl93cHRyKSwNCj4+ICtJSF9SQl9X
UFRSLCBSQl9PVkVSRkxPVykpIHsNCj4NCj5QbGVhc2UgY29tcGxldGVseSBkcm9wIHRoYXQgZXh0
cmEgcmVhZCBvZiB0aGUgV1BUUiBhbmQganVzdCBhbHdheXMgdHJ5IHRvIGNsZWFyDQo+dGhlIG92
ZXJmbG93IGJpdC4NCg0KRG9uZSBhbmQgY2hhbmdlZCB0aGUgY29tbWl0IG1lc3NhZ2UgYWNjb3Jk
aW5nbHkuIFNlbnQgb3V0IG5ldyBwYXRjaC4NCj4NCj4+ICsgICAgICAgICAgICAvKiBDbGVhciBS
Ql9PVkVSRkxPVyBiaXQgaWYgZGV0ZWN0ZWQgKi8NCj4+ICsgICAgICAgICAgICB0bXAgPSBSRUdf
U0VUX0ZJRUxEKHRtcCwgSUhfUkJfQ05UTCwNCj5XUFRSX09WRVJGTE9XX0NMRUFSLCAxKTsNCj4N
Cj5JIHRoaW5rIHdlIHNob3VsZCBoYXZlIGEgc2VxdWVuY2Ugd2hpY2ggd3JpdGVzIDAsIHRoZW4g
MSBhbmQgdGhlbiAwIGFnYWluLg0KPg0KDQpEb25lLg0KDQo+QXBhcnQgZnJvbSB0aGF0IGxvb2tz
IGdvb2QgdG8gbWUuDQo+DQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQo+DQo+PiArICAgICAgICAg
ICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJg0KPmFtZGdwdV9zcmlvdl9yZWdfaW5kaXJl
Y3RfaWgoYWRldikpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgIGlmIChwc3BfcmVnX3Byb2dy
YW0oJmFkZXYtPnBzcCwgaWhfcmVncy0+cHNwX3JlZ19pZCwNCj50bXApKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVUSU1FRE9VVDsNCj4+ICsgICAgICAgICAgICB9
IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICAgICAgICAgV1JFRzMyX05PX0tJUShpaF9yZWdzLT5p
aF9yYl9jbnRsLCB0bXApOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICAg
ICAvKiBVbnNldCB0aGUgQ0xFQVJfT1ZFUkZMT1cgYml0IGltbWVkaWF0ZWx5IHNvIG5ldw0KPm92
ZXJmbG93cw0KPj4gKyAgICAgICAgICAgICAqIGNhbiBiZSBkZXRlY3RlZC4NCj4+ICsgICAgICAg
ICAgICAgKi8NCj4+ICsgICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkJf
Q05UTCwNCj5XUFRSX09WRVJGTE9XX0NMRUFSLCAwKTsNCj4+ICsgICAgICAgICAgICBpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpICYmDQo+YW1kZ3B1X3NyaW92X3JlZ19pbmRpcmVjdF9paChhZGV2
KSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+
cHNwLCBpaF9yZWdzLT5wc3BfcmVnX2lkLA0KPnRtcCkpDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRVRJTUVET1VUOw0KPj4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+
PiArICAgICAgICAgICAgICAgICAgICBXUkVHMzJfTk9fS0lRKGloX3JlZ3MtPmloX3JiX2NudGws
IHRtcCk7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgIC8qIGVu
YWJsZV9pbnRyIGZpZWxkIGlzIG9ubHkgdmFsaWQgaW4gcmluZzAgKi8NCj4+ICAgICAgaWYgKGlo
ID09ICZhZGV2LT5pcnEuaWgpDQo+PiAgICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0
bXAsIElIX1JCX0NOVEwsIEVOQUJMRV9JTlRSLCAoZW5hYmxlDQo+PyAxIDoNCj4+IDApKTsNCg0K
QlIsDQpEYW5pamVsIFNsaXZrYQ0KDQoNCg==
