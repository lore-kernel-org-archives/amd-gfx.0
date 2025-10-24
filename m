Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FE1CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6AD10EB26;
	Fri, 24 Oct 2025 17:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C2sG1E3r";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D330810EB26
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEUsEWnTZwJEeVZHPk6PWo1cqfczipCnZkF9/ACpa/vkRwm2g7YybCMswnD+ao6X+fpwDyc0mn15J/kHAJAZUK0SzPaIGFgFJ17gGHLcgLrVOI1NIldMmbVs3sZnEZixRTJiTJIGHEfq+pve22AYZGH7x5iqga2QspjQTas4TUgMbo505jjivAEzuNpjiIjbhiIV4Jnp5bVpqcljnvgT4yNjLbqPKBSyVDabqqp6K2ClUB4/tNeFeD03FXhUaXg6ZVa85N/xSYTwnyw01Q6b5GhTf9Dmd4VWsm3hEsXexXRYmc31UyZLUH+q+FPVOuTdx2Ipt/lbbuUJM0OWZOvsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvFluewsF4DfpycYy/BftOuwSVAp2QFSCX7c0Bg12b0=;
 b=wzSnTeHPwTjPwnPOdvFXJ9FaNv6f9JmPp9TX0S23VpP0vITIu8K48tFI/0aiXbzgaXCecsKqTSg7PE1tFGnmy0AbTl9EDzzQ2+LPtuc5FDByZNMxfTsR2LbkKfzyti+04QZ+Icol3xSkEhP6LbQu3zTmvhJkGFe08i40RBMCIELl/MFHJesGBAAs6ODMYCheq0vvSpMHzyJGvT6Cx7KTmTnhWbRBidtODcipphFr3a4zuKMIkfZYijcVIUXZyPqNJbtb8x3dSA9/HmVYeHZGnYM0Ou/Oq9a34jG9GDNSI6sUh/SvERiCcE80F+q0TOnqMZ1k7p58pFi3cbiEwxH5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvFluewsF4DfpycYy/BftOuwSVAp2QFSCX7c0Bg12b0=;
 b=C2sG1E3r5ZYuA+5rHPc+nGtIbDxVyrp3wwzXJ7p1kjNPDdzUyQv2zY1Os3BID/hZgZjWLP632a4ZZ5JZvL5aH5+j8UTRcy7VMNM27em2Ay8ut6zBo2TMnKh3yU5zvA/amTyG7bjKWpeHRb2ZB8zOtKMdpl4ik3VqAOcSJGaGrtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:13:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:13:08 +0000
Content-Type: multipart/alternative;
 boundary="------------AyG6Sq6S0Hvbe2PQ8y6sOFV8"
Message-ID: <9b697481-8530-4cf0-8f44-fc5f23b542a9@amd.com>
Date: Fri, 24 Oct 2025 13:13:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: add missing return value check for range
To: "Khatri, Sunil" <sukhatri@amd.com>, Philip Yang <yangp@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Shirish.S@amd.com
References: <20251024111602.2128436-1-sunil.khatri@amd.com>
 <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
 <859ab89b-833d-fbf6-bc5e-1c4786b4a2c6@amd.com>
 <84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com>
X-ClientProxiedBy: YQBPR0101CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a62757-244a-4de8-41b1-08de13209a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmRodWlVcFAzUVd5R3JMRGNTRFh5bU1wcGU4SmFsWUhoVjQ4TXNYalRheW5J?=
 =?utf-8?B?dXBuYnh0T2lIUTF2NkxVUDZ3WjlqUWR5NXRHcGd5aHY3WERkWllZYnNjUndl?=
 =?utf-8?B?T0xwL3dERDkzRHp5aTlsMnBSeW8rWUIvMUFiVHhhc1Y5ekpYUnN5bjRsSmJa?=
 =?utf-8?B?UzJocnpSSTM4Qm1tL1hSOG9LcWVPM3hrOGEvL05wbksvcHhObHg5am9DSWda?=
 =?utf-8?B?QzNlYWxzMWd0aGNlMFVzNHpDV1lhb1FOTC9ITEhUWjZkWnh3SFlGQmdtTGhu?=
 =?utf-8?B?Q3NXWmpMSDhvZGd2ejJIRXE4WEhVZVM5emlBS1V4UTQvRnc2R1NoZjllVjN3?=
 =?utf-8?B?T1A0U0F5WVUxL3dqdVNTYmR6RVRqV2lRekVZNVY4UEwzL0oxaG14d3E5ZnJQ?=
 =?utf-8?B?WFVTOWtaemx1aDJlb3oxTzVDcDJubzhDMXRoZVVOR29Sd284UlkyaUZyZE8w?=
 =?utf-8?B?Qzh6SzNrUDhjeVJFalBkemdvQUMwLzNxbDhsTURndGRZWW8xb2pKcEN2OC9h?=
 =?utf-8?B?UVFpWTZYb0ZWQURoYks1QjhtNEprYWxnYXFUWForeUlNcG0wU1o2czYxQ3Z6?=
 =?utf-8?B?bkt5MktJdTV5aDIvYlRmeEFEUEdlQldUVVpSS2dld0k4MmlVa1B4MTVrS05V?=
 =?utf-8?B?RUMwOHFCU1ZKbmVnUlV5VFl6azJ4OHloVVJoZXZLR2h0RFNrbElrSEdwRm4r?=
 =?utf-8?B?cVFDS2VONXNGaVRLNWM4ekJod3BuRzVGQW1xZ1JrazNFUEsyQUg4a0FMUnlu?=
 =?utf-8?B?TGd0NmNIYmVyRHBNcWlkZlQyZEVxQVJaNFJHTFpWS2NYYXdIb3hYYmI3R1RB?=
 =?utf-8?B?T1Boak1XNy95cXhxejJ5bEhGUEFpNXdsTGhHRnJLZWZZZVY2UGNyZktOVExI?=
 =?utf-8?B?L3RIWWRLc3JlQ043WFB5K0RPZUZJUHZaQ2twT044aXN4Qk5DT0lHeEN6OHo5?=
 =?utf-8?B?eGdBS3ZQMm1YalRVNXQydDhRblVmYldmWjdRRFFlZTJZZ1Jsd2JGVFZ1YjFD?=
 =?utf-8?B?YkhIaTJLNTNYQS8wV0xtbjVZWHU3MlJ5bTE3SWtFcGc5VUl0eEhmdXB5bVBK?=
 =?utf-8?B?SXZRbXZJZzJXZkk5bHhTNURVejN5allZTDl4cEkzQkdNK0NIWDlTT1FoaWhL?=
 =?utf-8?B?UzNWVkFFKzFsZm0xSy93b2ljb0RBc2VTQ282SWdMWTFZTVZCNGExdTR1Q3lu?=
 =?utf-8?B?WjFRR1BtQVBaREVyZjV5ZktrM3M0RllsMCtUT1k3MWdxV3grSHYxb2xLamRy?=
 =?utf-8?B?Q1JhRkZ3VkhDa2gvQzFkb3hvaVYvaE0zaEp6TWQxMk5BWDhaTHNuRzY3UUk4?=
 =?utf-8?B?cWZyOG0xbU1VOEF6VWcwVlBTSTZiNFlvc05WdmI5cGRCVk95L1dPMnluTEUx?=
 =?utf-8?B?SFQ5YWlmUUlHbG9WYWgyTDFQVktuTVJEVkVaQnVmLytXY2MxWExZV2ZiUTFo?=
 =?utf-8?B?QlhwWm92bU5XclBBaWhEb1hweHJNZXM4SmEzL3BqRno4N1pPR1hpaFp2VStw?=
 =?utf-8?B?V04vbW9pSlRMNE4rVnBzdjJhRENWaUJFZ0ZNb3d0STdaMDgyN0kxUjNmWUh1?=
 =?utf-8?B?aWFjVHRBY0R3Tm1Kc04wcXhDcGt4aExxU0lDN1l6T1hDSjExVWxQazBNZmNi?=
 =?utf-8?B?V1lVamxPQ2t2aENxYTJjMmNPV0wvLzJKSmdQQjdvdDc1cmM5Unc1amxzL1Jt?=
 =?utf-8?B?Ujc3dnY5U2Q4eHpDZjNvMkIxd1BNanBYL29sbHQ5NXJaVHRvZDdodjRyYTQ2?=
 =?utf-8?B?cjcveUJpUE94c1E1eXZoZVVLU2xyamRVRjhma3NWNUZyaCs4WThWV0ZYbmN4?=
 =?utf-8?B?ak5zbks4UUQ0MXcreGJkN3ArMTVtd2VtbjJ3ZFhGVmFrSW1tRW9aTU9EUENm?=
 =?utf-8?B?QVpNQkdvYUNxTjMwOWU4Sm10d1c3U3JNSTVmVDl4QnRWQ2xKRm9melowQ1Rm?=
 =?utf-8?B?YVc2Vyt0YUl3enJVRWtCY3NGdTJOMTkzMUl2ek5PazNiNkM4eEFwbGh6R0xM?=
 =?utf-8?B?VmxIOGlPVWV3S0duNXpqb3ozZ2N6SDVaQllZU2lTRzJNMjFSSGMzc3MrY2h0?=
 =?utf-8?Q?wGTDmO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTROL1RKU3FNd3Q0N2twd2FSL3oxczJocldMY3oyNGtOWlZmUnB0RmRsSVVu?=
 =?utf-8?B?RWVRNFY2NHIzWnZLd0N5bUZSUjdJMk94WmZiOEFxWW9SZUtzYUhVdU1lVGk2?=
 =?utf-8?B?bHNIZHhZUWZUbHE5UFQxS0F2WGpXeHl3Yk5jNnZEamNsVmo0YjlvUmhSUmdB?=
 =?utf-8?B?cmJRS1FVeWxGc0R2Qkpoa3ZMMVE5VlpWdUJCb1hsN0o0K1ZobHBFemNROEdl?=
 =?utf-8?B?ekVlYnF4MnAyd0VIb0ZlbUdoSTF2MTFsTU8zbG5UREdNeXlCTkRuQjV2b2xV?=
 =?utf-8?B?QlBGaExsWFYyUGNodlBaRWE5ZW1NWnBxY29wN3JucFNmalE4Rk9hTHlHTFZj?=
 =?utf-8?B?eU5qaU1odVlkUHc4Yk5Sc0hKU2h6bzdXcFQ0VFloOGxzb0l0WGNSSSt0UXo3?=
 =?utf-8?B?L1VHUWpWR3Y5VVoya3VFTjBncGluSTd3YnVFaHNDUXVqeTNVcjJIdW50akpX?=
 =?utf-8?B?S205Vng5UTFpMjcxYlpiTjk1Zit1UHBpS3RSM083QlhZNnJmQzRJTjhSbWFF?=
 =?utf-8?B?d3lqd0hqenZmalVyV1NtQVM4VXZsNmpXSk1PVVMyOHI5SWZsYVYwSm11R0d6?=
 =?utf-8?B?QnFaNVptWU1pYk95RTRiU0lPQlFYV1NuZTBLbVE5bXRYTXVDNHArL1c0cXoz?=
 =?utf-8?B?R212OVZwTytXNFhnb2N0M1Vxb0R4eWxqRDVCdU1qTkxTTlQyUU5PRjZlb3J1?=
 =?utf-8?B?ZU1JTWhMOVUydUlrNnRrSlpYMUdtZ0c2SkRDcjJvTmVUOUF2ckVpY091SEx1?=
 =?utf-8?B?Z0dLYnNvZGNKR1pCTThLTVRzNzFZYXdpcEVaWlBHaDltSm5rRTVEb0RSSnlU?=
 =?utf-8?B?N3Q5UkNUWWEwem1GaEdtbjdNa1FIdXBscjgvanl5RHMyZXBUcFQrNUkvYW1i?=
 =?utf-8?B?bktTejY5dHVPZzJ2emhhZ2o2bVZsTFE4KzBkSGlDanZRZ1NNSFo0aUVIdFF3?=
 =?utf-8?B?dHBaaWhJSEhJK20wUG9lZlpsNFJUSjVadm9SbnVGT1YzZzAycHJrNis1cGNr?=
 =?utf-8?B?aUc3TEJMZVk2MEdMdzZxM09CeGhpSG9zV2lFa1R0cXI2ZXoraFpqc2M3My83?=
 =?utf-8?B?NkdPT2ZmR1hQNVo1YVg1MmRBc0tJcVlqclFNUGdQNEtDZUdvb2RYNjFkdFBS?=
 =?utf-8?B?M0NrbkZ5dDFyNE5BL3lOd1BYVHZuR2hhbFdmVEk4YkFrSGR0cERmZHc2TjBo?=
 =?utf-8?B?TnBaRnljazhlK1VucnpwRTMrRnJkN1lGa0VTNXdZMmNwSWtxQjRFZVF1ZGhH?=
 =?utf-8?B?OG1oaG9tZWgxWnlObDdHRHVNOWNZV3lCSldrdWVNT0VOZzVVcXZjcWtnQnJa?=
 =?utf-8?B?RnRWdWV3TmhVWEY0My9iUnZZeXRUNzM4Z05YYmw5UlVvVHNUWlY4Z01IaXg1?=
 =?utf-8?B?VlVYNkNtQmdVeU9kZHdUY2ZHbEVaeCt5VjlqbDVBbStnWklKSW52bFBlYjBH?=
 =?utf-8?B?TjFWVENWUytweS9aTFlQblhidkcvdnZROFJ1SkhpaTREUDljMzZqV0lpVjk3?=
 =?utf-8?B?eXFZWExEMWVVeGlCQy9EaG11YUI1NGRvb0lkWkxWMjR6WkxLK00yNkVMdVhL?=
 =?utf-8?B?c3FCWjM5MExpY1ZDcWdvVUhwSm5hRU5JOGphVXdiU0krc3RObUN6VGhlTmNR?=
 =?utf-8?B?Sys1ZHJYR1IvcytVOElueUxEMEE4ZVBmdk1ZVXp0dTFXQkhlbHhya1lDcjQv?=
 =?utf-8?B?MWhvQzQ4ZG9LU2hIbWpCd0kxM2hOTm94cE0vbmxEOGlCQzlQdDVTV3lNMi85?=
 =?utf-8?B?NlZXOFd0UGRHckorOTEzcUl6Q0JlL2tGdUZTMk9DZnQrb2Z0RU9GcjY2Y0E0?=
 =?utf-8?B?M2t6cGVoWnNNMlZzSTVmODVjaXhzdXFaVTN1dGZYbkFINytaNWpzR01KU05W?=
 =?utf-8?B?a2R5bzQxVWk0RURPK0Z3MFVQYWU4OW1mRFgwbkNpckdyQ2x0eWozTmhxWnBk?=
 =?utf-8?B?ZFBNWGlYbEtZNWdNV3NnTVl0L2RCMndGZnRGOFlGNllhK3JLYXJmT1FnTjNy?=
 =?utf-8?B?YUgwMEJWVHhLN3kySlI5R1BLZWJ4SHJTN1ZuOGxSaUFCVlV2bGZoamU3MDJH?=
 =?utf-8?B?enJ5RlZFT0V0TnJ0SEQ1VjZTeTk2elZQMk5rRlN5dWZLZHdsUWhnVWhlc2c1?=
 =?utf-8?Q?IzZooeQxCywuvnekDtDNE9fMV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a62757-244a-4de8-41b1-08de13209a32
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:13:08.2299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SYHRih+iar37LZD6ZLGKwHpzP1XIaxC/3n53i+BOG72NOIbqfGLvCoyWJsarYUBbiQC0cxriN3JcTrXNyDkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

--------------AyG6Sq6S0Hvbe2PQ8y6sOFV8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-10-24 12:55, Khatri, Sunil wrote:
>
> On 24-10-2025 08:41 pm, Philip Yang wrote:
>>
>> On 2025-10-24 07:45, Khatri, Sunil wrote:
>>> +shirish
>>>
>>> On 24-10-2025 04:46 pm, Sunil Khatri wrote:
>>>> amdgpu_hmm_range_alloc could fails in case of low
>>>> memory condition and hence we should have a check
>>>> for the return value.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index f041643308ca..7f0ab73e2396 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1738,6 +1738,11 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>>>               range = amdgpu_hmm_range_alloc(NULL);
>>>> +            if (unlikely(!range)) {
>>>> +                r = -ENOMEM;
>>>> +                goto free_ctx;
>>
>> Can not goto end from here,  this skips the svm_range_unreserve_bos. 
>> Just set r = -ENOMEM, and the loop will exit and cleanup accordingly.
>
> That patch has already been merged now and i have to send another 
> patch for review. While at it, cannot just set ENOMEM and leave as it 
> will crash in next step where it access range which is NULL.
>
> This is what i am thinking
> range = amdgpu_hmm_range_alloc(NULL);
> if (unlikely(!range)) {
>                 r = -ENOMEM;
>                 svm_range_unreserve_bos(ctx);
>                 goto free_ctx;
> }
>
> If that is fine i will send a new patch for this ?

I'd recommend

	if (unlikely(!range)) {
		r = -ENOMEM;
		break;
	}

Regards,
   Felix


>
> Regards
> Sunil Khatri
>
>>
>> Regards,
>>
>> Philip
>>
>>>> +            }
>>>> +
>>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>>> addr, npages,
>>>>                                  readonly, owner,
>>>>                                  range);
--------------AyG6Sq6S0Hvbe2PQ8y6sOFV8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-10-24 12:55, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com">
      <br>
      On 24-10-2025 08:41 pm, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 2025-10-24 07:45, Khatri, Sunil wrote:
        <br>
        <blockquote type="cite">+shirish
          <br>
          <br>
          On 24-10-2025 04:46 pm, Sunil Khatri wrote:
          <br>
          <blockquote type="cite">amdgpu_hmm_range_alloc could fails in
            case of low
            <br>
            memory condition and hence we should have a check
            <br>
            for the return value.
            <br>
            <br>
            Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++
            <br>
            &nbsp; 1 file changed, 5 insertions(+)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            index f041643308ca..7f0ab73e2396 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            @@ -1738,6 +1738,11 @@ static int
            svm_range_validate_and_map(struct mm_struct *mm,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task,
            current);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range = amdgpu_hmm_range_alloc(NULL);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(!range)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_ctx;
            <br>
          </blockquote>
        </blockquote>
        <br>
        Can not goto end from here,&nbsp; this skips the
        svm_range_unreserve_bos. Just set r = -ENOMEM, and the loop will
        exit and cleanup accordingly.
        <br>
      </blockquote>
      <br>
      That patch has already been merged now and i have to send another
      patch for review. While at it, cannot just set ENOMEM and leave as
      it will crash in next step where it access range which is NULL.
      <br>
      <br>
      This is what i am thinking
      <br>
      range = amdgpu_hmm_range_alloc(NULL);
      <br>
      if (unlikely(!range)) {
      <br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r = -ENOMEM;
      <br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; svm_range_unreserve_bos(ctx);
      <br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto free_ctx;
      <br>
      }
      <br>
      <br>
      If that is fine i will send a new patch for this ?&nbsp;<br>
    </blockquote>
    <p>I'd recommend</p>
    <pre>	if (unlikely(!range)) {
		r = -ENOMEM;
		break;
	}</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com"><br>
      Regards
      <br>
      Sunil Khatri
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr,
            npages,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly, owner,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range);
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------AyG6Sq6S0Hvbe2PQ8y6sOFV8--
