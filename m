Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38177C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 07:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C376D10E287;
	Tue, 14 May 2024 07:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FnE9iWDV";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676D310E287
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 07:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhQyq7mW0lF9hm5z6AZslWkva1khIJDtAhvTU/pd1JZ/XHo7NGdy7GuFKZJ4V9/IWODkjquvq0sQVPN+iRUYymWzo9pIHwCis/mDrrb/pa2kgnXo08t7FH5Kn654yLebfFYV8/SFZZfhHmkqNw6zxZvM5TW5aJacaHuq1fU1hlIV5EUDn483kUvRWblGvs9F2L3bmktbJU+QXARbGGGmw3d7xqykTiMQ3aLlXXtD3scmM8Vi+93jky7KYW/hYYP93YI3wB8p5bnKwwfxxGv5IBdgC7r+rLbDZq8cWDpfqgVk1df1iUG6m67pdUbY4EQRIBLYGjTBnpV29bkR6I4DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fClUiJ01aFA4KpHdqqNTXn0Z6+/gnOSH1kkgLWy9Cjg=;
 b=M3UEULfjd9czt3dtamr//gpaYzze+L5z/R/4ouq45pou5R8bvctdYr9xlAXivD8DRs+H7S72US/49Q405nMMyer7rAaUUP0vkALXkB57oTJbVSwmFC/R5WXhl5uspAXjrc0IGF1Wq1/PLfB+2Y1+U3CD7Zv6VQJ5rhDzG6/Buyl58d4KSPYppTPX5z3Iani8Y11TQiuREVjVBp4Bq80mouGa8pScPRBCoQSbZbiVm+srgCWKlqk5Rl+EkIrMQc+VfI51REK3jR5uYKR/BI89AzUY3QWaViU6zqo1BTVWa6HlP4ZqwBbt1Ro0gIHfy3F1XbTMiARBhsQCMIQYoxhPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fClUiJ01aFA4KpHdqqNTXn0Z6+/gnOSH1kkgLWy9Cjg=;
 b=FnE9iWDVVcblgqd5M+pU7kk002YeNEsG9M6FEkb44/O12yZNPtdlRh8+2hSkX2HJqIXJpsD+KJLbSpR4recyxqfMFWWxkkDUczCZxcSEKUF6r8JDc9BFy1nJ8OXIM+2smqrH2krERJ/1ET+I6F86tB/SHUFNO9HNYsNaAYo+Ln8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:07:58 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:07:58 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
Thread-Topic: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
Thread-Index: AQHapcSutf79mn8kREmoPcrvRq5UNrGWPkeAgAAQPPA=
Date: Tue, 14 May 2024 07:07:58 +0000
Message-ID: <PH7PR12MB599748FF0209C8A3BD61F93582E32@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240514060451.3649916-1-jesse.zhang@amd.com>
 <649af63e-99e1-4653-b5d0-72938171a94c@amd.com>
In-Reply-To: <649af63e-99e1-4653-b5d0-72938171a94c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=944aefdf-2a6e-488a-a25f-b88bc1469c72;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T07:04:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB8722:EE_
x-ms-office365-filtering-correlation-id: 8b576aaa-cf15-4cd1-8e59-08dc73e4961e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?enVSOUx2ZlYxUXFRSjEyY1JzUTZyZnN6TU9DTGd5TkxPcysvalkrbFR4R25w?=
 =?utf-8?B?TTVLYWU0Q2hMekVVbVFMUWduU3dEd0lscE9SNG9nK2VwTkRtWkRWS0x6dTY2?=
 =?utf-8?B?ZmRlU2VxNlpUMVYwOGNMRXhoYVMvc05VS1Y2NzFMOFhlWGVmYzNIT1FqTEM1?=
 =?utf-8?B?SjBlZVFlcmZLZzVtNkxveWVieEYvZEpCZlo0ZXBLVGxXTTExUWJyVVNwRGlO?=
 =?utf-8?B?UklGWllIMzIzdEVncW12bndldGptelZYNXNyWFBPVjg5ejZXMHRHWHVDMzM3?=
 =?utf-8?B?NmdwNDBqWDk1QTMxN3N5YS9uL1JYTTdXSHNVQzRVVkgxT3ZnZ0JsN0tVSTNn?=
 =?utf-8?B?WVg0Z0ZRdkxNTldMTjkrT2lwTkJGd0tMQzdFUUxCZEY5QnlTQVd0VE9aTkV0?=
 =?utf-8?B?MktHWG9CTzk4OTJMVkUzZUIwblVZNWV0N01kaXJqWWJIQk01aFJGWGtPbE84?=
 =?utf-8?B?SlNHazZlREhCSEZ2Qk13K3ZGaExIQkl6bFNDUUtFMW1DSmFVUEptc0pTNU9u?=
 =?utf-8?B?RCtXNHRnOG1OVHp4aG5HOFJtKzRkSnc4aEFuYys3eTdXd0puc3QwUDFnOXpI?=
 =?utf-8?B?NHhwRHpOSnFwUGlRZ1c4ejhRQWlDK0R1SXRpejRGNFk2VmlXcm5jdHVEdWEv?=
 =?utf-8?B?aTErSTJNb0tyVTdhYlhvblFpc3Z4YnpPeHEvYTFROU1DeGIrOUkyc0JkdnQr?=
 =?utf-8?B?dTFBVUdkbExHb2E4T2FZRFV5TEhJeVZ2cEN4VFpmdjA3SVBkSytSc2dUVWpt?=
 =?utf-8?B?eVROYXBHcnVDRHpUWWFuM1F3UzM0cnhWTDZJVXQ1dWd5Z05IK2NrYVJSNGcz?=
 =?utf-8?B?VUpBbnZ3SkVMVjhuZDFrTTdISXFXcVNXTDVzVUc1ZUhkWlpYRHBnOXk1bzdJ?=
 =?utf-8?B?UkRrU3psWk45eW1WejZOVEMrVmpWc1FUZEU5TnFhNHdIV1VwMmJ2VFFZNXI0?=
 =?utf-8?B?d0N2enQwUTRSZE1Ba0pTdDlTL2UySk1GQ3JtNE5nejhsZ3JBa1JkV295U1Z6?=
 =?utf-8?B?Wm9WbE11NWxRMVhPVzlWZHJGR09sRkFCZ0JydzJFeEgxTjhxaTJYdVZNM0pP?=
 =?utf-8?B?SWs3OGtMVjVNemZEdm53QnM4dms4a2J4NURDb0pmYXEzODZsTDlpcFBGTFJj?=
 =?utf-8?B?bzhHNldiRWJRVVpzcGdDK2J1VnRNeHhDT0FyS0o4a09Xc0VrNUQ4ZDZiWllt?=
 =?utf-8?B?emZKL0pJanVJbDdIODM3Tzd0K1pDd3NtTnZxcUd0TVlqZUp0N2s3RGNtMDk5?=
 =?utf-8?B?a3lhdENMZSthSG9iQ0FOenlUUE5Gd1pQekFOSlh0SzY0UGZzSUlvMVdVcmhB?=
 =?utf-8?B?NnVvRVM0S0dyYjR5YVpXeTUvUytsd1pFV0xROUFQUGtNdjVaRFZtUHpBaXk5?=
 =?utf-8?B?dkVhM1lJR0ZGeWUveFFXOVA3SEt4dlIrSHhURHNNUDdJb1pDRDJSQnZZRHoz?=
 =?utf-8?B?d2xUSzhCSzEzYkNWakMwN1o4bEpxMW9FYWo2dzFnZjJYNjhEUVh0YjB2TUlI?=
 =?utf-8?B?WTZXVmdMTFZUUnlEOXFnM1hxWCttbVJ1bkgxdHd1RXU4aUhZZ2k3QWZ0UmFF?=
 =?utf-8?B?QVN5SWJRY0o4L3NleXpidWVDRDVGUFV4MVN0aUpmMGl2NHhZbWJ0ZHpWRTRv?=
 =?utf-8?B?cjllVFBTek9ObW42cVgwL3VEeG9NRFNZdEQyK2wxY3l1OVZibmRIcDlWQUY5?=
 =?utf-8?B?RDE0UnV3ZjczbUJzQ21SVStzaEEvdG41S0h1cnZjdlBIOHF1MURvRllNc0ZX?=
 =?utf-8?B?TjY3ZnhLWmttUVI1NnJvNEtBYlpkQkdZa0NRT2VFK3M2WEF4WnJMeWdPMzYr?=
 =?utf-8?B?YjN3eEFMa3NyUzFQNXVCdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXV0ZkxDQzVRN01TOHZuOEp5YUIvY3dVVzZlbXhsR0dhMzhqNHVzbVRpcFhD?=
 =?utf-8?B?a1o5UGNFODRZUm5HMDdGeForaHMzRHFRcHFGZTdUTGNjYXpKZ0E0bHIvb3E5?=
 =?utf-8?B?eGNNT2dPVzRGOVZzK3FoUXZ2STVpaUNUM1NGcUNCL3VSZk5OSWlKRUNORENx?=
 =?utf-8?B?WjNNeExDQnZBZElEZVpsemxBbHRucXNrOXAxdjZWdElxNzlJRTlscy95VE5X?=
 =?utf-8?B?NThTaXZoZVUvc1VSK01TMEtjTFBFb0trdTdIcEtobTQxamtwQlV0YkxhMVFo?=
 =?utf-8?B?MHYzRDByYnFPcU0xMW1YSmVoMDErLzBWT2NScEV2U3g2T2tXWUxvd0xINXM4?=
 =?utf-8?B?WUdlOTVnY1FqRmQvQVdreERXNHpSdzBDd2xnQVBYNmlBbkVxYVlLV21HdEFM?=
 =?utf-8?B?anVXdjJBZVErTGgzaldSVFQ0UEs0YjNVa1hjV0V1alJUcXl2QWhuQWoza2FI?=
 =?utf-8?B?Q1BadW1ZQ1hhY2Z6dHk1djhSZG5ESFkyVllJaWNEemFvNG1aVDdJakZWbWlm?=
 =?utf-8?B?QVBCcEFwWXFhdW5wOGFEU1YybndENmVZdkFPeEpHTkx2NmcxRkptbm5HU1JH?=
 =?utf-8?B?dVJ1YUlZMG96c0xLdGd0RFpoeWRtellnM09vT1pjRU01T200OXl4NnJkV3k3?=
 =?utf-8?B?QVhGbllYYmMrZ09ZdkxQbWRZUEdrU1pzS000a3NDN0JXeGlzT3U5aHNwaW5E?=
 =?utf-8?B?bTI4eHdqUVNEMUJPaGhxTUVSQ1VHWGJiNWQ0dkdMd2hBd2xRUjFjVllaWXRD?=
 =?utf-8?B?anhyTUo0TTJwN2RQbUtEakx6WHUvRnIyK0tsaGQ5blVGZUxJRjdFNWs1ZWpj?=
 =?utf-8?B?OFRwQVJxalZTSnBISXlnTmYvVUsxMnZhcE1rM1VQSEtKaDA4K1F1dW5TeGRz?=
 =?utf-8?B?d0NONFpMbnRkRW84ZmxuVzFRTVNBT1FxVUxlUmVYeXRvc2FhS0RzemhKWTRF?=
 =?utf-8?B?a0o5UGVGMEdEZGpNK3NES2ZrMVJ6UmdlTVVHL0lZYVo5SHNaeWVmOTVsaFdM?=
 =?utf-8?B?N0RkOEJuZU1DRENuQW8weEhneWM3R3czSW1uUjN3QUI4dGtOU2RHUXB2c2p4?=
 =?utf-8?B?R3JRYlNqRlVTS1k2TVhDc28zalowUUM4U3J5bTJ5NUtuZ214V2xKWTFiRFVQ?=
 =?utf-8?B?bjlNT2hpNzNZdDRMTW1OZjRLa0c2ZExJWmlrbVMwZnZudGRTeDBFOHZ5eWt5?=
 =?utf-8?B?cjVlNUVoRS9KK0tiYVhoQjZiTnRKZmgzRlVMT0diaVEzM1dEcDRHdVNORE85?=
 =?utf-8?B?c3cyNFZQeG1hcW5nQy9VZEFsTnlZc3F6QUdoZmZ2TGVlNWRCakRldGxXaU0y?=
 =?utf-8?B?NXV3aWpJMFhVbnBFUzdxcmNqRnhtSVVOcElsVysxUXFKMkd1Z21lYzBLdldG?=
 =?utf-8?B?VllKSFlVTCtjbnRZZEJmTHRVVElCY0VFSXFTeWxvUFFFbE5QYzQ5TWE0UTV4?=
 =?utf-8?B?S1M3dlBKMWE0VkJQaEtaczVHa1pZT1hJYWIyd1lHT1ozM1lBWXpCTXBQaFlH?=
 =?utf-8?B?ZUpMSlBFSzYxWVI0N2pScXNiNVVnTDgvT3dnNmJVZ2pHWUZ2SVAvTG0rbVZS?=
 =?utf-8?B?dTdXdkxqNHg4Ulo5K0xuQnNDalpkSW92MHhtSjFMQ3BRYi9pRWFPMEZWWTVK?=
 =?utf-8?B?SS9CK1FDMk00TndvTGhuVHRHOWpwaG0rL00zem5aM2pQNGYwdVJQSzZWa0pY?=
 =?utf-8?B?NGNlczFNSHNtaDZsb3lVTXJlb25zeVNYZ3B1bi80Vm03TnBEQ0dkYjJrOTg4?=
 =?utf-8?B?MnFoU3lvajltRFBHd2xwdnByVUhSRDMwakdOVjhjWlZyUnRhanBCV1pmWjVi?=
 =?utf-8?B?V3lWRHNNbEQ0U2NFSFFnOTZrbEJEcTlOU0RmMlNYeGpScXdrL3FiRWNOR055?=
 =?utf-8?B?TWs2TnJVM1FNNE5wTG9YV1hCbTNMZHlFc285NGJEU0x6b2RyTHY5azB5RkpP?=
 =?utf-8?B?bEhnc3JieEFTSHV4SjlvM2dJNENZbWVIOUp0dlFZbFN0Q0pvdlBGR3ZiajJt?=
 =?utf-8?B?S3NSM0ZIVFJacWJTc0x5WjhRU0lxYURSQzBzQWM3K2ZHUS85REpKMC84NVZH?=
 =?utf-8?B?eWRLcVZhOVBSU1BVdk01aVZGdDJjNHVVejFHMCtEbVhqdkFxU0NMSlJEekxt?=
 =?utf-8?Q?6cbc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b576aaa-cf15-4cd1-8e59-08dc73e4961e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:07:58.7614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pfb2AhGQ1C/Nu/eO7XEYsXCCpwKwuxnlYiVq1AcxhEWR5nDloL/bALiWDzPvbnB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBMYXphciwgTGlqbw0KU2Vu
dDogVHVlc2RheSwgTWF5IDE0LCAyMDI0IDI6MDcgUE0NClRvOiBaaGFuZywgSmVzc2UoSmllKSA8
SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEh1YW5nLCBUaW0gPFRpbS5IdWFu
Z0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWQvcG06IGNoZWNrIHNw
ZWNpZmljIGluZGV4IGZvciBhbGRlYmFyYW4NCg0KDQoNCk9uIDUvMTQvMjAyNCAxMTozNCBBTSwg
SmVzc2UgWmhhbmcgd3JvdGU6DQo+IFRvIGF2b2lkIHdhcm5pbmcgcHJvYmxlbXMsIGRyb3AgaW5k
ZXggYW5kIHVzZSBQUFNNQ19NU0dfR2Z4RHJpdmVyUmVzZXQNCj4gaW5zdGVhZCBvZiBpbmRleCBm
b3IgYWxkZWJhcmFuLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8amVzc2Uuemhh
bmdAYW1kLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFy
YW5fcHB0LmMgfCAxMyArKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPiBpbmRleCBhMjJlYjZiYmIwNWUu
LmQ2NzEzMTRjNDZjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4gQEAgLTE4ODAsMTcgKzE4ODAsMTggQEAgc3Rh
dGljIGludCBhbGRlYmFyYW5fbW9kZTFfcmVzZXQoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUp
DQo+DQo+ICBzdGF0aWMgaW50IGFsZGViYXJhbl9tb2RlMl9yZXNldChzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkgIHsNCj4gLSAgICAgaW50IHJldCA9IDAsIGluZGV4Ow0KPiArICAgICBpbnQgcmV0
ID0gMDsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQo+
ICAgICAgIGludCB0aW1lb3V0ID0gMTA7DQo+DQo+IC0gICAgIGluZGV4ID0gc211X2Ntbl90b19h
c2ljX3NwZWNpZmljX2luZGV4KHNtdSwgQ01OMkFTSUNfTUFQUElOR19NU0csDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVVfTVNHX0dmeERldmljZURy
aXZlclJlc2V0KTsNCj4gLSAgICAgaWYgKGluZGV4IDwgMCApDQo+IC0gICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ICAgICAgIG11dGV4X2xvY2soJnNtdS0+bWVzc2FnZV9sb2NrKTsNCj4g
ICAgICAgaWYgKHNtdS0+c21jX2Z3X3ZlcnNpb24gPj0gMHgwMDQ0MTQwMCkgew0KPiAtICAgICAg
ICAgICAgIHJldCA9IHNtdV9jbW5fc2VuZF9tc2dfd2l0aG91dF93YWl0aW5nKHNtdSwgKHVpbnQx
Nl90KWluZGV4LCBTTVVfUkVTRVRfTU9ERV8yKTsNCj4gKyAgICAgICAgICAgICByZXQgPSBzbXVf
Y21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gK1NNVV9NU0dfR2Z4RGV2aWNlRHJp
dmVyUmVzZXQsDQoNClBQU01DX01TR19HZnhEcml2ZXJSZXNldCBpcyBkaWZmZXJlbnQgZnJvbSBT
TVVfTVNHX0dmeERldmljZURyaXZlclJlc2V0Lg0KVXNlIFBQU01DX01TR19HZnhEcml2ZXJSZXNl
dCBoZXJlIChmb3IgYm90aCBwYXRjaGVzKS4NCg0KVGhhbmtzLA0KTGlqbw0KDQpbS2V2aW5dOg0K
DQpUaGVyZSBpcyBubyBpbnRlcmZhY2UgaGVyZSB0byBkaXJlY3RseSB1c2UgUFBTTUNfTVNHX1hY
WCB0byBzZW5kIG1lc3NhZ2VzIHRvIHNtdS9wbWZ3IGluIHRoZSBzd1NNVSBkcml2ZXIsDQphbmQg
aXQgaXMgbm90IHJlY29tbWVuZGVkIHRvIGRvIHNvIHRvIG1haW50YWluIGNvZGUgY29uc2lzdGVu
Y3kuDQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVVfUkVTRVRfTU9ERV8yLCBO
VUxMKTsNCj4gKyAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICBkZXZfZXJyKHNtdS0+YWRldi0+ZGV2LCAiRmFpbGVkIHRvIG1vZGUyIHJlc2V0IVxuIik7DQo+
ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gKyAgICAgICAgICAgICB9DQo+ICAg
ICAgICAgICAgICAgLyogVGhpcyBpcyBzaW1pbGFyIHRvIEZMUiwgd2FpdCB0aWxsIG1heCBGTFIg
dGltZW91dCAqLw0KPiAgICAgICAgICAgICAgIG1zbGVlcCgxMDApOw0KPiAgICAgICAgICAgICAg
IGRldl9kYmcoc211LT5hZGV2LT5kZXYsICJyZXN0b3JlIGNvbmZpZyBzcGFjZS4uLlxuIik7DQo=
