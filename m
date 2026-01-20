Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AC5D262A7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 22:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42A210E23A;
	Tue, 20 Jan 2026 22:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fOOBZbJg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6B510E23A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 22:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3uEfUpBBeKsu3CiKTJORRrI6PCNFE3RSnR+bHCgEq1wo1PUS1q+Pzi6sbiPcfk3P4Bf3G3Zr6FZC88Dy26fHtrvDfof1vtsLKPef/WYf9xaHm2Df2x1h8lDJzN5pTU9CkI+B/cxidDLmmXPsUhhfpAH5jbKif46aShzSL6xqHV6R/oe0sYi6xEylQrmJtRkq7KPpxQ5Cyrbwgwv8N+jmY1sFRS+nZwdx1E49CLMaw31lvzhjAqlrkI8LbBi6aczWDwbfAbbFLlD9gEv35X20+YgV/Va5h/7v7XH9Il8NuxSvZSL0khsksXBD4iItGigf6+OMmPODT/hz7DaLHwXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZEK2+0T4R6RTZUBQyXSQ5W4gq5l5OHjMchlRbcbTUk=;
 b=x4H6P7avzsXfyOmmEZe3eWZYd68nUEFWZkZKJxLbVsrr7NCzzc3shkwr1HvV5gVuH1GcsAL488Np9qVACCPAVzfvwzgiQEcp60ZB198NusviPqq4dDGKT3MLaxGPBWoEzqADKVqvYFQ9UlGuK9Y9FDgy/i91MHXcTRRfVgjHNzHBKEqslVlNJ1KkfZrVic+tcOfFw+VB/auoFW1LDQ1Xu2OJtl08vmeiFo6Qb4HLyAHRX1WIm0Xq4wG8TV/ceIraMe9CDKl3hXawaDDYnNOLPNg+oc707JsP2Xkq3h4vW4X0xv3XBkt++YZxV/OgCA2VtOKRIt9+eAEtsyXJXHG8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEK2+0T4R6RTZUBQyXSQ5W4gq5l5OHjMchlRbcbTUk=;
 b=fOOBZbJgq/ey9BhDyNuvBMePBePZ4HdeyEdokMs4AFWUgpwnBS4P7PfeVbvfjQ0Ey0odyRSXUKQ+IbJMyBmD42hnR0ckEYvjR3WxwbzAndHL8UxsGTgsDEFQpjciaUZlC2/7SU1Acs/eM6UY9zHm++KRchds7yuZeM2/J/75vBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 22:34:51 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 22:34:45 +0000
Message-ID: <d940d047-b5dd-4d49-a45a-aa259aa4a44e@amd.com>
Date: Tue, 20 Jan 2026 22:34:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdkfd: Sync trap handler binary with source
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vladimir Indic <vladimir.indic@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-2-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260116203932.988704-2-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 97966ad6-1946-4f54-7df7-08de58741caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW8rcERtU3lrKzFJaG5JSlJEM1V6K3RUcFN5Qm10K0FRRmRLU1ZhRkFtL0xN?=
 =?utf-8?B?WjRFVDh2VllzMGNQTjBvZnVmdm1tUVYrRDNJdUs5bUxTQjVMVktSNjBkaVov?=
 =?utf-8?B?aXBOT2JNRjJZMGRIZTZKdGVHMjd4M2Rsa3RUa2tnTy9FVzBpUHBhVS9BNGIr?=
 =?utf-8?B?UnRLZlppcmZVNjYxVUcvUzVENUcxNllJeURjeFY2WWZkR25yV1RYU1JucGVR?=
 =?utf-8?B?MElGU29TYndpSEdYUnJvOEZlYTlvK3hLU2NyUkJtTlRqSnJCUFdYTlI2Ynp6?=
 =?utf-8?B?dE5EVGhNbkVpWnZRRllZSlJCSGVVVEgwYmVkZWFjc0RCb3l6QjhSRXpneGlK?=
 =?utf-8?B?S00zTEV5ZEx4ckw2b0ZyK0tuenltZzRobVY4bjNZa1VFekdsQWRlb1laYWU2?=
 =?utf-8?B?dy9rSGJWZFhqUkZNZStnOXRzN0lGNG5lcThFTzlWWitoamtUTXZQaUp2eW5J?=
 =?utf-8?B?cVJwM2lNeVdKNUNsZ0lhNnBiU080VUhlRFlYaVUyVUxHSG5CbHh6eGxWSys5?=
 =?utf-8?B?SEtYYmIrT01oWEVHZ2NhZnZNdC9zeXRmWWUzOU5RY2M0MWsyWDBTamxDb1RO?=
 =?utf-8?B?SHJzM0tSdHBwMnI4S3RkeE9nbkJISkVRMXpkdU1zYWdRK3Zkc3V6MnJ6NUQ0?=
 =?utf-8?B?cUFDYUR0anVKQ3g2eVJXV2RMNjJsWDdSc3NPRDdpRFBhNWJoeC9hd2JBZ0U2?=
 =?utf-8?B?N0FabHdXRk5nelFmekNuKzhPN2IwckI3NEJ1TW5FZHl3b3BReTJNL1FpVHd0?=
 =?utf-8?B?ei9UaU95M2dwaUxUeUF3OVFiMGVEQmVKMkJObWRQTHU5M1NOSHpFL0NQYWs3?=
 =?utf-8?B?cjBSSzFFOXhOREJNcHZkT3ZrZlNUdW9nNUp3QmhZNTFablNVamgzeFhVdk1Y?=
 =?utf-8?B?UEZzNnZ6UzROU1lqckc2TjR6cllzVU85dS94NENSOXY5R0JHRUJCN3VxeS9j?=
 =?utf-8?B?UjB6WmdiMUpDTGZYOVROR2VnZU9HMERicXJuSFdjcU9lUWl5V1FXY2w4c1ds?=
 =?utf-8?B?a0Uva0Y5bGJOOGc0SEpHSXgvSTFiOCtncVRiemkvM092VS9GSkIvanJnNnlL?=
 =?utf-8?B?cHJxa1Q2VmpiRnJiMUx5a09QMWVybkY4WkFBYzY5SGVTMHROcHNQaDdTMmhS?=
 =?utf-8?B?emhXNmxLQWYrdFdXOXlNQUllc1NlTkt5d2YxTEQ2dlp1YlhTNkQyQ3hiZURS?=
 =?utf-8?B?UEduUFQybDZOYzVGN21majhXL0liU1d4ZlBuVm5FZFpCNlcrazFocnBzdFR6?=
 =?utf-8?B?UEFEbWdPcnlRTVRtdXVBYWxQVXl2SVBYYmtZM2ZjVnhHL2oxMHJhQnVEWTIr?=
 =?utf-8?B?b0VxajU2ZCttdldQUkNjZDl5Vklrc2wzUnFUTGhJYXZiYlBGU3U3VWJaU21k?=
 =?utf-8?B?TXgwUHB4dmNMN2tJczkvc2l1blllTHo0T1RXRkp1T1MwM01GQkcxTFc3UEc1?=
 =?utf-8?B?M1FhNFVlZUpnTGYvRUJYdEY5Rk5UT0tPUFBMdnFvMXllc3ZmOFh6SUNxcXMv?=
 =?utf-8?B?RWEvQkt5VUFHOHJOcTZBMjhrRllhaHJUalRSUDFSVDl5K21RNHVTS0JHTVdq?=
 =?utf-8?B?QnhKSEtOdEl4NHp5bEdiOWpTMkNVRk5vRm0zVFBoTmNqZjJvVzBXaDdxRTcz?=
 =?utf-8?B?c1hzRk8yMkI2OUhJUFoxd1RuaVl3NjF1UUlLRmd1eDVLSUJuUVpXcjJRRCt2?=
 =?utf-8?B?alMzamozb2JzTVpaWVluSXRkQ0pGV0FWS0VnSGxGUUF6VmRKNTkxRXk2cjVi?=
 =?utf-8?B?eFlEbHBUR09rdVJqbVJVT1JwOGI3WXU5MTc5QWlsaHJXdXZ0MS9oS1dJQUdq?=
 =?utf-8?B?N0RVdm9OZWxpTk1zNDNLS0x5Y1BtWi9vQmhnRnF3aXBlMHBKaThDVm1rRXQ5?=
 =?utf-8?B?a0ZhdFpaQTQzNVJoMDFQZDZ4MXd3N0RoZEpVbGNvZ3pTQnJPL2RFWm1HVitQ?=
 =?utf-8?B?Z0sraG5CaUZoSFFHVmVuUzlQV0RqOGJnZVk1VXJQbkQ4ZlZUYUFSb0Q3aExR?=
 =?utf-8?B?NjFIcis3M0FKeVd1Q0V4MExyMlZVcjI3dDVoa0l2M2dZdmJFTWNlQm9OaFAw?=
 =?utf-8?B?NGVKVnFtV0hla3lkZGQxZFNnU3V5QVJZSlJGQjFRYXpNR2h2TDFCRG1QaStl?=
 =?utf-8?Q?miv0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVB6cXJkeHlyZkNxVUErbGNSYkdXT24rZFJhY1VLbVFTNmgrRjhXNkZZRVQr?=
 =?utf-8?B?eG50U1NNU0d0Y1U1YlNNbFFHQzU1ZFJHVmxsRVhMbkNYVnZPL2dTbmFWRjBn?=
 =?utf-8?B?eWdQL2JqNGwzTEVvalpEZUJTZDVEYnRTVGpaMlUwNDJKbkY2U05ySUI5ZFR4?=
 =?utf-8?B?NGYwSkwvZTBydkxwY3V3VWpmR2xmN1dhMXZqWWlZYWlQNUE3TkxZcUpNQTZn?=
 =?utf-8?B?Qnpyc056cUp4b1JZL1lMM21jU216V1g5R2x0bnhhV0swc1NpYVpnYWx5WDg0?=
 =?utf-8?B?dlVYZk1Ld0gzOGpGRi9hQ01vRnFZcmkxSGM0ZXJQM1JicG82a2hkR3ZOK0FH?=
 =?utf-8?B?OGJ2T1pqMXVNUkg2K25DcWZvNlZwT1YwMHdaU3NOOS9CcnhjMzdKT3ZuQXh6?=
 =?utf-8?B?K2JIZjZMaWkycDlLa3ZSTjhBMjRmNTA4bnAxYVUxN25kV0QxSk5Pdk9UaUlX?=
 =?utf-8?B?bTJob295MTBGa1dzYnlpcmxZUEFuQUF1WUlhY0NWUzI4bTM0V1FUZjRHMW1p?=
 =?utf-8?B?ZDFYSnQrNmhCM0dhc3lKbHUwcWJiYjZielIvWXVnWk5zYnQ2TjI3bUx3L0VH?=
 =?utf-8?B?dUZSVnpLN0FJbW1qRWFuVlZwNkNGNXJJd3daTkxzYjZEOVVUcDRzWVBqVm4y?=
 =?utf-8?B?T09XdHVPN2pTUlBMblRLQ0hoTFZhT1hMSDRZWUtYL2hQV0JoR1ZYYkJxYVlK?=
 =?utf-8?B?c3d4N2QrRTg0ZjMzS1dtWjFBNmVyVHN2c2FsYWQxNEo1b0NBUEhwd240cDlR?=
 =?utf-8?B?ZnVsOEFZYml0VzE4dHBKSFlRY3pGZHd0OVVERTdlaUc1WlNGVlJ2eVVuL0M3?=
 =?utf-8?B?dXQ0M3lESnZBaThWaVZkZXFkWk53UVRhWnFIT1lhS05lYi9tN1hQYWp2YU1T?=
 =?utf-8?B?aW1hNklyaFJnK1E3SUUvUGVmdWFObzA2TDkrbkhIMk95ZzEraWk1UHVqZS9o?=
 =?utf-8?B?cXVEQitJU0F3dHBxUEg4SEVqZW9oT29zbEQvazFDVXJPVE00Z3dnQ3BDaEsr?=
 =?utf-8?B?TTNoQnJmdHVLVndJbDNjWWxsTGJ6TVhuVGJ2ZWhwVWZsZWdQSUtBa3VNVVNK?=
 =?utf-8?B?V0h6UGdaL09xeXQ4Nk1nU202M29CTFVNSnRDWWxQcGV4U0VsMDJVRjZNWFU4?=
 =?utf-8?B?U3BURStDY3ZMTWtKUDRpYXV1c1B6R3A2S2NTQWdnMnQwaENybEFYa2NPd2dy?=
 =?utf-8?B?NzBSNlNNRXNjRllrZllxNUt3bGovOWxZcHdRNSszaTdDYnc0RU5Ib3ZzcFJ5?=
 =?utf-8?B?NFFjcXJGWE52cnprdzhKRlFuejdHdG1KL0tvdHVTUFVPd0tucVhqSjlNbktz?=
 =?utf-8?B?RndLTGpjS0lna1dHdWJPNnlMQlZsVEZHZGhlYWtVaTJ3amRNdzkzcTRKU3FX?=
 =?utf-8?B?aFlOUEd4RjR6WmFMS21MV25BZk00SHA2MEkxN0NGSkw4OTlGVFIxQ3pxUHY2?=
 =?utf-8?B?VGZrY2cvY1JaY3B0bzNTMmpTL1BIZ2ZpdWU1WFl2MTN3MHVNT2kyVVZGVk4x?=
 =?utf-8?B?a0JuSnlHN05pM2hsUFlCeEprUVVRYmNVcUxNd1M0cG1nY2ZPMjZNQWRWNkh5?=
 =?utf-8?B?ZW9kdGN4bmwvd250bmJlMlY2Y0tCcEllWDNwSEEzWGNCdG4vMDY5bG9sUGRK?=
 =?utf-8?B?L0JYbmUzOWR5bXBtNmxjeHQxZkc2MTJVNCtSRExNdWxqcWx1cDgvM1ZhQXJW?=
 =?utf-8?B?TGhVRVE3Um1Dc254M3Fma0tQOVo3UXJlS1FRV0dqcnVDRUZORHkxb2ZwZ3Na?=
 =?utf-8?B?bjlzNmw5bkViMDJGeUpDL1FkWXBiSEk1VVhxQlRMaWZldWNkNzRYQXl1dTZt?=
 =?utf-8?B?K2JRUGticnJYbWkybDFzb2NETTNDUFBYWXl0cW5NN25KWnV1VHVrZUdXYmJw?=
 =?utf-8?B?aGNBUDh4ajVER3BNNkI4aGhtcHcwTkF3eURnWWxkOHhvUjd4c1hodVA3MXNs?=
 =?utf-8?B?T1ZZWDJHOVpQRG9CYlJTU2FJbmlKSjVDSXlWOW5FTFI4UmZzNXFrc0pKQWVF?=
 =?utf-8?B?d1RWUWhWN2J2VGVLeEhBWnRCOWw3R2JCL25WT2RpdHNUWlpsak1XZ3VKWXNl?=
 =?utf-8?B?cXd4amErSDJRWklMR2x1bllyUGJqbFBKTUd3WFNQTVJ2S0xxcjRVaE01THpN?=
 =?utf-8?B?L3lpem1Nc1hwTlJwa3B2Z1o3d1VYL2U0MFBKaUI4NFp0eGt5RnQzdDQxNURF?=
 =?utf-8?B?SU1RLzh6dXAwdjhpa093MUFwVENiYVJ1S0ZFd08ydG9PL1pkUVkweElJc2hP?=
 =?utf-8?B?VGdacVNmWlZYSjNGK0JjbTVjcG9haUh1V2Jka2NwdUpBcTZKK3FITHZzYVgx?=
 =?utf-8?Q?0NG4yblxPOv+8PUQb3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97966ad6-1946-4f54-7df7-08de58741caf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:34:45.8514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCJv7wYLyFiU9H0v9rnS3ZORbSmaijkSzCUUUDQtLfBONPq9vrKvtGmg1nEA/O88mxkbi+p9qDww+QTsWFLvPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

Hi,

This looks good to me, thanks.

On 16/01/2026 20:39, Jay Cornwall wrote:
> Binary and source desynced during branch activity. Source merge
> also introduced compile error.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>

Reviewed-by: Lancelot Six<lancelot.six@amd.com>
