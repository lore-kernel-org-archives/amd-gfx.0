Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5898DC02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 08:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0998110E552;
	Wed, 15 Jan 2025 08:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sD1BHVki";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833CA10E532
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 08:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLX/YjDp3Aq/tAc3NsQvTOo68VmYTGet9icku+wHm1qM0WKORieIHTzmypljsVzwZI2HJtvAnqNTVbqgqAm03+htCKW/dsfbktk1JQRuPfXU1vBJ1vZBpQWyypGNtkMOo5n+LCJMBWcZfD6zY8ZfxDdGTRFrUmisg8ixzKcc4W3ddwiQcSJ+toQ6Nw6UZtX8jaqkPqJNjJpFqOvauTZ8xMgnXrghY9Umj2gWUrViPJbMlwG95y0BD0TSIYuml8L9pu1KYHLdprIKCSJo+RAr3ojYJns4oxBcndHIAYYG5J/kPZNbuiy1DGh2D8WjxzduNXxCJwBsp5ytbFHTcZXaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAVDePZZ9oCNhqsH5OF906yC3hhhoEo9CTcJi2IRf+U=;
 b=I9xdr3UQgkncccxB4erwzFz0ArOwmskoBu7pzyiGo81Ey4Bmx+FNdJ8iYM7OuRX/6MyjzjfQcXcqiT5CpOL2WjGrZ/fSGQ6RYnVfIViuzjUQcKf7RNtyYg1koTZgzZDrOnXjBq6eraVQcPlDVSGP/KPlgan6PpDW0XRL0bC+as5X6XmeqGKTdEJwMCgEHzIvozXbC5kpOCfNbQ8vIRmBB32jaETQbRdKs8Xf7AMvKM8FPMkVxo1zzL9j7CSKQp+4Da8LFD/utSJAG0Hdgwi/Z1Cxz6JpbiA2vrG/MIVoefpArOWBFUOvjBnzGFcRehn/0ORseKNw83ipSn0zJpUcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAVDePZZ9oCNhqsH5OF906yC3hhhoEo9CTcJi2IRf+U=;
 b=sD1BHVkiL7H90ox8msBOmRVqaoVE4IsaBd2HzNqr0LezAWuQeh6w3A/Egx7L0Vedx4XEAuF5ibaIeP/d2WS/QsTJD7HeRT6irt7Wt8hyvpONukRyjnRtND9Wd66fTr61IRuaAJIRt2l5GFLhj3twKQvcPhsgoLBEowwlTRIvcxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 08:32:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 08:32:37 +0000
Message-ID: <4031af6e-e5e0-4aa6-bca3-7dbf6c666d75@amd.com>
Date: Wed, 15 Jan 2025 14:02:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
 <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
 <CY8PR12MB74358329999D20A4899DA18D851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <fe31a1d4-d137-4d0e-8a63-321a5c365512@amd.com>
 <CY8PR12MB7435DC1509E304F279F6145185182@CY8PR12MB7435.namprd12.prod.outlook.com>
 <00eda50f-fb2c-419c-9bd3-2fe932cef057@amd.com>
Content-Language: en-US
In-Reply-To: <00eda50f-fb2c-419c-9bd3-2fe932cef057@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff5e3fd-618c-4e81-f051-08dd353f2a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE5zQ3F0WWZEc25Qc3BsL1F3VTNrdWV2SFh5bVZsQkYyenlzeHF3YU5IN3Ux?=
 =?utf-8?B?a0tBRlg4NnVYWitCdVlXZWhiRThNeHBKU2IzQ3ZLUzY0S1o4emN0VHBvTWE5?=
 =?utf-8?B?VURLUmJsNVhNVDBMRXYzeWhLK3lpVjdobVFCelZ3VldCbWEwZzdCUEUyNkZ1?=
 =?utf-8?B?K0JZL1VHTkxrTG9jbWVoMnl1ak0yMDhkWnF0dTlCZ3ZxMGh1REpNYWY1eUR5?=
 =?utf-8?B?bEhiemo3a3o1bTNxbFRGSC9nRXovMDIraWVuMDlNNGdmVWFaV2RhSHoxK3Yz?=
 =?utf-8?B?dGhpd2tCb3ZLVFptUEgxUW5BdlFkREpWVW51ajlTdjJrQ2lqSWQxQ2dFYXNR?=
 =?utf-8?B?cnBKQUU4aUtRYkwzNHVaQTRNVVpwSHVZUXcvbTdVb0QwRkM4ME1zQTMvRW5p?=
 =?utf-8?B?bzNvVjJVZElGa04vRGh4anUySk5Ya0hDWFN0MGEzbSszTlFpU1k5NmV3alpY?=
 =?utf-8?B?V0FtNVlBV092aml6UmxUSVpWRG9ZMkM4Z29ESWRtdG1pbmM2a0tXRXovL3Y1?=
 =?utf-8?B?aDdSc0dIdFVwYVdDN0tlS1B0OTNxSjU2K2NYUVRYL3JGS2RsbFhuY0EyM09I?=
 =?utf-8?B?dkljWDBYTDFnUnhsTGJmcEhqQ011dmg5ZWIrS3V4YkJERS9ha0tHT2JtVEJX?=
 =?utf-8?B?MjJVdEVjVEUyQjhNQ0NmK20wM3BFclp2YzNZYmZGOU9DYzdQYnJvOFNuZzR2?=
 =?utf-8?B?cllKYXJ4aGo3YTVGMUZ3VFZUMEdmcW9ubm45c1Zxbm1UbjdFVWxaTEwrV1BS?=
 =?utf-8?B?b2h4NjFWNm1waEJ4aUtkeFhXUm1rN3ZlcFBXcHR4eVRzYnJERzd4SUZtR0Vu?=
 =?utf-8?B?RTdrVzZmaDI1eE9obVBSWTM2VUdlcG0wa0pzQ2hFeS96UG9vUkEzcm5zSzZH?=
 =?utf-8?B?cGFZaGVyYk5Ia2VwVGthM0JWOTVPSXNDeWwzNEJkRlFTWWErdk9ISEY2dEps?=
 =?utf-8?B?eVYybDdwbFo1a25pRDNHZ2pOQUczcUszMzZEZ2NuMU10UTU0ZHpGRWYzclNR?=
 =?utf-8?B?Kyt4UUFxWU9DZE9hcUhTbUo3ZXQvQkExR3p3SUtoeUN1K3Vnb0xBaCsxQTlE?=
 =?utf-8?B?OEk5dk5yQTNVcWk4alFCbUNjNVRtOUtJWnBZTHBzb3VURlM0VjBuN0JFVkI2?=
 =?utf-8?B?QjU4eHFrZW0vMDRGT3R0NUtDeW5DaW9WeS85OG1DcEJmVnJMbkNwR20zRDRG?=
 =?utf-8?B?RHBRREpyUHlMa3FERjdnRVBKUVYvd09tYXRvWEpiVUEzcFZOblIzQ1RiVktM?=
 =?utf-8?B?TCthaHhsOHhjbFlLUVdJSmZDblJNTmVoM24yTmhNQThzZkI2bGhBWHo2TGp3?=
 =?utf-8?B?UFd5Z0dBRllvdGpYeE55azFBNE5ndHMyMDRDUFBpR3RMTU9KWURtaTM0bFV1?=
 =?utf-8?B?OG5HNEcyWFdYNVJzN0hJTGtyMzRWNExFS3BMSm5wVWozRkY2b1lQQ3Y2STBS?=
 =?utf-8?B?QlhZWHQrTmdzWnVvOUdlRW9ESTh6aUpzbTNwRzBqL21udElHQnc3YngyVnp2?=
 =?utf-8?B?S3hNYjVDcFl3OTVwVytBYW0veExTRTV0M1BFdjlLaDVGUGRFT2F0NjdZQnUv?=
 =?utf-8?B?aUQwdlZQU1c2OTdQcVRUTFZvU29wWXlDellJTUNGTHh0NElONEp5ZjExbm9i?=
 =?utf-8?B?aVZvN1EvMHo1NDEweSsvS2N3NzBXL1hRSzJBV3FGanowZEk4YVRJSllHcHpZ?=
 =?utf-8?B?bUpYeUFlWkhTSmY4NmlOSWJqV3B5ZWRrMWZidmFQK2h5TkQxRjNCQm1KbUZy?=
 =?utf-8?B?OFo4aVNxU3JMNklkSThickxKT3RlMnMwMG12b0VlWStmWDg1bUhiZFpmVGg2?=
 =?utf-8?B?Rjl1S3NBYzVyN1o0eHM5OTNCK1l5NnRKRlhHTUZHeU1adEdrWlJUeWJQa2M0?=
 =?utf-8?Q?eVKQDbpihktcp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFhYc2hVMDRMTHJtUk5aUmZCblQvVzBMRTZZZ0RmMXlldGJBZlBzNm03Ymp6?=
 =?utf-8?B?Q0RteVdxTXFtMEowRXJuU2p2K0pwWFR2OStGa1Vxems0U3J5SGtsZE5OL3da?=
 =?utf-8?B?TFZTVFlNVDNVUEVJWFB0RE5vSnJvN1VhaWd0M1ZRYVFjdERSbnNIZTZxZDM0?=
 =?utf-8?B?RkxFZ3ByVHovc21yY0t2ck5HcFB5L1pJbFNlNnFQT2ZGckhJNXg2dEJCOUVz?=
 =?utf-8?B?amlGczlYYlN4VmlDdHI5Ui9DUGswZG9WOG9HMS96RDU0N05WNWNsQ2RuSmg2?=
 =?utf-8?B?UU5XbGl0WlFPNnNObmdrM0M4dE9KWC9vWXFmSkdhUU1sY2tKUVNWY2RibnRz?=
 =?utf-8?B?UzROTDBTUlZNaFZLbDJRbVl4dmp4Z0pPVXlCdmNSbjh4UWluR3luVjRxaDZF?=
 =?utf-8?B?S1ZCd0NLcEZHNUFYT2tnaDkwSmhhY29SZTZoNEtpa29mRWd1bzhuYTJ3TFJV?=
 =?utf-8?B?dDk0a2h3MG9IRGZlOFlGNkJnZkQ3RlhzekFwQW5tR2Z6cVlHZ2Y5SGdJUHQ1?=
 =?utf-8?B?NzhUNUJjQ0dvVXQ0R251dGFqRk80VHFPd0xwb21mamRxR0NvQWhXZmRvNXpO?=
 =?utf-8?B?QnlybWxpK2Zma2wyWDIrbTIxMkt0NVNXMnBnSm1xYS9tYk9GN3F1THVId0p5?=
 =?utf-8?B?M3FnbXJmaW1sekN2dXJXK05LUzdpb3pEYitWUEpPSW12bmQzbmRQR3dFRmFI?=
 =?utf-8?B?NXB2SnhoUnRiTG5NbGprbEJENTZLWjMvcnpwOE8ycmd3Vmw3dS9CdVE0R3pr?=
 =?utf-8?B?SEl5RFVvNkpJTE1udElwRmxkU09aZTI3T0xxOXF0MDg1ZUd4aU4rdDNueStN?=
 =?utf-8?B?R1MyVFNjWGNsSWhBNHJrQTZtVWs1UTl3QW92RDR3MlZxNE44b3BHOGhPdHVO?=
 =?utf-8?B?SXlSVzdHTWpCZ3pKUVliM0xLK3V0YW9yV0ZKRDFRRTYyVTJjU0t2L3lsK21B?=
 =?utf-8?B?Y2syZ1dyT1BKQURhVnAyUGpoblJZSmcxK2lxWVpVOFJIdGFmTU54VHJjR3F4?=
 =?utf-8?B?TkpLRitJWUpLdGVZWXFQY1Z3Z1pIektaWU1lUnBLcDNnVmsweE4welZJU1pI?=
 =?utf-8?B?QTluYjhEUHVRUGlyQ0l0MnlEWmhKN2ZpSGE2dWhjNm51VFAxU2xRZlJVVDNI?=
 =?utf-8?B?d0RleGVad3RGd0crOCtBTHg0WjBld1d0dlNnOTBkRlNBTFl3dEhNTERUbUZx?=
 =?utf-8?B?bHFkcW5HcDZpYXI1YXFGaUtlZGFEK0JYOE9rQXdlWE8zZjZ1Z1JlcFlPTjc2?=
 =?utf-8?B?UU5IQXlEWUM5YW14NlJiRTA3WW5kbkVWL3VJdnlEM1o3MWF6ZU1VNEJILzA4?=
 =?utf-8?B?bS9EMkZhQ2JDWit2aTIrOHJkd01KUlhDMisvaGpZbzJDZXhzTlJiVXkxRjhS?=
 =?utf-8?B?bitLa3lta0dLQW9HeXpuaW5VdTBYaHdObDZCV2pISDFoZ0E3TGZPQnZVeXRr?=
 =?utf-8?B?RnY2WnJ3dUxEWW02dHBLdHNxanVaNmw4RlhTSE9OZzdaSit5eXZzbmlwV1J4?=
 =?utf-8?B?SHNvRzhVa0pkYSsrWVVBTDQwZUNFSDNJSzdpb2VoSW1TSVgyWlNvMHlkL1pR?=
 =?utf-8?B?Qk13WlJyZExQd25hVk1GbzRuQ0hTWnZndTRINzB1MDF0Q2hheERJQUgxYXEr?=
 =?utf-8?B?eWE5ejg1WEpsZ2hYeU5PcE51Um9iU3V0byswd1M2NGFuTlN4VUVHRkpNVTcx?=
 =?utf-8?B?bGdNa2h0aXFZRW1TaWRwVXI5QjVaekt0ZERXRWowazc3L1RUUis4cFFIMGpk?=
 =?utf-8?B?bHRyYU95OEJ4djQwVGVwcXVJTFFibEZPR3llK0FiMzhnb01JOTdoTmgzeVdF?=
 =?utf-8?B?ekN1bHBWTnRxMkd5dms5dWxKbE50aDdQRmIyQzBKVjRUUFJVcHEyeGV3VEJp?=
 =?utf-8?B?cFZIZXBmdCs1T3dCeC9uMnJZeHBreXdBZkVNZVlIM2lhblFvVUpIazFoaDB1?=
 =?utf-8?B?cGtKcGtBZ1RkeFhZR3dkMVV3MEZIUGgyRk1nOFp4MTdTM25wU0FVbHkxK0pR?=
 =?utf-8?B?TG5PY2VJSzFUMXJSdFlvMVRuemhuUGlvTlRwTk9Cb3dQR2hrZXgxbXVNWEhq?=
 =?utf-8?B?UnNMK3U4K1d2VXl4SzhkWVZ3RlNGQUhYMnBHL2RacENaVFRsQUM5WGtVaFAw?=
 =?utf-8?Q?YAG4FV1pvsXhLXCQA9V09ITdP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff5e3fd-618c-4e81-f051-08dd353f2a94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:32:37.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsyX5GauJvA/sI02xckXAho6oDg2OSFNrD3oh4jMYd0zWR1SoBKbsuwRGnAxfNFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
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



On 1/15/2025 1:59 PM, Lazar, Lijo wrote:
> 
> 
> On 1/14/2025 10:51 PM, Kim, Jonathan wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Friday, January 10, 2025 10:37 PM
>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>>
>>>
>>>
>>> On 1/11/2025 2:53 AM, Kim, Jonathan wrote:
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Friday, January 10, 2025 11:29 AM
>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>>>>
>>>>>
>>>>>
>>>>> On 1/10/2025 9:43 PM, Kim, Jonathan wrote:
>>>>>> [Public]
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Thursday, January 9, 2025 10:39 PM
>>>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue
>>> reset
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 1/9/2025 8:27 PM, Kim, Jonathan wrote:
>>>>>>>> [Public]
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>>> Sent: Thursday, January 9, 2025 1:14 AM
>>>>>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>>>>>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue
>>>>> reset
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 1/9/2025 1:31 AM, Jonathan Kim wrote:
>>>>>>>>>> Per queue reset should be bypassed when gpu recovery is disabled
>>>>>>>>>> with module parameter.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>>>>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>>> index cc66ebb7bae1..441568163e20 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>>> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>     uint32_t low, high;
>>>>>>>>>>     uint64_t queue_addr = 0;
>>>>>>>>>>
>>>>>>>>>> +   if (!amdgpu_gpu_recovery)
>>>>>>>>>> +           return 0;
>>>>>>>>>> +
>>>>>>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>>>>>>
>>>>>>>>>> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>>     uint32_t low, high, pipe_reset_data = 0;
>>>>>>>>>>     uint64_t queue_addr = 0;
>>>>>>>>>>
>>>>>>>>>> +   if (!amdgpu_gpu_recovery)
>>>>>>>>>> +           return 0;
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> I think the right place for this check is not inside callback, should be
>>>>>>>>> from the place where the callback gets called.
>>>>>>>>
>>>>>>>> I don't think it really matters.  We're going to have different reset types in the
>>>>> future
>>>>>>> that my come from different callers.
>>>>>>>> It's probably easier to remember to put the bypass where the reset is actually
>>>>>>> happening.
>>>>>>>>
>>>>>>>
>>>>>>> If I want to define something like amdgpu_gpu_recovery=2 (don't do queue
>>>>>>> reset but perform other resets), then it matters.
>>>>>>
>>>>>> I don't get why that matters.
>>>>>> This callback alone, for example, calls 2 types of resets within itself (queue then
>>>>> pipe).
>>>>>> If you wanted partial resets between queue and pipe in this case, you'd have to
>>>>> branch test within the callback itself.
>>>>>> GPU reset bypass checks are invisible to the KFD section of the code as well.
>>>>>>
>>>>>>>
>>>>>>> Since this is a callback, keeping it at the wrapper place may be more
>>>>>>> maintainable rather than keeping the check for gfx10/11/12 etc.
>>>>>>
>>>>>> Maybe not.  MES is preemption checks are not like MEC preemption checks at
>>> all.
>>>>>> And we probably don't want to jam other future IP resets into a single caller.
>>>>>> If you look at the kfd2kgd callbacks, most are pretty much copy and paste from
>>> one
>>>>> generation to another.
>>>>>> I don't see how putting the test in the callback makes it less maintainable.
>>>>>>
>>>>>
>>>>> My thought process was this could be put in - reset_queues_on_hws_hang
>>>>> and anything similar handles MES based queue resets. What you are saying
>>>>> there won't be anything like reset_queue_by_mes() for MES based resets.
>>>>> Is that correct?
>>>>
>>>> No the opposite.  But now we'd have to remember to put it in 2 places where
>>> there's still no visible test for gpu reset bypass in the same file.
>>>> SDMA resets are also being implemented and will probably have to be called in
>>> different places in the KFD as well.
>>>> We can look at consolidating this later as more devices and IPs get done if it
>>> makes sense to abstract this stuff.
>>>> My point is, the callback does the reset and returns a reset status.
>>>> Bypassing by fail return seems easier to remember and leverage.
>>>
>>> Ok, we have SDMA queue reset called from job timeouts. If it's getting
>>> called from KFD too, will look at consolidating that one.
>>>
>>> BTW, if this is returning a fake success, won't it result in a print
>>> like queue reset succeeded which gives the false impression that queue
>>> reset happened? Or, should it return a different error code like
>>> 'ECANCELED' since operation is intentionally skipped through module param
>>
>> Well ... the call is supposed to return an address of which queue got reset where a null return indicates "no queue got reset".
> 
> We should also somehow indicate to the user that the queue indeed ran
> into a reset situation. Not sure if that is taken care if address is
> returned as NULL.
> 
>> I'm thinking to make this simpler, maybe we change reset_queues_on_hws into a wrapper that takes in a queue type input (compute, sdma etc) and branches to the right reset call based on input type.
>> That way we only need 1 place to do the gpu_recovery enablement check in the KFD, and the KFD has the flexibility to call this wrapper where ever it wants to without having to worry about the module parameter status in the future.
> 
> Yes, this was the intention of original comment - to add at caller place
> rather than inside callback. It provides a one-place (or fewer places)
> control of the usage.
> 
> While at it, suggest to use amdgpu_device_should_recover_gpu(). This
> will give an info message if recovery is disabled, and we could control
> different meanings of this param (Ex: gpu_recovery = 2, avoid sdma queue
> reset alone) through the same function.
> 

As an afterthought, realized that this function doesn't have a param for
the type of recovery attempted. This may be added later if at all we
have a situation to assign new param values like skip reset for sdma
alone. Would still recommend to use the same function instead of direct
value check of param.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>>
>> Jon
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> That being said, putting the test in hqd_get_pq_addr was probably overkill, but I
>>> don't think anyone really cares to use it with gpu recovery off on its own at the
>>> moment.
>>>>
>>>> Jon
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Jon
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> Jon
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Lijo
>>>>>>>>>
>>>>>>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>
> 

