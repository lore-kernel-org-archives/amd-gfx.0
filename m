Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41063E7DEEE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 14:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F4010E4E7;
	Mon,  2 Feb 2026 14:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZChZ/MUq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB6D10E4E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 14:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfEai3Hh1tQ+hXSwzBZtjq4rgpbwCyBRR/M9ppZdoRpbd98EiYk354PLtMtobfcJ0ydeyXBH9pmI4Xt0bZd/s9WLt5VToF9KQsobArUckD74SgxxRhSLHDeVMA2JeqWqsyK4VcNnRugN7TsB5NxNUJrEX1NHPGhcvqRGeAnGGNGfHFTJv3+0j3faiRhVX2T+AB7cGF87E+MQfYXEO1omNSCT5C+4z4Q/6hPzZODxZpV2AcGvZN/0nwoQlYJGDyiufp8EJaRpZTVoCIpa8a4FU6MS6Ywdei/Rc9iESCjY6nDVN++WxdNSullgzKX1z7oZ5/nquL05m9tUGNJ+WI9i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u893sGlvZInfv3wAIEO80aaIh3bKQwzBGSyeS29Hxy0=;
 b=AD7GBq7WuQC4SVSlCTHVvP3smb69vdOhrvuoW5ysu0oLz7+LDNAjPdBfHNC0dmd36WPPynfO4+oFdjpgRQtZwAT0TZ+k2m39L+Oxe8a5Gu/cwGgsoBgVLiQWB92Ri/IOJqJ1tnojNYmIX4H+GrN0sEWlePAEUSx46F4fdMl+2xY8kG2bioaLmevJpwtA7WcRqBfN94EH5MN3jdt7MdSDhwYhG2faK4bUsa+b352wvazyypUj9kIOe91yPUWew/a2pwFmKZvATWUk6lOVDASM2IRBBenbxzBchLc0wV7IOx9+kzkGWhC3ksnwu+kwkfamOPv60ZpDJxG0aMWMtYzZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u893sGlvZInfv3wAIEO80aaIh3bKQwzBGSyeS29Hxy0=;
 b=ZChZ/MUqHxVXn7Tl5IssVh0HtZLmNmzLC8u+YLta3vl9ub6s2jIvHF3X85uy9W5H8t82AC5afWP/6UzVOqbLjCutjytWYNpo6kSUIZ3j2cYAO3iiRan3UzKiTuwBi1DwVFUj+5E1J20Nx16t8l/I4J6eRMSWXU4XguTFLb4nbkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 2 Feb
 2026 14:35:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:35:35 +0000
Message-ID: <b978d83d-3bd2-4ef0-8a2c-eb756a880fa4@amd.com>
Date: Mon, 2 Feb 2026 15:35:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd: Check if ASPM is enabled from PCIe
 subsystem"
To: Mario Limonciello <superm1@kernel.org>, Bert Karwatzki
 <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260201002446.1293486-1-spasswolf@web.de>
 <02fe7f9e-f25b-4b6b-8420-57de982147bd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <02fe7f9e-f25b-4b6b-8420-57de982147bd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3adbc0-ff95-4684-3e29-08de626853a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akNsV09rMXEwWldlRThuT1d4aHM4RlBTUWtZRVBmaXJabEF1SnRvdUZ6emNY?=
 =?utf-8?B?empnZ05RMkpYQ1JzSE0rRWxoQUM5bUlqeXBUQXV2WnpTLy9WeDJheFYybHVT?=
 =?utf-8?B?R29YZGJLYjNNb3VldjRzZDBkU0lRY3pQZkhMeWZHRmtpUFBlSkxkd3ZGZ1hQ?=
 =?utf-8?B?My9TSlA5YXhyMTBxVWF6N1EwOWlzamNnczBvSUxJRHF0ZldSNjlMVDhsazVY?=
 =?utf-8?B?dFRNcDUyT2lsM1VpZkUxOHdHZzBuSTBpZTg2SDl6by90WXpLand5MUphMVda?=
 =?utf-8?B?Y1J3UHpSZ1hFSFQvL2o2YzMwd0FzZjJKYUZURVdzc3ZaSjRvd3VLb2dDWWVn?=
 =?utf-8?B?ZExkWmp2MTdaWlZaV1FaOXlDaHZobVBYN01oalFxZkNLTTBySGxadFhLUkhS?=
 =?utf-8?B?K25LVnl6dVRVb2FFUGdPTUNjUWhGblFtd1JDMktIVkc5bGdKSkU3aFU3bjhp?=
 =?utf-8?B?RDhMQkNHMmQyNmUwdHFnQ1p4T0RiNEJ6MHV2TldKZFVaMExKeEI0d3VGUko1?=
 =?utf-8?B?V3lZOW5wT0RVMVUrS2IwaER0K2xPNCtHY05yRmc4RUprYzJueHlURkdaQUhi?=
 =?utf-8?B?Vm9MN3IvNGhxQ21icWRPazZacUpFaXplTEUxVlF4NGxyU3gvNXE4Y25zZ3pp?=
 =?utf-8?B?T2lOMFMrT3gvM011Y0Z0T25WNTA2dkkrVjVvc2RiaEI0cFhhL255azVlNGV3?=
 =?utf-8?B?dzlzWDZiU01DMmFjMTdhcnVwREVWZngzTnI4OWgrUElnZU1KRjdiQ3ZOeUFF?=
 =?utf-8?B?dlJIS3B6L0FlWHpqTVM5SmRoNFZjSGlxSlJUY1JLRzFrdVdtMk50M1YrWWpa?=
 =?utf-8?B?bkhJeXNXQzRINTVzYlZvR1BqYkg0VU1MWHc4OUNiN1NpeEhPdGMzZm56SEdC?=
 =?utf-8?B?eWR0RWMwSGgyRmtScVRzRDRWekhTMG5uV2owSEZsNFovbmpnSHFaN2trWmR6?=
 =?utf-8?B?ZThVTE5ZQUJjbzlqSXJ6clE1aEhodHdkMzVCRDNsZzdRcjJYLy8wUnZscUdY?=
 =?utf-8?B?Yk5EZFF6NmljQXBiWUNwTGtaeWdtS29POVFxYXp6U09vaG5CNjVvV0NpN1lI?=
 =?utf-8?B?VGN4bFdBZFRvenJwM09uVUxaWiszVXZMYUd0TitRb0poWFNZVUlxN1pKSith?=
 =?utf-8?B?WGNFUGpIT09EQlpBU2s1Y3MwdTlRalJsOE5DZGFjcVpUMWdXcGFzb3pDRXM1?=
 =?utf-8?B?NkJMcGQwSlhLd1ZORTZCNFlZSk1xbnhxTE8rV296TzBNS1NxQnRNSno2Tmln?=
 =?utf-8?B?TFF2U0l4ZVJOZlpXMDBFUmxRTkFWRndKeFBDZFJzZ0lWTkF3RW9GS25mcnZT?=
 =?utf-8?B?akpLRVBJK0tRcHEwN3lBdkdHNVdxSkhEc3pKSTBsMWlqcUl3NlZ2Lzl5c0U1?=
 =?utf-8?B?aThITlkvQjArNzN3VmZ6RE5zQ2FsSUJNdUxMQ2lTTXloZTYzMVlicS9lVGxP?=
 =?utf-8?B?eUtuQzdJLzZNVno4QTBsY2ZTeUNuOTE2aGIycDVIVXZreTVPUUxsZWZGM0sx?=
 =?utf-8?B?Sy93MjBFQmo2emZobHQwdGNqMjhYQStCbEhUYm43RGthZmxhU3lNRDBZVzJu?=
 =?utf-8?B?TGlIblFmeWtMa00rcVRGNEJzekkwM2pwUys3MGc2WnFMRDVFYkF2eHltVjVE?=
 =?utf-8?B?VG1jRGIrT2YzL3Q1WG83czBBQ2I3N0hZampXUXNUdSsvL2Jhak05dTAvMnJO?=
 =?utf-8?B?Skw3RXlxekxDTDRIaXk0RkhuTmMwNkQzSTlPdUcrL2VjdEpHbjJCb0hJVHAv?=
 =?utf-8?B?RnlOLzBVM25RMzZ3U2tsNWJ6QUM1N1hhUXR0ZFB0Q0J4T2gvVFFzL0dFaW1I?=
 =?utf-8?B?Qzc3VlNmSDFzR2RsRlIyc1JVRUxNajkwczVMUG5zbUNkSTFzamFBcGNWU1Rz?=
 =?utf-8?B?MklEa2l1R3IreUhhTGJEOEhpdGRpbENaUEdUY0JCTktwekdMcUJrOUhEM1Jr?=
 =?utf-8?B?MDRoT25nTzhPdlFuRnV4Q3VieG85OVNMZEpQZHA0WnpzR0c4V1ZuelZtQWNE?=
 =?utf-8?B?ZjFiM3FLSWlTeE9rbE9SZGl4SGV2UUZ4NmJFZDNpWHo0RVRHRkFtdVo2QWZC?=
 =?utf-8?B?eVAyVUNQU25qdzVIMDhndENWem5nZm8zS0h5VW5xSmcwTEY5TEl2STRveEhv?=
 =?utf-8?Q?8b4i4ZMqOMUMuD2nSTS/I6xMQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRSYU5QbXVNN3kxVGovMHBwTEI2Mkw5em9qVEpZb0ZMZVFHNWpqaG43a0RI?=
 =?utf-8?B?THgrZHN3Z21kL2JlY09qODkra21odVZMV2VMc2RrRmdGZnhUVGlwdU1PejRm?=
 =?utf-8?B?NTR2YUdkYkZKQjVTdlI2Y1RJTktqU0xyL2ZUa1RCTVgwRGRUOGovckI1SFR3?=
 =?utf-8?B?cDl5cnRaRFVjUS91MlJoTVMyOGdFSkxyS1hjUDR5QVBsUEp1bENMVWZtUml4?=
 =?utf-8?B?eis4ckZyZEVvRkhmc3hJZXdUaXZ6TXFEZlU2eWR1dGppdTBPNm9uc21GaGtD?=
 =?utf-8?B?MC9IbXp3WVJuaWdpM2tkcGlvanErL0xDV05wSEVHRFV1Wk44c0dSamNFZHdk?=
 =?utf-8?B?b054S2pKd1BFbG0zdHQ0N252anAvOWM3bnF6MytwdjlwSnNaWWtFNXFYM0xi?=
 =?utf-8?B?bHdYMVhvcTBUa21zdjdaT0hrRThvZEpMVFF5Ym8xL0I4Qm5PY1dFZmNnRXIw?=
 =?utf-8?B?ZTdLcDZjQkU3eFJOQW55K3lySHBwUFNDT1pHQ0d2L0lGZm5PNmdaNjRnRnFG?=
 =?utf-8?B?NE9wdHlXTU1sVWh4bXhyUTJua2hGR0h1czFDYnpCZ1lBcS80WERSWk92Z3Ji?=
 =?utf-8?B?Z3FRbHpkSjZrVWVVUENRNmZrQ2ZSa1pBaUV1OHFReTN2S2xrbUZsem5IbUNj?=
 =?utf-8?B?cnVyR3hBWWp5LzJ6YVRLWFNybjB1SnVwM0VOeTFTUk8yWkExMzdFSncxUElF?=
 =?utf-8?B?bHNTT1B3Um9Ib0pjQS9yR0hJeUVCYmZVVm1OZUo2aE9NZTJGUUVsWXRNZlJR?=
 =?utf-8?B?clYycjdrUmpRRzZHd2I4MHQzeHdnZ0UyZUZqMyttOWJvbjlZbnFhY2JEbGsz?=
 =?utf-8?B?V3lyWWJyNlFZOXhpS0gwUDk0K2pZSDZUQVZkeXMrcnd1bURoWTNNZFFicGtO?=
 =?utf-8?B?S2NEWmM0VTJ4SU5qSDJFeHFEUi9LU20wU3pLRXdVNEZBSWQ3dEVMMVQ5YTRy?=
 =?utf-8?B?Y1FOTUpON0Fsdm5nUlNjL3FsWEV4Kzcvenpzc0dicWNxZHA0T0NNZGpQdnc1?=
 =?utf-8?B?cmNidE9QVXhNeitRTTBtalhLT1J0RGlwYVZUTkNSVjhoSE5weXo0VmZLdDA4?=
 =?utf-8?B?K1loOTJoeVVLaENzTWlMTFoyM3h3eGRpbEFneEpxSzZ5TEVuZHBuVTlPcG5J?=
 =?utf-8?B?Um1kRU4zQ3AwMXU3NWVheFpEU2JyN2RkNUNaMEJJNnpVWEhQUGdiQ1AxK2p1?=
 =?utf-8?B?QnFhL28rS1dJUHB5T1VTR3VFNENab0RaVDg3NTYyYW0vYjNCMFBjRmFNT1dI?=
 =?utf-8?B?bS9MaFFQbG5UemRUa2NNMU9uSi9TMzFNanZuRW50cVE1dVpUZEkzOFUrYUs2?=
 =?utf-8?B?WGsxUFBXRU5UUmRTWkRUZ05pa0ZsQ2J0c2wzOEY3TDVhN2FLaXVRWk9JOHdC?=
 =?utf-8?B?NWliT2hJeThURnJEL0tOMjJocitYYjlFSXBVeFllelppcnlsdlZyS2c1Tnlq?=
 =?utf-8?B?YlRKcUN1dVZDVzNOY3I1aWMxd1VpTXM3UDhaOTNsSnFySEZINC9qaHpWS25M?=
 =?utf-8?B?MnFGbTlzdDlabWdwcWNlR1B0KytxeVdQM2t1WVlrWmN1OGttcVRyTWJHdmpx?=
 =?utf-8?B?d2JiazVKSFlZU2FDaFc5TWZCc2FaWUV3ajRjNjNhZGh6WnAyMFhCeXVINStX?=
 =?utf-8?B?VXBSbGdsNmEzVjlua1lXdmJ4RTkyTnJORVpib0NXVGsxaWNKTmFad2cxV3dZ?=
 =?utf-8?B?WFlqakM1YTFEbkZZYVFZR052RytOWXcydFBPdHZlUFBsMnMweFdPMmNOLzZR?=
 =?utf-8?B?QlE5alpOSnIwSGtwYlFwOHMralVSTWtxS3hUcjRhczhrck53QUl5eThKREJ2?=
 =?utf-8?B?VmszLzN2NWI3bkRMOVBqcll6YUxzakZvUG9IUlNlSHFpeG1BME4zdjVFcFZW?=
 =?utf-8?B?WGtmbWlxUlhObk5GRXFZUS9pUmE5anIyeFVYVDFuWVlJVWJaYW8ySEtJVWFI?=
 =?utf-8?B?VXhzUXc4SVA0VXhSVjZqVk00RElJOCtSak1jZXhWMm5NTHMybkJneWtOY0Vl?=
 =?utf-8?B?OTNpMlBaK1pCZXIzTzlweGE5Q2ZxMGxOaFlMeGVnaTJKcEFyQU0zWGNZMmhq?=
 =?utf-8?B?cFhRYVlNMWVrQktkdUxyS3BVL0VXVDljRUhKWjBPLzQyWUFvdG1xRlRMN1NT?=
 =?utf-8?B?bk9vQnN2WEN0OGluNFVMMXBWQ2pheHVNT29tNFFad0NVSHBvN25wWWY4T0ln?=
 =?utf-8?B?aUdnMEJHWjY0TjdmMzdVeExDRFoyaXZ0eTUzbXNLamtEei9SdEhrcy9CM3dO?=
 =?utf-8?B?MjhObTVReEs3anZsSmtEOFh6S3oxd01Rc01rb1g1TllFTHZkdjI1SmptOFJT?=
 =?utf-8?Q?HxL4J2OND+SnfS1BIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3adbc0-ff95-4684-3e29-08de626853a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:35:35.4169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qgDwBVFkQfI8CFGWVDHVrYDs6QwEaDjPnbuq3ys+WHU7J3dTKj39TmStTYrxolz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

On 2/2/26 15:25, Mario Limonciello wrote:
> On 1/31/26 6:24 PM, Bert Karwatzki wrote:
>> This reverts commit 7294863a6f01248d72b61d38478978d638641bee.
>>
>> This commit was erroneously applied again after commit 0ab5d711ec74
>> ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
>> removed it, leading to very hard to debug crashes, when used with a system with two
>> AMD GPUs of which only one supports ASPM.
>>
>> Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@web.de/
>> Link: https://github.com/acpica/acpica/issues/1060
>> Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
>>
>> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>> ---
> 
> Amazing detective work, thanks so much.
> 
> This added the code initially:
> cba07cce39ace drm/amd: Check if ASPM is enabled from PCIe subsystem
> 
> This effectively removed it:
> 0ab5d711ec74d drm/amd: Refactor `amdgpu_aspm` to be evaluated per device
> 
> This was the accidental re-apply:
> 7294863a6f012 drm/amd: Check if ASPM is enabled from PCIe subsystem
> 
> It looks like this as right on the edge of the 5.17-rc6 and 5.18-rc1.
> I think drm-fixes-2022-02-25 and amd-drm-next-5.18-2022-02-25 ended up with different content.
> 
> Nonethless this is the correct change and I've applied it to amd-staging-drm-next.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

There is just one major question left: Why is disabling ASPM causing problems?

I mean we had tons of problems with ASPM before, but only by accidentally enabling it and never accidentally disabling it.

IIRC we even suggested to disable ASPM as possible workaround.

Thanks,
Christian.

> 
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index d6d0a6e34c6b..95d26f086d54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2405,9 +2405,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>               return -ENODEV;
>>       }
>>   -    if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
>> -        amdgpu_aspm = 0;
>> -
>>       if (amdgpu_virtual_display ||
>>           amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
>>           supports_atomic = true;
> 

