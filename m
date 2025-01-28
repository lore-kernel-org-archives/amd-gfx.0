Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A31C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 19:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE2010E2A5;
	Tue, 28 Jan 2025 19:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jglfSghq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0115210E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 19:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huX04eJuXTuR0+oAObyr30i6KPRlnb0iNy4E7cyIBy45JCZUZ6ccqsV82b2tBQVShkTAc6+5lLl89h1/PGcnorB1qfje0xAhp+4h7c89hncIU9LzVpu0vN3e9pPWvTCjsc3nH+5zGbI0WfeiO/pB/ZdeX81T9xtD/nvHby977e+/Y/hhT8UelBq+M6xYW3L37TOAQdD9ChStvaMT6lO6vV6MqXL8UK4NsSTR0W79XaxxUjBRnHdxYtMgSl8pXT2uSLu5mvpoGqssVbJZErc/yFnBZgqwR1xOEMK35WrnBY48i+GKVScSixqR8NZw1Oc+LozW+echYV+DdNCw4/a3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muqSBv2HkfynQwQy4+4H3mjPLuz3Ko08DwyWQUFbTD8=;
 b=M7WBXYgiZfm8mClXiYKMg6Jsbwsye5j3UvPgKaQ23ZWfxIy54gjbWNtniak/U6hKPt5VYyydpKKn+fQRAmm/qotPuLE/wOgn3vvRPm70mFukE67/4HOkJ0HisDYso+3n1s5lH03fXokbC982y6t+zZXA+ExN2JhEaWzHZ6mNCe3WPqX4daXEtwRdYU2zOY5EWpwzQH4pXijFrkdbBJ5NDGthrrf5DpzQWd9K/mafG8ZdOCIBo8H6QgPPt+vRslIsRkHatI0TESSh2wnI/bjf76RO9J6IRGlunfH1NUbL0glz8nxUpBsRx/o004IyBkc6A03KcZbuYlKp3DCCcOcixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muqSBv2HkfynQwQy4+4H3mjPLuz3Ko08DwyWQUFbTD8=;
 b=jglfSghqnNgXTO77QltolDONEtrm6EOl2+OPxlgfmgJNdMqt+dkp376lJc/qAJ01eNMDmfxdDXcBzGvhOJjsyhEgVX2aL5rxNXcDeQI4Wj6s3Zm/fMrqe0Hwi6izRhtOG0dHxKdLvdMLLUdQO6R7KhJUu9zbxk0C8tUtIv7STqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.23; Tue, 28 Jan 2025 19:52:42 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 19:52:42 +0000
Message-ID: <6e277a5f-b35c-40d9-9e17-0c104bb077e1@amd.com>
Date: Tue, 28 Jan 2025 13:52:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in
 gfx12 trap handler
To: Lancelot SIX <lancelot.six@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250128191650.598150-1-lancelot.six@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20250128191650.598150-1-lancelot.six@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::25) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 97061ab8-8177-402c-b4bd-08dd3fd55397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rzh3MitBS3hYZi9EcG04cmdsQlEzQ1hHRG0wRTRXWkpzQytEa25ic1hNRzJl?=
 =?utf-8?B?dTFvS2l6SzRIU3pxcmZmVEZwN0M0NTlSdDM1cVEwLzQ5NGlsc0l5a3VVT0dx?=
 =?utf-8?B?R0lVN0hUK1dIRWZlbWtpenhEY1grL0Q4UXN3S1J0ME1sQTRhWE81ZDFLTmxO?=
 =?utf-8?B?VWxJNENEYVYzb0ZvMkNwdUVrdGFVYXkvbjlHQlUzdmxiaHBOZ2pHb0JaWllX?=
 =?utf-8?B?cUI1YU1wdFpDYzhydWU1MEMxdWVuYWdTWUp0aDhqdHdqQk5NK3kzbUtSaGJr?=
 =?utf-8?B?UFFieW43dDY3WG90NnJ2SW1Ed05XSHh6cVB1QmNzekg1elM5a0NzWDBjelBq?=
 =?utf-8?B?bm1CVE1JaVcwVy8wVXpWcnB0OGt3NGxQVzZmU1FIU2I5alFqMmRldFQrQU9E?=
 =?utf-8?B?UzJtNVlGNjlLMExmMHRURGZlTE9zbTN1dW9yT2ovZXFKenRyazF0a1Z1VGxE?=
 =?utf-8?B?Tll4Y1NzYjBPQTZYVWxXbkhyYWxyZHFpRTM2LzlDM01LMXRUUG4raWxUZnc5?=
 =?utf-8?B?K1JMaDRvaXNGUW9YTTQzSUJtLzcwSnZ0MVR5TGkycWp2c1VIcjhZN2tGZGZ4?=
 =?utf-8?B?UmQ5L0loQUJLYWpRMWtEUlFFTzJrTHZlTDBjcXhDd0xMZmtuZkVFdzZFejJU?=
 =?utf-8?B?V1hnRjBoRlNVRGc2WnRZTkJNR2F6NUQ1WU5pZjkrY0J2SlNEUlZkNkZ1b21x?=
 =?utf-8?B?eXJESk1qVUlJQ2RDSU1lRmYxWFRhYkNXemlvSytzcTQ0RXdZbFVubng4cGJa?=
 =?utf-8?B?amVwdW9yMDduL3QreDRWaHNiQlZpNDJIdDNNa2QvRnphQ1RIbmY2d3NFZjBC?=
 =?utf-8?B?RVg3aElPYVFLczdxNVF1VTFQSnBQdTlzS21DOVozQll4Uks0WDhnd3QzYksw?=
 =?utf-8?B?Q0dxRlMrVEc3WThCNXlicUZncEoyYU1oS01zZXhZMGFxcUhDNFdVSExsY1Fw?=
 =?utf-8?B?b094MExtQ2UzZ2lZdmZERVJPUXNzMG1pSG9CSk9CYlN2d3JacGppRnFqZ24y?=
 =?utf-8?B?dGJTZC9aMjVzL3lKdXU1RlBRL3FsSm1WZmkrT1dBUjRHRDB1VmJZTWRYSnd6?=
 =?utf-8?B?QlZvOWl4NXA1MHZ6cjNvY1VlZGJMb1pHOHRnU1hPNFRiN2Fta3ZQa1FKT0FD?=
 =?utf-8?B?ZVAvVEVWdFlTeHozelhJaEF5R0pmTzhKL0p5UVFLdnQ3S295NnZSdnJybit1?=
 =?utf-8?B?Wk1GeDUwT2dVR1o3NVM1TTdUdFgyemVFa0Q2a3RmVkorTHk0SFV4a3lOdnU0?=
 =?utf-8?B?N3NmTG9rL1ZhTnFoL0l0M1EwU3llL3hSMHRBcGliT2dyOTJwSXAxTCtmTFhV?=
 =?utf-8?B?SjA4Z2haaEREWVNXMFMxUG5YMiswY0ZTYkFoRkpGYzZmTVNxQjFmRjAxek5y?=
 =?utf-8?B?QUp5VzdSSVRyQ3ZEY0dFY2RnMTVNWFRmVGdTRWxIc04wMW1kY2xTeThoRGFs?=
 =?utf-8?B?ZjEzeW9YR1Frd2ZLUUFQWkg4Yi8zMHRCMGpaM2c1a0NKRHBGVU0xNldEbDY4?=
 =?utf-8?B?Sm4xQThhbFlpWXN4Y2h2SkplczFWaVVsSEREaklzQ1pGajVXY3Roa0J2K3Fm?=
 =?utf-8?B?YmplYWdhRUFIMG15eTRUYXd2WG5JQlF3UG5qaHBzNDY3SThtNGpuL3NTSkl3?=
 =?utf-8?B?L0xuZGdJamRzM2xhd1ZoMHVWSkwrTW8wSE1TSzZPWXF4WUZ3UUpZYVRKQVhI?=
 =?utf-8?B?Mm5mWGl2ZFVZWi9DOS9TaVBEN3hkNS92b3d5TGt1dGZGMHJJazRJY2QyRWdv?=
 =?utf-8?B?UVplWGt1L1R6cVNwRXovaGw4azJrcVBoMDU1ODBtbndBeWNJZHlpREZVa3Ra?=
 =?utf-8?B?ajc3OUJQUG9ZVWtqZElGSFV2TWNkNDJHWlFOdkNVTkNJanUrL1praUt1eVVT?=
 =?utf-8?Q?4Dba04Lqnk7ru?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElHV1NIYzBNcjdYY01lL2I1aHRyQnI0cWI2bmxuQWEvWi9YM2lpdDRaV1ZM?=
 =?utf-8?B?ZmZ1b0VwN2djRUhZbjZULzZ3QTZDZFBwWW9lME9adXQzaWhvOVZnRjFteFpx?=
 =?utf-8?B?M1NRMmEvYVdEUHJUOWlwTkpOOFlCRFJKc1lwQWdwTElzdDFORnFOUjMyaVFt?=
 =?utf-8?B?c1JLb2pGTGVDYUtCN0NmUWcvRSthVXYvRG1iNGQrWE5Lc2tNSVVocG8wQ0RY?=
 =?utf-8?B?WFdFb0RsQllKa2x6S0ZlL005MWsxSXBZc1NNN0lBM2hYbVdLYXU4SlJTY2w0?=
 =?utf-8?B?dXE2ekduZkxLQkhZeEtpaTRucjhycGRpcDlSYmpKNzRkcUg5dGpwRVM3bFli?=
 =?utf-8?B?NXBrWE55elF2L0Q5cm1pNE9LQVY0ZWxvQkNUT2ZGK01YRkI4eXJMMjZBSnFK?=
 =?utf-8?B?OTVaREJVdVhzSkczSjZSd08zYnlyc2NMWkxTcDBveDZtS2k0YVJxVUhycy9S?=
 =?utf-8?B?N0srd1RTamlwUGtqTFc2a3NEUU1ta2kzMklGdXYrRDRZVm1JelFPem90L0FO?=
 =?utf-8?B?YXVXNFY0d2dlekVEMS9DcXREczJ6SUZrdVVCZjhnd1ZSNS96MXBXeWhRSE01?=
 =?utf-8?B?dVhuZ2R4Mkw2UG1DM3U2SmM2dUcxL1RrWitLMjAybzI3TTA3bFZBaHVhT1Fo?=
 =?utf-8?B?cXJDVzlOblR0elVIQTU4V08xT1hRZDdzZE9PWm1DN1dvL0NTbEgvQ1NiOHZQ?=
 =?utf-8?B?NXVyY21Zaklmd1NMZDdDdi9neW5vNXVNR1FsSXhyWGhWU1NBWll3QUtyQ2xT?=
 =?utf-8?B?ZGFIRVpSb3ZCTktHS3laYWJRR1hVWXFZY3NNT0QyVlo2Nm9QdUY5Tnlzbmgw?=
 =?utf-8?B?anI5MUp1R3ZacldTR09aYXJNWGdaVWYwem9vc3E2bnpPT3BLYzZXUTgwMGMy?=
 =?utf-8?B?QXhuZDg4aHRVVlJqVDVITVljR3VkaXdiUjhYWExLejAzaFFvSWd5NmpYSnlZ?=
 =?utf-8?B?MHl1ZmpyeGh6b0R6TlpXMXdiTUxibytIZlBlM1BnakhRU3BOZUZBL08rQ0Q4?=
 =?utf-8?B?MFZ5b1Ird2hOMXJMNS8wZHlYVytVdkh2bHMrMytGdmwydXhqTXhDUGh1bkFJ?=
 =?utf-8?B?NlNBMTh1ZEVWNUdob1Z2a1JGOE1TWG9nYXArZzJTZ3NtcVY1STFFOU9tTW5F?=
 =?utf-8?B?NGlhbkQrNHNWYlE4d1AyVFkrUkpyZnkxS0I3dGlFN09WaWxValBrdFQvQ3h1?=
 =?utf-8?B?Y01uQzcyekFIOVY2MWt5eGcweG9zUEY2amNQdmJkclNRZkFMWU9PM2Z0ZjJw?=
 =?utf-8?B?eFZjUGpwYy9ZSDJmYUJoeHNKZXBqZEw1dTVMdUNmNFlaUnhrczBoM3Z5L1dv?=
 =?utf-8?B?TjV1TC9Td2ZxS3QyVWJTb2xXYVdpTU9PV3FXa2xzdU9iR1gvNjIrVTlIWHFV?=
 =?utf-8?B?TU1hQm94SGhseURWZUd6N251Vk1uYWYxY0RpWmVFSDhXbVdid2RvTUx3VkZK?=
 =?utf-8?B?UlN1UjhEMGVZc3N0bGpDZXJlMUtxRlA5YTJnTzhMeHNWckxnQVc3RFMvSXd1?=
 =?utf-8?B?bC9oT3pqNy90TzIxMzFNSERKZ0Y4V2tVN2lnQThZa0syTGV6Z3BpdnE1ODE3?=
 =?utf-8?B?cHB4UVNZVERDQytWS3YrbllHTTI0dmtpOEdvMGgvMWRKbDZBRHJzNHhZc3dO?=
 =?utf-8?B?S1g5Qms2cS85UnU0Si94cTZmLzI2WmIvWm41dzd6ekx6K2hzV0xEd2ZaZHJm?=
 =?utf-8?B?ek0vSDZnV29qSTVtWmZUdkRVMHNvQUJjaWxjWDAzSVNQZU5QN1d0aVJxL0VI?=
 =?utf-8?B?aXZ2M3Fhb3U0NkJPWXRjOHVaTGtkSUhpYzJVeXhDN0JybWZPMzZCMVdlUDZ2?=
 =?utf-8?B?SDBmdTFFZ2h2VmEybWdENFlYNCtLdS91Y1JyeUlCR0g3SGFjMEhleW1ZOGNi?=
 =?utf-8?B?WUhCUUpEVVQ3bnFESkFSdHV0ODJScUdVTTZOdkF1SDkzRUJ4cDd4aXJ6aXI1?=
 =?utf-8?B?SG5peWh6ckxDNi9XV1p1K0ZUZkpwWFNMMVdrVTFsZWxhcG1hNlgwVUpWUzFv?=
 =?utf-8?B?c054RVVDL2c2MFJEL0lxbS8vdHVBWEVZS24zMmFzT1cxWFo5b1lJMDlxaGxv?=
 =?utf-8?B?eUpQcUs0UVQ5TGFiYkNmb05jL1JLWGs1RllzVzlVMUZ5bkpkNXpWVVdNRFUv?=
 =?utf-8?Q?a++bCQeGff8dtba5sGE6MQn9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97061ab8-8177-402c-b4bd-08dd3fd55397
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 19:52:42.2493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olLrrkQhiNZoo/d2dZKdfljEG4QKjkZySLZt0zpvmu2guAtg83ie2j7efS5UW44+BrzkPucMtppKcnwx31edAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

On 1/28/2025 13:16, Lancelot SIX wrote:
> It is possible for some waves in a workgroup to finish their save
> sequence before the group leader has had time to capture the workgroup
> barrier state.  When this happens, having those waves exit do impact the
> barrier state.  As a consequence, the state captured by the group leader
> is invalid, and is eventually incorrectly restored.
> 
> This patch proposes to have all waves in a workgroup wait for each other
> at the end of their save sequence (just before calling s_endpgm_saved).
> 
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

