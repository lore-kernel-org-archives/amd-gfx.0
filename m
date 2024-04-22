Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70706C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 08:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FC31128B3;
	Mon, 22 Apr 2024 08:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fcINKJbZ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1861128B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 08:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO+BNhK2I9VL9WSGwsdgURPwSAu/YXbHFMZ48gr0TDvpQysACaaSS3zWuyRynkmY0jooROvd5vhwvEojc3MPH3cYRxqCSz8joewnInLOU3JPxxWdVwzHnzkACOqwWUNIx5p4jBoBZ312rbcHXoWuHSUJk/UnWRuSQ1v9cg0A2hHmJC2e3dFxAaU8Va8V5pkMswce7qiyx8wieSeuCf6iPDsj3vLutM5ZK94IMae0SQEi+rmO7zxcOYF1uCrhzYVsQvFkKHkknB6MadMXh2NRyhroidJAkEbLg5kGk1RryQN/XHdajKGyh3xS4kyk1a2imCawkQPm2tf+hfz0WKeZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdfeCsyt5PiE3jbYwUoxfZH7t/sHYQyDnQ1RnWRVrWU=;
 b=OKdeE2qELvpD7RvHP4ujJFSQVeAbwN0XjXnvBfkton5c5uR3hVAffA7f/XJ+ttgq/JpJRp2505WNLTJUTwiBJhQzNeMqodtyhyBn3PfhXKfvBJvrO58Qk3Mwc3UAXLcnOb80FvkPveo6IFzprWWGaI3SF16M4gs3fBTJBjGajgBHUpZkxYcsleDS5/dBU48jen5tAUsVxA9YOPHrv2iuB+EHnzADG1cGZKedpufQqWzc7yykSeoQEyS2Xmv7UeiwktDHjd9k43/dIIYIzgSyS4eCy01pkdcPg0L1K+jlB8evCDti/VSuby5RKACvJIZpC/LANTBvKVJ2FEIrNbJLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdfeCsyt5PiE3jbYwUoxfZH7t/sHYQyDnQ1RnWRVrWU=;
 b=fcINKJbZLBvOJ/JhrdLgaV4P9h4pAK3AzXKJmEwxDIk7IXszFsnH2BU/pwB4HzJpz/AvuFKN9t3lNMSBqPBcfz6G5XGwYNQl93KXhLqu5rq8gmnuQ00Q/O/Lyw5kxNFFslmk48vPC8aRzItAyNeqg7SLVQ7MU448+gBB8tUXnJU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 08:27:01 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 08:27:01 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
Thread-Topic: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
Thread-Index: AQHakTzYkBm0717lQUWfL3VKfDTYoLFtu1UAgAAJcgCABjY4cA==
Date: Mon, 22 Apr 2024 08:27:00 +0000
Message-ID: <PH7PR12MB8796F5C3883219E6979FB5BBB0122@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-15-YiPeng.Chai@amd.com>
 <17718699-72cc-400e-bef8-5b4314a06386@gmail.com>
 <CH2PR12MB4215F6E6805189417A8D092CFC0E2@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215F6E6805189417A8D092CFC0E2@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9e457ba-c068-49dd-910f-bb40ced295b6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T09:31:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB7095:EE_
x-ms-office365-filtering-correlation-id: f924e6d3-9938-4967-b7e0-08dc62a5fb9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?THRTOTR0VC9zRHRqWWlVRmdaMjd3Q2ZOc09kWWRXcDJtVFZlWHBlOHNtVlVu?=
 =?utf-8?B?NzM2a1RMaDhncE9TRG1DczVoZ29BNktMSEh4dS9PNURGb2NyUjkrL05JUDJB?=
 =?utf-8?B?NEx3SVROaE13N2xQRmtLQjlwVDBzWTl1RGViZ3BHNHdkWUF2OVk0Y2k2eDZV?=
 =?utf-8?B?bUVTOC9GY21SeE02WmpwUWpoYnlraDhoazZVOC9kVWJyWWdVTmFhSEp4L0NI?=
 =?utf-8?B?bmR0NTR1VVBaNzNteDJIdUFSK0xxekZHNGZybms3cUljUVlhdlhueXVUU3hs?=
 =?utf-8?B?K2xjRDBUOGRTSFVxcVFpNkVZZkZTQ2JWenBOWW1aR2V3dllvVXpseHNBOGdi?=
 =?utf-8?B?RHBEQjRPYUtwL200U3JRRUkyWTlHajBPUnBiRDJlMzg4SjFQcUgxYjFYTmEr?=
 =?utf-8?B?U0poRUlPYjg0VnR0aUxmb0FoMnBmeXJCVU8xS1pDaXcyaW0vWDM3S3Z6amhB?=
 =?utf-8?B?RnFrK2VsdkcxUGlpbFZNY09raFpUWW5Yc1k1K1lWYWQxN3RYUWRjUkQ2NDkr?=
 =?utf-8?B?WTBGVStuZGFJcUR2WjBwUEtSRy81WWV2cG4wL0ZLRFk2VEFKcmRQdTQ0TDB4?=
 =?utf-8?B?TjVYRHVLbVFMMEFNV01GNzAwOGQ1cFozQm42VzNzUGZDOGZLcUdsOVI3d0I0?=
 =?utf-8?B?dFRLWDdKVk11TFp2TEVMdlcxaFVjdURINm1FdHk0UGRMNVdYZUd1bkEvaU9U?=
 =?utf-8?B?UVdjd3RKeDE3Qk9Ra2Q0N1dCVlNTYmJIZS9RWHVXOVZXN3ByOUtmS2lyQ05B?=
 =?utf-8?B?WGk0Um5BQ3QwVnZUcUhFaE5nMi9LTEZaWjZGT2dSUCs2SWFJRTcvc2xrSGRx?=
 =?utf-8?B?TFcwaXdGM1ZHaUg1Y3VIN0thOVdRUmxMbUc0d0hWcnlDK3ZlR2FCcW1sL0tI?=
 =?utf-8?B?M3RQYnFVWlhzMExPRGNmRUNrOGpSV0dYcFRuUmJHdCs0SzZjVnY2WHo1ZWRr?=
 =?utf-8?B?R0xqcXozSk1rWE9rVDFHWnZSZDlNbUN0TjcvbG5FTlBJeVVDOWxRTmZOaHRl?=
 =?utf-8?B?NXovTU0zWWJEVHpHbXp4bUJIMk1zSG9ZcnR6VVFnb2htcGZXNTBsNndKMHVS?=
 =?utf-8?B?b0VPc3BrdmplMFByVWVOMURVSnNkY1lvTno0aGZOVW1MWEdhTXIyeU11bnBM?=
 =?utf-8?B?V1JFQTVaYTh1azBpQUFsblVFa2oza1RWU2dYdWtIdmNML3o3U0hKOTlWMzB4?=
 =?utf-8?B?ZmFPSFNPMUpnOU53bHF4aFJtaHNHLzhDQktpRnhKaFdvSS9pVHp5Q2ovdU9z?=
 =?utf-8?B?M29SWTRER1dENHljK3ZSMkdZVjJwZjhGUHRBajdsdHllUjhiVTNkNnkwbU52?=
 =?utf-8?B?MU1MRXZURlJHT3ZPenhlUmlOeFVDWlpkY2VlSlZLaFVoUTR1ejNUTlFrK2xR?=
 =?utf-8?B?WVM4QzA2djkyOWw5NmdHNk9ickNSWDJMZUthaHNOTjkvaEVWd2hZTzJtS1c3?=
 =?utf-8?B?SkN4dWFhaEh3MlZ4eW8yaVY0czBLM0pWdEVhNzJMRVlqSDJGTmJ3UE1qUUVk?=
 =?utf-8?B?SVJzM3N2OHN6WXR1VW5ZQ1ZwTWRGbHVYSHdRQ1M0VkRuZi9KaFRodjE5bDR5?=
 =?utf-8?B?dzUySGNpUXN4L2tmUXhxN0pOZ3pSbUtSYmFGWHRybWxtaENCZFFPZnZCa1hX?=
 =?utf-8?B?cGF5V0E1aE4rdHpQYi9UTVkzb2owOC82aXZnQmJnUWtjd1c4eFhsdmhmc3FE?=
 =?utf-8?B?MkhlM3lyRXNJQ2EwKzk2SFpGV2psdS8rZ25GZUZWYmJzTzdMU3NhT3JYY0pj?=
 =?utf-8?B?SDdLVnRjSDJxbzVLWHlzb0pNK0hOb1RQYWp2NW55ZC8zWnVCTXRLZ2ZDdUx5?=
 =?utf-8?B?MHZOQTcydmxWNlNuQllkQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJBc1hCVnFUbmloWWtWaFRucG02ZjhlN2dUZUVtaEVjSk9Pb3RSUmFGWC9Z?=
 =?utf-8?B?M3UrTm15YjY3Q0Fwb0hyZjhSUGRRMHJmR0h5QXF0VDZObHgxaWJGdm9vT3Nl?=
 =?utf-8?B?VHR4Mi9PRlJRSk1HQ01NRDhoWWtpVjZpWXVDSk1aRDBBbWdzYnVXVGRnMTZ0?=
 =?utf-8?B?bm5MUDJXR3J4eHJzOVlrNTF3RjQvekppZHN0STFvd0lUbjZSRVgrRGR3ZmZO?=
 =?utf-8?B?c2RRVDNsK3NCYjU0RkZOVWRraEh0NXpCeFRzMTRJZElOU1BDYmkxUTFCQXc2?=
 =?utf-8?B?SjZ0WUJXODJ4Qjgza1VwaGxkY0Z3S0pPQ3QwY1ZvUkJzUmVpazF2WVlEblcw?=
 =?utf-8?B?aDNaV1pSMTlCMVBRL2p0dzlnNnlVTmI1QUc5ZzNFY29OT1gvWnd2Wi83THVy?=
 =?utf-8?B?RFFTRUZCeUxVK0RDeG8zZjhuVXRvV2NoTXE0VEowTVJCejdlM0VqdmNzdldl?=
 =?utf-8?B?NnZRZUQ1dWVkdHVGWEVBK01qbmxmNHRLOFB2OGxNeThRQWMwdjJBYkZ6Nldp?=
 =?utf-8?B?VXJzVlJoSktPNlZxeTRGVlIzcUtOeVNnNUpXY0N4dzhIMjQzVkhPbjFYc29K?=
 =?utf-8?B?VWk2VC93SExKNHk4SzQ4eXh4NWhGRXFCSVV2aW8vNnpwNlA1RDExOC9vY1Bz?=
 =?utf-8?B?cUNtR0dzQk8yZE1KbzVURExZaHdJd2pBSFNpU3JqbUdUNkFsL3VLblh6czFp?=
 =?utf-8?B?amJ2Nmo2T1pMZjN4Q2RkQzBJcVFGbnpsbXJKODZOQjlTTCtVTnR3RnEwb2JV?=
 =?utf-8?B?UysxSmZVTVlXYytGT2h4N3V4RDdBZ1YwWXRLcjFPcndlUDdiNENSSHY2ZGpO?=
 =?utf-8?B?enFDcy91ekx2TGhHSW9jU1dJTDdiaDV3N21leVNBS1ArV2x1SGVMWHNES0F5?=
 =?utf-8?B?bHlCYWhPRkljTCtQNng4MHczc1RrWE11dXhIQVQzMnpra1o2dG5SckY5QVN2?=
 =?utf-8?B?d0hoazNNa2xSUS9RWjBudi83Rzh6QjJxbjhiOVIxZlljdHZjYlpLRTd3MTkx?=
 =?utf-8?B?SnU1aWNYaTluZ1kxd081N3ZabEhHLzNWcmVHUXJKU1JpZlcvWUxUUk4yMmFh?=
 =?utf-8?B?K1RlSlJHclk0YmU2bjY0eDRwZ05TRnM3Wmw1VGFFcTlaY3FaS3lQTjdhWFV3?=
 =?utf-8?B?S29yOVVJNXlrWXd6S3d2OVBKQnVielRoanRJQ1N6U1ZackxsRWd2OFg0SmNi?=
 =?utf-8?B?bjQ1S1ZzQnFaK0gzUTVGczBoMm5ycURSaWp2d3MwQ1lHNTNKSFA2MDNsRmpm?=
 =?utf-8?B?OVYrd3B4emRmRWxxR1VjM0p0M2M0SWtDWm9HQnN5bE92d1BNZnVkdHJrQVBa?=
 =?utf-8?B?bFZXd1BjSVBmaFZyZVl1NFg4VHBjRm5uVnFNT3BKQUdJeHFUaUJoK29sSEdL?=
 =?utf-8?B?bFJPemxDTWZlTW5wY3o2em5qc0ZhWGJmYllnaUhpZGFnSklFUXRqVEpKMFdV?=
 =?utf-8?B?VDFlckk2Y05EbE5hdzErMFh0Ynl5SHQzSjBuRy9WTy92OVdsbldKZWJNdDZZ?=
 =?utf-8?B?TzlpRk9xY096aUZxL0x4U1l5K2U5YWxpbWJzZFR4cHZLbGwxN2pCWnAwd0p4?=
 =?utf-8?B?cldjM3hNTnl5NnEyaTZBVXdkeGdPS21SV3FzbzdaNXVERkM1UTgrUnNqUnho?=
 =?utf-8?B?cTlqQ2dVZEtNUk1pZkxkbEtuRDArUG9Ia29HRlMzSEtLd1RFZUo0YWtDY09a?=
 =?utf-8?B?cFRlbFBsaSt0TUlCTXgvaWNiQTNLajNYQ2Q0N29CaGlJaFpYZmNVWFFTUFpG?=
 =?utf-8?B?dVV5NmNBbThNTVl2NTFxTFpGWlBlNjFVcmtjUUp6amRFRzFaYmVVLzk1cUNB?=
 =?utf-8?B?bjQrWGlRS3J5c0ZFaHRQYTZTaFhZeTNlY2I5L0g2UnVmVC9Sck50dXFrRDNV?=
 =?utf-8?B?eHI5dC9iemtlZ3d0N3A3V2FVVkF2TEQvNjhMb1pTam1wLzVDNXNHaGozTTA5?=
 =?utf-8?B?Y2dsand3OTlITVVkd08vNWFaNGp0TlhpMEFMbUtNTmg4OXBwRGtMcmtaTzNn?=
 =?utf-8?B?QnhRK1RyWnhOVW5VeHJIVE5YTFFNSUN0TUFVSzBqc3JQZXowWFM5WlpNS0RM?=
 =?utf-8?B?bHY3TERmWGQreWlxQ2RmKzJYZDkrSnR4K1Ayd3F3Q2g2ZGszZHJiOE9XY290?=
 =?utf-8?Q?iCVc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f924e6d3-9938-4967-b7e0-08dc62a5fb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 08:27:00.9650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJMBfMg1RRfdsDnChbM8RFxHHqLYr7Facq4eFlUejaaHfnJeItmpVub8s6G0+m4P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldpdGggbXkgY29uY2VybiBmaXhl
ZCwgdGhlIHNlcmllcyBpczoNCg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1k
LmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGFpLCBUaG9t
YXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxOCwgMjAy
NCA1OjM1IFBNDQo+IFRvOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8NCj4gPFRhby5a
aG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IFdhbmcsIFlh
bmcoS2V2aW4pDQo+IDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleSA8U3Rh
bmxleS5ZYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMTUvMTVdIGRybS9hbWRn
cHU6IFVzZSBuZXcgaW50ZXJmYWNlIHRvIHJlc2VydmUgYmFkIHBhZ2UNCj4NCj4gW0FNRCBPZmZp
Y2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tDQo+IEJlc3Qg
UmVnYXJkcywNCj4gVGhvbWFzDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0K
PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTgsIDIwMjQgNTowMSBQTQ0KPiBUbzogQ2hhaSwgVGhv
bWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
DQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNv
bT47IExpLCBDYW5kaWNlDQo+IDxDYW5kaWNlLkxpQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmlu
KSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47IFlhbmcsDQo+IFN0YW5sZXkgPFN0YW5sZXkuWWFu
Z0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDE1LzE1XSBkcm0vYW1kZ3B1OiBVc2Ug
bmV3IGludGVyZmFjZSB0byByZXNlcnZlIGJhZCBwYWdlDQo+DQo+IEFtIDE4LjA0LjI0IHVtIDA0
OjU4IHNjaHJpZWIgWWlQZW5nIENoYWk6DQo+ID4gVXNlIG5ldyBpbnRlcmZhY2UgdG8gcmVzZXJ2
ZSBiYWQgcGFnZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcu
Q2hhaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jIHwgNCArLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jDQo+ID4gaW5kZXggZDFhMmFiOTQ0YjdkLi5kZWU2NmRiMTBmYTIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gQEAgLTI1
NDgsOSArMjU0OCw3IEBAIGludCBhbWRncHVfcmFzX2FkZF9iYWRfcGFnZXMoc3RydWN0DQo+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
PiA+ICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAgICAgICBhbWRncHVfdnJhbV9t
Z3JfcmVzZXJ2ZV9yYW5nZSgmYWRldi0+bW1hbi52cmFtX21nciwNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgYnBzW2ldLnJldGlyZWRfcGFnZSA8PCBBTURHUFVfR1BVX1BBR0VfU0hJRlQsDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HUFVfUEFHRV9TSVpFKTsNCj4NCj4gPiBX
ZXJlIGlzIHRoZSBjYWxsIHRvIHJlc2VydmUgdGhlIFZSQU0gcmFuZ2Ugbm93IG1vdmVkPw0KPg0K
PiBbVGhvbWFzXSBDYWxsZWQgaW4gYW1kZ3B1X3Jhc19yZXNlcnZlX3BhZ2UsICBhbWRncHVfcmFz
X3Jlc2VydmVfcGFnZSAgcmVmZXINCj4gdG8gIiBbUEFUQ0ggMDEvMTVdIGRybS9hbWRncHU6IEFk
ZCBpbnRlcmZhY2UgdG8gcmVzZXJ2ZSBiYWQgcGFnZSAiDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gPiArICAgICAgICAgICAgIGFtZGdwdV9yYXNfcmVzZXJ2ZV9wYWdlKGFkZXYs
IGJwc1tpXS5yZXRpcmVkX3BhZ2UpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICBtZW1jcHkoJmRh
dGEtPmJwc1tkYXRhLT5jb3VudF0sICZicHNbaV0sIHNpemVvZigqZGF0YS0+YnBzKSk7DQo+ID4g
ICAgICAgICAgICAgICBkYXRhLT5jb3VudCsrOw0KPg0KDQo=
