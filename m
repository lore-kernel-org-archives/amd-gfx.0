Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8966DCCF2EF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F17410E432;
	Mon, 19 Jan 2026 12:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWaf5qw7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B122210E432
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOvLCBVtgDHiQgoEHT4JPHxl6RsOYoFnGhUkrszl5oX9nUSOMXAHNg6XeNwgC/n8lXL5qyt81fiPUwzpXd1JC2fWSv1GCOQU7x8TILGCsD/2xUwpmHFuH5Q8YfNEotcgCGNCAfNatNuoAFgRelZ7C3ZQ1S8LE1uNRE8OVhaR7pSI7I1E76lR34/w6EEiwnV13cZT1/cgO01S6QfbCMs2wRLP9Xh3G/xB2R9UJzpkb76VHRbkMuKIPiLbwGsfYfh7d8REonz58q+IavTr1LXUcaGNNz3GYPn82oQf5qPhnuDlZDmWdNX9k5tdhNCPi1DLne/sbuPjIevyAnZlkKyRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITxKl8riKIVf3SAp9f9cPeUYUE1nClC8EWRZhfbeT6k=;
 b=ggcsM3bcOkhBwAlkQ30OZOsJTQbky4qcvixsNJwBvjo+4sd8dHfMjOIxvC1L04w3Di8BNhQdwWzrZ+9cE+LUSwMP+qhws8O4JMHOpBL5QopyeKT2a9DfStXUddCzTQJ7XztlkyFY2WI1+WexKq+KoHcDdWbJPnrrn1+rhIkb+/Jv+1FftOiNiIQQAmW9PNtlfSJaLo+lGYwsVv/15vfBfk9cbHNf+H0qiG6zb8cP8GhqhX9/VAbWZ2dK1plwZtp+o1sLj49TsRFfD63CCFh72caoutInYEP70bNhEmS/9VE6eiko8Dif8RnI1RNviNX0yCiEm+LFUhQckC3oD72mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITxKl8riKIVf3SAp9f9cPeUYUE1nClC8EWRZhfbeT6k=;
 b=pWaf5qw7yIk8eT1CcW/v9KsVBMonH2yP6AGSZOxERS0e3Tyrat0adGfLz8tNJ6lHl6dkX1fcgqMJUSWtDur6aau27/ixqIUAcoHT4vatRDJMJ/nlJGNfJXNkzXPgR36XbX8M+XmB/hnmrY5kqkC+zw9D2nXwiwdP63h1SI+4YJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 12:41:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:41:31 +0000
Message-ID: <ee389085-ecc7-479a-af3a-1fdd9d1cac95@amd.com>
Date: Mon, 19 Jan 2026 13:41:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/amdgpu: require a job to schedule an IB
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-6-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bf04e2-cff4-490b-45d7-08de5758121a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnZ5YWdDSHFJMGZySlY2bExYMHFSbi9pRzRIdzJCY3ozWUhtMVQ1SWxLR1d6?=
 =?utf-8?B?akwzeUFYbFZLQW9tV0FIeWZaTUVpZ3Z3WGNSS2w3dVRNN3BFckw2cGRDdUNU?=
 =?utf-8?B?SW5RakdPdjkwUmcrZG11OGdhdGFEYTMzYWt5blVhTkJ0dEhmdW9rMW1mNXEr?=
 =?utf-8?B?SHk5Y3I3UUVGRHZJUFF6cGdaTnBRNUZrU3NscUxYd0VhbnMvQ25ZTXovRWEv?=
 =?utf-8?B?aEY3TXgvaDhYK2J6b0pBZEZ4dGVBWlNhS2ZkNGozS2w4b2FvcG1RSFdzSVND?=
 =?utf-8?B?L056UVhncEx2Sll5aHI5MXFqbXZhNVVDaVoyQXIxN0ZYRis4VGd1QmNuRDdG?=
 =?utf-8?B?ZldCbFYxSWs5QUIxQTcrUWo0ajBkUmhEY3pEOHBOb3I4WlJoeUg5SjRyWW5I?=
 =?utf-8?B?V2hXS3I2Rk1PNng4MWo2UUVOVkhRcXNid1FBQjArR2JaU1JOTFFVZDd5c1ph?=
 =?utf-8?B?WHRaTUlRYXdGNE9MZlhUcHY2bEoyeXRxZHJiT0prcWVhMllJNXNTQ21iRFpD?=
 =?utf-8?B?Uzd5UTVwZlpSNjVGUmhCRUlQZzcrTFVSY09Ubm5GT1pKS2RDRk0yejd1ZWVh?=
 =?utf-8?B?R3orRE53UUNKYUcyR1plVjUrUzRObTRGNGQ0VHpoUDF5ZUtqVkJFUDRrUkJC?=
 =?utf-8?B?UkpEVjRWczdZR05DRU8wZkU2V0pFL3l6Mk9GNk9uRnhmakJVZFFuSHNJQ1FN?=
 =?utf-8?B?RlNZaVlYSEZTZndTeWRHdDlMbGkzNzhGT2hlWFFFT2dXUDMrek9vOE9VUVZ4?=
 =?utf-8?B?UDFBN3prcjFwQkVoNzhRQ1VZVnpONnNvcS9JdldBbDRGNWg3bVA3RTdZbElt?=
 =?utf-8?B?cmdnVEZ6dGV2VTlRV2FPeGc4MUpyckRBNTIwZUZ6b0k4Wmh6QmxFTnhIVVZS?=
 =?utf-8?B?emxYMFkvSUpidUttcit3b3M5TjFKbkpzbGxTWmRlSExKTFBtbW1VUUtlL0Yr?=
 =?utf-8?B?NmVnWmVIMVRPcTdzK2VyUDlTUkRFTk8rb2xOTk5xYUYxTnYzcnRtQzgzeTlo?=
 =?utf-8?B?YmFjd2dYTy9FdVQrSnlxakx6czlzcGxtSGJWN1hDS1o2eUNEODJRTGJaSzM3?=
 =?utf-8?B?blZpQURaVUFPbEgrZlZPRGVUNjZIeUFCeElkMzhpUFFsMDc3Z2sxNVM3R2dt?=
 =?utf-8?B?TGVUakMxOUJIUjNPMjhXOTBwWGN3ZnZuZm54ZlZUaTZDQlFnZ0VSRFBHMGwv?=
 =?utf-8?B?QndIeUZMdDZyaGZhMGMvK29mNWJVdTdzTndVL0dhWmpHWlc3d3N6cXE4bm5j?=
 =?utf-8?B?UlNzOFo5QjhWRkxnTFJJSUQwQUQwSWJqRFJBbHZ1elBrKy9Za04wZzIyZlpL?=
 =?utf-8?B?SUJhMklEUGdwbGZrNU5DQTQ2RERyQ2xiMUZNSU84dTdSOVkvYkEyOVRoTjFO?=
 =?utf-8?B?QlJHWmZZdGppU1BqdjhEc09XTXJBbWwyaUV6OTZwa1FaRUg5c0c2dFdMKzNG?=
 =?utf-8?B?emV1OGFVUDZZbEtOaW82bGlQa0dKTU5vdUVtWXpVWTJFS2tLVjdYaHY2RmxV?=
 =?utf-8?B?RnlyV1JvUmdjTlJLNVJhcW5wWDZCYmM1TVRzSlBwRFNVTFlCb2lrSEdFL1pY?=
 =?utf-8?B?a29RYTRjZlY2cVlxM2FsdzdHUCt5dmNXMG5kWVBxbFdOUjlJVWV2c1hzZXFN?=
 =?utf-8?B?YXdSNU5ZdFJJRUdiRFBab3FuK252eGlvTmlSSnRCOE1kTzA3KzVMdkpScjA1?=
 =?utf-8?B?eGRUcldyeWJDT1ptbU1kNUNTa1pCZHFqeGhRb2cwZEJuS3pZSjVpTlZBN3FI?=
 =?utf-8?B?MUN0TzdIR1NJTUxJM0hZVXUwZDY0MExUampXUlBmdVE4VjBnbFY2RWFlQjV1?=
 =?utf-8?B?YVZxNTVTVTRoc2NTMisvUkZyN1BzMUhmUVRXS1g3amNQenViSWlSZjNxWWdn?=
 =?utf-8?B?SERwaDM2czFablZrNkIxRndaTTMyR053Vkc2NFdRNEQ1U0FwL2xhb2FPM0FM?=
 =?utf-8?B?NENyWVJGVzEwaDZoMTlrTEpkVE5ETkRTWVFnaEltVXo3ZnNWL3BYZXc5clpx?=
 =?utf-8?B?aFlCNmU2S25nUndWNmErQWRwd3U4ZlFtbGw3cEhRZURvVDR3Q1JDS0FLR1p2?=
 =?utf-8?B?NFM1VkZuMW9kMmt0VkY2ZUNnbEY5aUFXN1VJZ2VLbmNVOEpDcE1wajFDaTRq?=
 =?utf-8?Q?9ziw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NaVEYyWG9oMm94Z2MrZ3d4bHB5SDRmdWFURGMwekU3TmQ1N1pFZmdaWHpF?=
 =?utf-8?B?U1pXWWtRb2RjOW1LTVVtbk5VZXR6bTliSWZxYnZZdjhsR29zeXM0Um1SWXJq?=
 =?utf-8?B?QVVJRFZ2eWZ2RGl5WDZHNmsrcTRvRGpkYitmVVBQOXYvenhReE9Wa2lDYXI4?=
 =?utf-8?B?UUhoTlNlMVowNU04K0hxR2cvK2lUeGZKWERDdDR1eFlIcWxXUExTeUtHRXlE?=
 =?utf-8?B?aTZxT1pkZjFwUWgxNzVSclZ6QVNOSUJmVjUrNnQzNzBUaXEvQ0JySW5BNmY3?=
 =?utf-8?B?T2t5VUZvZS9IZEVoRWJTVE5RQVBWU1NqUjg2MVFnUlhCL2hvS2xMVHd4d2hY?=
 =?utf-8?B?YlhIdXFpL0pQREdwNzN3WU1NVXkzWnJhcmdkYXpzYVNTNkZzWjJVYUpndmZH?=
 =?utf-8?B?TzdPY3V3eVM2VlVsaFBHeXhCdW5yTGE1UHc2Y1RRSUVsZHprTTZIODR3dFVM?=
 =?utf-8?B?RW43NDhkQ1NERDZxNndZTXNsa0orYmpYcWR4a3cxUEZSd1JLY3JVZERkSUpZ?=
 =?utf-8?B?VEk1bUc4cXRQSTNoSmNKc2JURDUyTWpCVGJrdHFYbjg2WkMvdCtWeElCc094?=
 =?utf-8?B?Y01QYmpBZlAvUXIwTzQ2NW5KZmhCemRHUTAvelZiSDU0MXY0QXdaSEJnRkM4?=
 =?utf-8?B?L2xZdzVXd3E1eVlrWnkwWTByL3h4bHE4N1RqQ3krTE9kQkV5bng2aDljVjI0?=
 =?utf-8?B?RWVXWTRTSHBtbUl4YjhrYWxoRzdWbkJzcmFmQ0h6NlA3bGMvYURMMWpFRVRI?=
 =?utf-8?B?Vk5PU1RDRnNtVUM1eUpvWGdhREpaeFI2OWdPVXBOMkRxelI5TGM5c3V6QTdz?=
 =?utf-8?B?cWpRamo0Q2ZEZyt3UTJzSEFIRG1nL3dCL1hmd0tBRENSbTVsQzdReklQUWhE?=
 =?utf-8?B?djJJdTJNTVcxb3QzK1lGRE1uZWpxWkJpNWExaVBaYnhTczE1Z0RYU05zVXdX?=
 =?utf-8?B?S1ZFR29pTHdraE9EL3JxYk1LNDRPcVF1azJFR0xRWXR6KzlLWmxaNnBlWG5m?=
 =?utf-8?B?UzJValMxRWpWSmVZSStCaGxVSlFsUDFBVHkvbmtCdW41aThSNmlFTEZHbkhp?=
 =?utf-8?B?Q0E3VnJBUTdBYlVLblZ6elBCVENWRUhsekVLRlVZRWFsMzhrQkwrU0NwWmVE?=
 =?utf-8?B?K2dmNVArd0FoQzlUbEY0NFhKTDBzK0ZPV3hUOGNlRXl5V3ZtNmhvdHNvTHI3?=
 =?utf-8?B?S0ZBckFjOWpkU3JqaS9GWFE5bGxPeEpRcmhJenRvdzBZZSs3Rm9CQ09CTGo5?=
 =?utf-8?B?UFhpdWlHVnU2VUZCS0V2OEY4ZndGTUM1dHdXaXdORTBKaGV2TGZUUnlMckdP?=
 =?utf-8?B?ankyNUVYbnRNdjFJbUNXeE9hc2RDTEh3Y0ppZnRRcFBlVytkMTBUb1p0WDk5?=
 =?utf-8?B?UnFsejZQT0pqNlJhRVQrdGx4R29yT1ZUd1RFNG1sTzhpQVFqKzNFeGZJbDd1?=
 =?utf-8?B?K2ROMmxZRWtmTm54VndnMGJRZjFUcWt0Wm1uSkE2MmFocng3M1RrRmRmOHlJ?=
 =?utf-8?B?MHRVNDZtdVhOczRZOSt4eWhMOEI4ZUlqN3FnWitubWNMRDk5a3A1RHFIdy9s?=
 =?utf-8?B?NTh3Q2tkbFBVQjlHczRZcnU0Vm9tT1JXOVlqcndqUGxxTC9aajF0WFEwNFVy?=
 =?utf-8?B?ZG9nRHhCOXd2dVRVQTJtemkyQkE2ck9iNjRpS3JhalpRWCtWOUh2NGI5YXJs?=
 =?utf-8?B?UmVwYjhrYW5BajZEM3JHei8xQUNPM1pKWmtObUdJMEJ0L3NyTGtncUdabVda?=
 =?utf-8?B?N3g1TnJOOTdSelUzY3BEcTMvVThsSzQyc3llRHFCRUEvejN2aG9IaklRODl1?=
 =?utf-8?B?YlRUU0l3bjh4RkJuUzVvQmVBMEEvR3JkTDN0TktlWk5YdU9ySmpKMDBaN3pS?=
 =?utf-8?B?Y09SUDJPQUhFQjlqTGtvMm9QZFVzRmxyUmRiRVVHUy94WmRmN2dvS0NOM2xy?=
 =?utf-8?B?bVAvdDRBaWt6UG9UeHNYSDRJUHpJcUZUaE9HcUc0VVAycXZQSGYwU3kxTmp5?=
 =?utf-8?B?anhnYzk1YjdocmRGclIxN0VJbGpkdEQyUFNDcmFYUG9odGlXZSt2cUlrQ2dQ?=
 =?utf-8?B?My8xZUdIc0UwbjJHV0FWQlN3NDhKVEZ2Z2NJUjNqd0ZkTElLdFJsdUZncmgr?=
 =?utf-8?B?a0ZLcndNM1ZwUXczR2o1QUpaMFh2ZDhlY2doQWVSR3VOVVhSTUV0dVJvZHk1?=
 =?utf-8?B?RExFVFdkY25ubFpGSEwvQUthV0FqT0RxWXUrbVQxa2NHeWx6ajFuYlQrRldv?=
 =?utf-8?B?S1RGeVBIUStqWFdWZXJZOGNMbVYzWm41N3lMNlY1L08yVWVKcnVPYnJJTTY0?=
 =?utf-8?Q?xl3CfElcGRgS/tLAh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bf04e2-cff4-490b-45d7-08de5758121a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:41:30.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjB1ssPXHWS80X0yUv3ZAuGJoRwxe2m9HY3X9rkTqD0UfIOjBnJqXWmm3S5yRRRM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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



On 1/16/26 17:20, Alex Deucher wrote:
> Remove the old direct submit path.  This simplifies
> the code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 106 ++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
>  4 files changed, 45 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 877d0df50376a..399a59bf907dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -686,7 +686,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
>  	job->vmid = vmid;
>  	job->num_ibs = 1;
>  
> -	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
> +	ret = amdgpu_ib_schedule(ring, job, &f);
>  
>  	if (ret) {
>  		drm_err(adev_to_drm(adev), "failed to schedule IB.\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 136e50de712a0..fb58637ed1507 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -103,8 +103,6 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
>   * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
>   *
>   * @ring: ring index the IB is associated with
> - * @num_ibs: number of IBs to schedule
> - * @ibs: IB objects to schedule
>   * @job: job to schedule
>   * @f: fence created during this submission
>   *
> @@ -121,12 +119,11 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
>   * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
>   * to SI there was just a DE IB.
>   */
> -int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
> -		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
> +int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		       struct dma_fence **f)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib *ib = &ibs[0];
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *tmp = NULL;
>  	struct amdgpu_fence *af;
>  	bool need_ctx_switch;
> @@ -142,64 +139,51 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	unsigned int i;
>  	int r = 0;
>  
> -	if (num_ibs == 0)
> +	if (!job)
> +		return -EINVAL;
> +	if (job->num_ibs == 0)
>  		return -EINVAL;
>  
> -	/* ring tests don't use a job */
> -	if (job) {
> -		vm = job->vm;
> -		fence_ctx = job->base.s_fence ?
> -			job->base.s_fence->finished.context : 0;
> -		shadow_va = job->shadow_va;
> -		csa_va = job->csa_va;
> -		gds_va = job->gds_va;
> -		init_shadow = job->init_shadow;
> -		af = job->hw_fence;
> -		/* Save the context of the job for reset handling.
> -		 * The driver needs this so it can skip the ring
> -		 * contents for guilty contexts.
> -		 */
> -		af->context = fence_ctx;
> -		/* the vm fence is also part of the job's context */
> -		job->hw_vm_fence->context = fence_ctx;
> -	} else {
> -		vm = NULL;
> -		fence_ctx = 0;
> -		shadow_va = 0;
> -		csa_va = 0;
> -		gds_va = 0;
> -		init_shadow = false;
> -		af = kzalloc(sizeof(*af), GFP_ATOMIC);
> -		if (!af)
> -			return -ENOMEM;
> -	}
> +	ib = &job->ibs[0];
> +	vm = job->vm;
> +	fence_ctx = job->base.s_fence ?
> +		job->base.s_fence->finished.context : 0;

> +	shadow_va = job->shadow_va;
> +	csa_va = job->csa_va;
> +	gds_va = job->gds_va;
> +	init_shadow = job->init_shadow;
> +	af = job->hw_fence;

I think we could also drop those local variable now as well (maybe except the VM). They are only used once or twice anyway.

Apart from that looks good to me,
Christian.

> +	/* Save the context of the job for reset handling.
> +	 * The driver needs this so it can skip the ring
> +	 * contents for guilty contexts.
> +	 */
> +	af->context = fence_ctx;
> +	/* the vm fence is also part of the job's context */
> +	job->hw_vm_fence->context = fence_ctx;
>  
>  	if (!ring->sched.ready) {
>  		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
> -		r = -EINVAL;
> -		goto free_fence;
> +		return -EINVAL;
>  	}
>  
>  	if (vm && !job->vmid) {
>  		dev_err(adev->dev, "VM IB without ID\n");
> -		r = -EINVAL;
> -		goto free_fence;
> +		return -EINVAL;
>  	}
>  
>  	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
>  	    (!ring->funcs->secure_submission_supported)) {
>  		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
> -		r = -EINVAL;
> -		goto free_fence;
> +		return -EINVAL;
>  	}
>  
> -	alloc_size = ring->funcs->emit_frame_size + num_ibs *
> +	alloc_size = ring->funcs->emit_frame_size + job->num_ibs *
>  		ring->funcs->emit_ib_size;
>  
>  	r = amdgpu_ring_alloc(ring, alloc_size);
>  	if (r) {
>  		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> -		goto free_fence;
> +		return r;
>  	}
>  
>  	need_ctx_switch = ring->current_ctx != fence_ctx;
> @@ -225,12 +209,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	if (ring->funcs->insert_start)
>  		ring->funcs->insert_start(ring);
>  
> -	if (job) {
> -		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			return r;
> -		}
> +	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
> +	if (r) {
> +		amdgpu_ring_undo(ring);
> +		return r;
>  	}
>  
>  	amdgpu_ring_ib_begin(ring);
> @@ -248,7 +230,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	if (need_ctx_switch)
>  		status |= AMDGPU_HAVE_CTX_SWITCH;
>  
> -	if (job && ring->funcs->emit_cntxcntl) {
> +	if (ring->funcs->emit_cntxcntl) {
>  		status |= job->preamble_status;
>  		status |= job->preemption_status;
>  		amdgpu_ring_emit_cntxcntl(ring, status);
> @@ -257,15 +239,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	/* Setup initial TMZiness and send it off.
>  	 */
>  	secure = false;
> -	if (job && ring->funcs->emit_frame_cntl) {
> +	if (ring->funcs->emit_frame_cntl) {
>  		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
>  		amdgpu_ring_emit_frame_cntl(ring, true, secure);
>  	}
>  
> -	for (i = 0; i < num_ibs; ++i) {
> -		ib = &ibs[i];
> +	for (i = 0; i < job->num_ibs; ++i) {
> +		ib = &job->ibs[i];
>  
> -		if (job && ring->funcs->emit_frame_cntl) {
> +		if (ring->funcs->emit_frame_cntl) {
>  			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
>  				amdgpu_ring_emit_frame_cntl(ring, false, secure);
>  				secure = !secure;
> @@ -277,7 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		status &= ~AMDGPU_HAVE_CTX_SWITCH;
>  	}
>  
> -	if (job && ring->funcs->emit_frame_cntl)
> +	if (ring->funcs->emit_frame_cntl)
>  		amdgpu_ring_emit_frame_cntl(ring, false, secure);
>  
>  	amdgpu_device_invalidate_hdp(adev, ring);
> @@ -286,7 +268,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
>  
>  	/* wrap the last IB with fence */
> -	if (job && job->uf_addr) {
> +	if (job->uf_addr) {
>  		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
>  				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
>  	}
> @@ -299,15 +281,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	r = amdgpu_fence_emit(ring, af, fence_flags);
>  	if (r) {
>  		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> -		if (job && job->vmid)
> +		if (job->vmid)
>  			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
>  		amdgpu_ring_undo(ring);
> -		goto free_fence;
> +		return r;
>  	}
>  	*f = &af->base;
>  	/* get a ref for the job */
> -	if (job)
> -		dma_fence_get(*f);
> +	dma_fence_get(*f);
>  
>  	if (ring->funcs->insert_end)
>  		ring->funcs->insert_end(ring);
> @@ -315,7 +296,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	amdgpu_ring_patch_cond_exec(ring, cond_exec);
>  
>  	ring->current_ctx = fence_ctx;
> -	if (job && ring->funcs->emit_switch_buffer)
> +	if (ring->funcs->emit_switch_buffer)
>  		amdgpu_ring_emit_switch_buffer(ring);
>  
>  	if (ring->funcs->emit_wave_limit &&
> @@ -334,11 +315,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	amdgpu_ring_commit(ring);
>  
>  	return 0;
> -
> -free_fence:
> -	if (!job)
> -		kfree(af);
> -	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index c7e4d79b9f61d..b09ac3dda17a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -373,7 +373,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>  	int r;
>  
>  	job->base.sched = &ring->sched;
> -	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
> +	r = amdgpu_ib_schedule(ring, job, fence);
>  
>  	if (r)
>  		return r;
> @@ -443,8 +443,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
>  			ring->name);
>  	} else {
> -		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> -				       &fence);
> +		r = amdgpu_ib_schedule(ring, job, &fence);
>  		if (r)
>  			dev_err(adev->dev,
>  				"Error scheduling IBs (%d) in ring(%s)", r,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index cb0fb1a989d2f..86a788d476957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -569,8 +569,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		  enum amdgpu_ib_pool_type pool,
>  		  struct amdgpu_ib *ib);
>  void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
> -int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> -		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
> +int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		       struct dma_fence **f);
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);

