Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973F0C83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 13:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DAF710E5A8;
	Tue,  1 Jul 2025 13:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PiAe2kMO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A5610E5A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 13:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6sdch80gBLUKsiIRf/fW/uKxq7mtier45DQv7xWH2EGFhEm1VtzcDsC6PZrMTvZJfCrlGNF+OBRLmgYGHd/HjUxhkgMFtTU97ZR5EW0VZ/fzJrAgI1oisamyex/cf0LnEmhIdPtKDQIdSYZVn3Qln3dM0J/gNR6sxSWhnY4kSf7xEfkN73F/WBxkYgPg0pFbvjjX2KW42zW3Wq0QN0s4il6on/+ggCzVSLoz/NJ40+tlRTo+rHBQqFigJzU51HIstuXiWAD0xVw0i+FJqRJKJUcLAllstG9rrldcAt52ff20v8UI11I7T0MIA5z6kCVAdYv9fn4YwcX7iMeZfPb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er20n8JNcTM1M694xa2zb2Y98zObCfXH5SzweUjCsCM=;
 b=N29zC8GuBzutimSMLfUrTNwu4XWsvgCdvSuT8vjBJkj7X5SwHEZ6Zh7RJ9eT98ineowb52FTAYYq/bCTmKsOJ4ECQJ6Gaqt56i8+qpqgMWyh3eCB/+NHEcNtIilHrb0RlIzHsCoOIf67DSUN6XcUQ0hd9q9sqW7FQu9JRYgnE9kbRFnpg9eEIhaGlqaTBX/+1h2rivovly4zld8UT9KvGNfYJYZMhKhVsQondiAFM9d0QYI83N1/oHPAc0tICfjgcueYvzoIMMDk7f3VubxFTq4Arur+Uax3Y3Pm0EhnNauH8rnR3QR02mmUn/z/jJwioSGurRteqnMcI929S2E/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er20n8JNcTM1M694xa2zb2Y98zObCfXH5SzweUjCsCM=;
 b=PiAe2kMOgprI1WUPYHlKKEpNBsmqYNZYwwdxz4ZgIGlP8EIgKlnOefGwd9NHjgDZC3yp4NV0cEA45rYPLOI+I4lMxaPxYaK1gwT+zo+wrwr9+1nEis4uaekIcgXBGYSu89b1D8154mOxVlAtVz8uj2SO0d6sU6OLWo+5izmhbiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 13:32:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:32:22 +0000
Message-ID: <10f23f02-0885-4546-8668-eff0c63e1aac@amd.com>
Date: Tue, 1 Jul 2025 15:32:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-10-Prike.Liang@amd.com>
 <95e86cba-b3de-4f42-bd47-6e7eebcf2acd@amd.com>
 <DS7PR12MB60051F95EB72971ADF7CA5F3FB41A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60051F95EB72971ADF7CA5F3FB41A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 1155947a-7857-4883-6002-08ddb8a3b53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2VyNkFpQXI3MXhVVDNZRFR2Mk9YMTFwSXhXbE9HMDVtUFFaSW90b3YyUitB?=
 =?utf-8?B?QjU0Y2ZYd3NVa0NncmR4YVV6Q0N1bjNYR0JHVDdBQmJ0TUgxTTFLb3Y1RFRs?=
 =?utf-8?B?aW0zK3hZMmdaZ3psL2dFcm1PT21zQXd2YXJ0Z0o4T1YwdFZGaEt0Y0hJOWNP?=
 =?utf-8?B?VE5GV1JKamRYSCs4RDFEY25PMlRKUWwvdHVPemZIcUZSS09CdFlBcXlPcnNL?=
 =?utf-8?B?THYwaUZhRnhDRnErUzVxWGZaVFBtSFNUcEZ0WFpsMjQ3L1VmbUJxbzcyL00v?=
 =?utf-8?B?VVYvbGU0aVdKUEVneGZwL1NON2FidURIMG05UVBzWFB6ejRnY08weGl4WHlF?=
 =?utf-8?B?ellwckVpaXFJMkVvQ0RTTUk4eWJ3VkJwWloyanZtQmZmY0Ixc3A0WlFXM2pV?=
 =?utf-8?B?dzJCNXZoOXVuR2ljQmplYy9QeE92M2JsVHI1QU1UZ0NweHpaUlE1S0ZCRmNk?=
 =?utf-8?B?b1RheDV0YTBKN1ZoOEpJMGp1L2xmSXFuUXFtOXFhZTdSeDIyLzI1TDJCRkRB?=
 =?utf-8?B?bDhJNnZ1RnNqYmdReURpVThnSmRrWXQ5bFA0aWpweTUzL2tGSXFMSzVzbkZY?=
 =?utf-8?B?QU9LeENKM1ROd0ZLWUthYlRPWXRFN0xVWkpYUVRqTXhDVVR0dzFjQVFmT1BI?=
 =?utf-8?B?TkI3Tjhlc21sSjhlZlZsZkh3TzZSbDdzb0YxQXpxK0xtY1diU0xPZEh0ckxv?=
 =?utf-8?B?eVl0SG53WFJxdjk0WDdGUWxpZExpSC9uU1BUNDNLbTZyTmdPTHAvK3YyVjgv?=
 =?utf-8?B?MXRJelBjRnl1Szgxc2JFbEpwbExLWmxsY2Y4QStYdU5RSVJTYk5DVkNPREpx?=
 =?utf-8?B?K1RlOXZwODRlQWRnZXhPNzBSVFdWN2RjMkZvUXdLWm9CY0VnaHpYTmJvU3ha?=
 =?utf-8?B?VEJqWm56bGlPVWxRZFd3eFk2TGM1bmd5VDVNRlI5aXQ4SFpYNEhWQk5KU2RE?=
 =?utf-8?B?WkdvSHQ0SFVUWlBNeG5MdU9od3ZTMnUrSGZmcFlhbkpDbnZqZ0VicGFNdTZN?=
 =?utf-8?B?bE1pYnhRb210TEZyZnduNTJ6c1E4ZWZDU28xL2R2RFpuUjJ0Mi85d1dPRzgx?=
 =?utf-8?B?MWlHSU9FQ2RMODN5RkJWVWZncndjM1AzZXgxUDIvWkN5NGZ1eDBxQTgwZUhK?=
 =?utf-8?B?bXRWWEYxUDV2WGVkWlBhZTBnQ1RWakJQeDRRUTZsajJXT2tqTXV5RG14Uld0?=
 =?utf-8?B?OFpDN1ptZ3JNTlRrN2JBVmo4ajhwdzY5cXNoVkZkM2NaUFViZHB1OCtRTmNT?=
 =?utf-8?B?QUVwWHVGSlNhZ1NlOGNoeXNCVEY3bEJCOGpDTDhyeWlZMnR5TzdKS0JrR0U3?=
 =?utf-8?B?MDRHVGtiSngzczNiSXJqRWNORHFyRCtKbW42YmErNUQ2NTVna3BnTGR2WVUw?=
 =?utf-8?B?TjJlMVh3Z1gvd2F4K3NZRTZwZ0FtblkyNjhTVkdnZWJRbzgyWSs0cFgyQUlY?=
 =?utf-8?B?QTI0RFYrSFZFV2U1SXRNVU9KM1JjYWoraVpNY3Y0MDgwbTlwN0xMYUZpZDNs?=
 =?utf-8?B?L2JrRTlIZ09vMWpLL3NOQWNrZzFSU2cwa016UWdGWUNsMjl2dVcrei9XZzNY?=
 =?utf-8?B?NzdDV0JwOGN4N3IzTlFCMTRFc2ExRytXZThmejlxdVQ3NzVCVWRQNUlGRjZv?=
 =?utf-8?B?WWYzL1ErU3I3R2N3ZTNBeHVPNUFrSGhpSVZsVGY2Z3RuaHdFNGg5SVFrS2dW?=
 =?utf-8?B?RkRDTXB4dnI3ODhkRkduK2UrQnJvSUF0ZVlURW5rbHAyTlNtcUNyNEZlZm45?=
 =?utf-8?B?by9qRlFNRVNncEQ3LzFRVndGV0dETENXUEVwekRYd3Uwb2RxUmNFbTZyWHlt?=
 =?utf-8?B?SVNMSHRjNXp4a3NOb2VlKy9Dejhrc2t6ZFZnOUR4ZG1Id1ZVcy9RQXJoSGNa?=
 =?utf-8?B?N0RiNThDaGhBVEgxWjg4QlRzNFJVSjRKcHJiWExhM1ZKM0FOcUVlVzFVRzhm?=
 =?utf-8?Q?urG4O48WzcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZHMW5iVlUvdEpSVFZoZXZTZjJIZG50OWh5VDkxbkMrZlU1cXM4aGJMemVm?=
 =?utf-8?B?RVd6K3hsSGQ1T2x3TXJ1TFhOc3l6R2RheVByY0c0VlA2bW9MV1J1T3ZERVk5?=
 =?utf-8?B?aVRrZFVIWHhUMmhTSk1YbTBEaUJkM2M1cjEwazZKQ1dSSDJ1N2NYcTUrMWFB?=
 =?utf-8?B?UnZFU1EyQm5HQ05TNENvcTRQTVQvZHZhNXlmUUJPTzFIU3VkTTRnMVdrQk1E?=
 =?utf-8?B?S1ZGRGtpTUlKM2EyazAzRFgweGF1RUtqZEo2NFJSa284NW5ld0UxT2JLVHIz?=
 =?utf-8?B?Y1Nrdkh4UEk4U0NDZW95d1BYYVJqd0s2VEJJa1phNDlINDlMT1JGY3g2dnR0?=
 =?utf-8?B?SWJla29OTVh1MDNDYTdjenhSWmRrUXdPOWVwTnByWWFTQWV1eDc3bThLVlN5?=
 =?utf-8?B?VEowOENVZEdmQW5LVVlUc2g5bTN0aVF6aE00RDA0dVpMa1lRRExXOGM4ZytN?=
 =?utf-8?B?aCtmZytROUNJODVrOUJpZjZrcWhSek41MHk5R29QSXNVaWlXOUgzR2FZdUpq?=
 =?utf-8?B?V2U2NkFCZlZlUmpaalN1eTNWNkZWd3VsNXdEakRWbjNDbmNlRVVwZ3BUTjYx?=
 =?utf-8?B?RnNtN0k4RW5VS25ZdEk0cEpyaTA4YXovMU1MYjJNQlFaR2hqQjZZMXhvbjhP?=
 =?utf-8?B?ZUt2YUk1azhST0VKNW5td2FHUDd1ejVLVVdzTTVaSmpwazNIT3lNUjNseXNl?=
 =?utf-8?B?QTdGRzhPSFBoV0lNQnBaYmpSTmRQMnV3b0ZsblFBUFVvMk9jRTdnQlN4UDhr?=
 =?utf-8?B?Ull0aHZTUm13SzFhMm1RODVNbFBPM2pUT2hYSjVLVWFwNzZmMC9RbnRRdURL?=
 =?utf-8?B?QVdtRjUrOVVzcFdsYXk0MFdVajZINklUSmVOcHVPVEdFL3NDSk5IeS9aVW1S?=
 =?utf-8?B?NWE4V2U5ZGVEVGloTUZPaUl0L3RHNFo4cjBCb2dtUHREZEYzTHp0dDdUZlBB?=
 =?utf-8?B?RDNnYVd0TzhFRkJCV083SVFYZXFIRDBjNUR2TjhjcDlkeU4yNkZFd0l5MWR0?=
 =?utf-8?B?TUpnNmZKWmI1aFFtbVNMUTRRNXNSR0FDcHhidzJuMFFlOUJmK2xiN205RXB2?=
 =?utf-8?B?UXMzOW42WExKbEV6VXFRZC9EcHZDaTNnaWdvQ25mNllDVEthQitZcHFDNkY5?=
 =?utf-8?B?OEw2WHdDc0I4Rys0RzZxRXlXU0dNbXpseEFWR09sK0ltdVYrWkFYU2ZCWE9J?=
 =?utf-8?B?UkZOSjZ1RU5xVjROZE8vYUVjNGhwQWR2UmszcFVtYVdydTJBN3YwR1piZGxP?=
 =?utf-8?B?Nm4rcjZTdXIwamhhQkRwdEpPa0dNU21hUENOa2hacDNiMnZRZk9LQnNtNDFZ?=
 =?utf-8?B?dmlwcFpyRFBLRUxycTNsYzZyZndrbjRGYWwzRVNzOG41aXlFdGl1QTlDMGtW?=
 =?utf-8?B?NXhWeUIvVnhGbTFBMVdIMUkzazhzazIvTkFKR2pEVU92N2FpMkJsNG5MSi9n?=
 =?utf-8?B?MjFQeVVVdlVDOGZWbUxuRVNPc1R6U2RjU0VyYnlkNWxaZkQ3STYzOTY4WmZR?=
 =?utf-8?B?T1gvMkoxWU1sM3FreWhxT2M4ZWQyczNzdGNZV1g3cDA2YTFaMjdjb1F0eGgz?=
 =?utf-8?B?TWliOFBVVUlaRXJldjZlQ2dGZVFGd0p0aUZJdC9zd1AvakVJb3lxMzJaRjhq?=
 =?utf-8?B?Ui9sS2U1SVFhUCtUMVFjeE9pbUlyemRSeUx4S2RFY0QyaGE1eVNsNXB3Vkhn?=
 =?utf-8?B?UzVETXluNmdkeldhcFdKYStNTzVmYkVpZWdiaEFQdWxuWVZrMHRqY29WNkhF?=
 =?utf-8?B?ZXhKNWcrbzhlRFk5SGtoL1hBaUI3VWYvSVdQTnBKbUQ1T3VSeWQvZzdJUTJs?=
 =?utf-8?B?OHNnaU9NK2drK1dNcEtDVUQ4NnJuVk4xS2xmTXJWQ2VjQ3hHTktkcGY5R2R3?=
 =?utf-8?B?b1BDR2pBTy8zMUVSZ0J6RTBPN05GcXFJbVdkL01JOGpqZUtveGJjWnRrQjBR?=
 =?utf-8?B?azNLQ2FLbnlqVkVLbExsdEFoWVhGbnprTW83bDBnK3E5SHBpNFppSjBsZGdz?=
 =?utf-8?B?dGE4OFd3WFlQMHFPckNRbm5GQ0ZwdVRJdlhCRVNQSktBVk1rQ1oxVEU3cGRw?=
 =?utf-8?B?WWIwK3dzbndPYVNGd2huV1cwdUlUb1NhSkhOcmhIMTM2a1pMQWZmTm9SOFhU?=
 =?utf-8?Q?WeWXJZx7IN3pWsHSCn5Qip+FZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1155947a-7857-4883-6002-08ddb8a3b53f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:32:22.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ON/wRmfaclWvyFmpY2uOhHIOIdK4tqYyTHuoQh3VjTbgnNXTPCxqJrmthaRkWf51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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

On 01.07.25 15:21, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, June 25, 2025 3:50 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to userq
>> bo
>>
>> On 24.06.25 10:45, Prike Liang wrote:
>>> It doesn't need to attach the invalid eviction fence to non-userq's
>>> BOs.
>>
>> Clear NAK to this.
>>
>> BOs are often created before the userqs are created.
> Yes, but the eviction fence will only be available when the userq task is scheduled. Before requesting the userq-create IOCTL,
> the eviction fence is invalid and hasn't been created. In this case, do we need to attach an invalid eviction fence to the
> BO?

Yes, we do. Otherwise the whole approach is racy like hell.

Please don't change that in anyway.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 +++++++++-------
>>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 2c68118fe9fd..50356aa23a99 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -294,12 +294,14 @@ static int amdgpu_gem_object_open(struct
>> drm_gem_object *obj,
>>>     else
>>>             ++bo_va->ref_count;
>>>
>>> -   /* attach gfx eviction fence */
>>> -   r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>>> -   if (r) {
>>> -           DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
>>> -           amdgpu_bo_unreserve(abo);
>>> -           return r;
>>> +   /* attach gfx eviction fence when userq created*/
>>> +   if (vm->is_userq_context) {
>>> +           r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>>> +           if (r) {
>>> +                   DRM_DEBUG_DRIVER("Failed to attach eviction fence to
>> BO\n");
>>> +                   amdgpu_bo_unreserve(abo);
>>> +                   return r;
>>> +           }
>>>     }
>>>
>>>     amdgpu_bo_unreserve(abo);
>>> @@ -365,7 +367,7 @@ static void amdgpu_gem_object_close(struct
>> drm_gem_object *obj,
>>>                     goto out_unlock;
>>>     }
>>>
>>> -   if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>> +   if (!amdgpu_vm_is_bo_always_valid(vm, bo) && vm->is_compute_context)
>>>             amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>>>
>>>     bo_va = amdgpu_vm_bo_find(vm, bo);
> 

