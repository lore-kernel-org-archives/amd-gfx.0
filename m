Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8C0D1CA36
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 06:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BB810E523;
	Tue,  5 Nov 2024 06:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBD+OdWe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656B810E523
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 06:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6KiWtTtYZ5YLIvXi+7R3xe2iU4/rETHSc5PShruKgy3EhHJ7OKHsVqx4OmxXt5T+44NrYnHGq8LixPw5VaZuktgKBni4eueMpDKC2SHNlsLbe/9+50FKTRXrkVD80eTacnxoFavTuyAFdDUNWRL/NY4nVivxRa5VbaBBsRbvPRZwUuqC7aFES8cooiyc081Wz0ltn+T6QOOvnSLbcaPZqzqQro39ZVKtx8IJPqMZq/ZA3qA01UMD0NhSL/BA2UcsdpCpGBlDewfUwVTW/1g6zxzAhDXBI9etn3TG+AE1fW9rZvlK+eqk1NonfptUPB42A4oybiNwTJwulZWVtkQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kTu7ITz0mNu4vgEqOeGZZGbkXatSashSsC3lws8H0M=;
 b=TTkuvGqOEm1/+YNPe6lYp34kOIbL5QWlCP0TXOzHSGfQ6i5BLkJDwlZA7so5yxAt91JjyCcBF38aZTDHIJgbQFfUI0GwSlfclkxHLqJs19xi7sObfP/3ADlCYfrc8sK1l1bUZ0sb7lyk4X+kEg3fcmTUs3OUt7fqndmZFS5lA4u8J8iLFz3zHL8IRn4LzaRkTs8eRZcdMNza8yIbBZn0Fq2lZ02VedNpcuTx9VpsRAZVFpavo78nU2Xm2zq3xFSVEyV2pNF+NXntQpjZCB5tml2FSTuIassoKFX0gIBit5Vz03i/IUrI9CYMGUV6NO2aXuY5fLaJmv5PN9OlJmtEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kTu7ITz0mNu4vgEqOeGZZGbkXatSashSsC3lws8H0M=;
 b=CBD+OdWe1kVooiHJ5rZHV2q1uLaO1hJX4FDZpRiudGSJWTV+N3uLYm+1K9DuS+1zCbkWliy1VdVU2mWnYrjwwBC802T6Q+J2RE16tZmSGddGL8Wo28LVP3Q6pg70IIfdnHN7H5u/HjSbIg8CKl1/STssIp40iAqfzQ5imdD0fMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:23:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:23:04 +0000
Message-ID: <d99a7caf-a88d-49bb-b5b1-dd8ead9de174@amd.com>
Date: Tue, 5 Nov 2024 11:52:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20241105053844.3242241-1-lijo.lazar@amd.com>
 <PH0PR12MB5404F8E5463D0157BE13BC32F6522@PH0PR12MB5404.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH0PR12MB5404F8E5463D0157BE13BC32F6522@PH0PR12MB5404.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1f59d9-eb2f-4fae-a1e4-08dcfd624e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWFxQ3VnWlAvdEdkWkZLUVovbTZVdmlHVUFzUjFCVjcyeU9FU2dZanNJRXdn?=
 =?utf-8?B?Q2tSU2QvSWh4WGlGU1FFWEpwZ2lpSHpKQ0NLSXgwZ1I1THlTTVpQNWJMSzJq?=
 =?utf-8?B?MnZ4MUtla1ZXMHphRnJmVEVJcGsrTEI5WWlFV3RlOHhMT3piQnVodGJDTkRJ?=
 =?utf-8?B?bmxNVEhKNm1KU1RsQTVRNjJMK2k0aDNMc3Z5bmMyUTNmUXN3OFZ0V1JIRVBo?=
 =?utf-8?B?bkcxR2E4VTlRVWJYMkZUV2NrV2dhdXRLY05pUDVBNlh2MVdOcklldHFZd1FC?=
 =?utf-8?B?amxxUEJScVlsZEI5UkYvMnRhMlh1MzFVdFU3WGJybTJwQy9ZS3NTVDY2SVhp?=
 =?utf-8?B?L1dqV3pmNnRhbk80RDgxWW9lWGZFMFNNYmgvY0JaL3JyOFJnbnlEcU1iWmRi?=
 =?utf-8?B?bHlNaGFPMS9VRHJmVjJCeDJrUXFOV2pmYWxWWnl1L0t3Mm0yVGdJWTh4bXVR?=
 =?utf-8?B?aUtsVTdUeE51bVFKazNLWEhPWmxFTDgzOXlIZW15QzB4MnZMSjJWQW9SZGpK?=
 =?utf-8?B?NVhqOTRsZ0JZUG9qaHVUa1ZKcVpOVGZraDdTTFNwWkpPQmJmMDQ3eENKeW91?=
 =?utf-8?B?aWZhdDJhVUREM3RvVFRMZHowblhTRXczZlEvejg3bkordytmanlYSjZic1Vq?=
 =?utf-8?B?OUJxMjZPb2ZEcTJVUHlZeGxLVUJhM1VNT2Y2Uy9EVzJKUDZnSitjMjFxa0pQ?=
 =?utf-8?B?RFFYZkJwUkdtazhJSE5HeGJuaW9mSUd0Umg5QUJtdEhyYnk2dDNDY0NVUEJF?=
 =?utf-8?B?eWxYVHhSL2tQaEYzcFh0V29weU9mcU5SRG5UVENacy9BRFRXT1RhdTkrMk9M?=
 =?utf-8?B?QWJnOEx4RTl1K205S2NOSEIwcXJieCs4a3B2SFZlLzBySzlaQVJ1NitTaXIy?=
 =?utf-8?B?enBzM3NQdVJTeVJzWVNmRWtCcnpYaDRIbGczU3ROL2pJZlBVdmtscG1LNENT?=
 =?utf-8?B?djAwdERzbjVJcEhzMy96dGNoZ01KWUx5WFQveXgxcVBvU3pCdnEzcTJWY0NQ?=
 =?utf-8?B?VTN4K1RHM2NwNzBEWVNDOCszWDA3aUtWMlMrT3BkL21ESHJ5YzJzM0l0L3VQ?=
 =?utf-8?B?aE9oNGNmYzhja3hZR1FvcEFJdFkxSDNQbDlwdVoxRDBaeG1COE5wS3hxb1k5?=
 =?utf-8?B?S1RIUjc1L25ab2lHNUVHNjUyVUMrNGF6VitMWnMzT090d04wVURMRWlUSTVo?=
 =?utf-8?B?NVRjSVVKVkY1ck9IcUJHbndzaTExcTd2YWxKcDE4L0RaR2p4K0xUcVZUK21Z?=
 =?utf-8?B?SWg1YUl3UU5qamZKMEpQUkxYYVRkaU9hMEtrTGZqQWtjNkIyUmZJQTIvVTN5?=
 =?utf-8?B?M0FLcmRPUkVlQzVwTGxDMERFbVdpZDdHREo5Q2wyWUlyZFZqekVOT2ZXNkJr?=
 =?utf-8?B?ZytEVmZ3N2xVNzFEbm5iQ2szVEtBYmxQbVJSWWFKVzZjQk1yeWtmWFB5a1Yx?=
 =?utf-8?B?TTNBL1dBY0psS3Z4b2Ewd2xiZnlMcFNpRUJjNnNIaVJLRnNrNThJM1ZEOUhN?=
 =?utf-8?B?S1lEM092T0JzaTAvZDI5QmVFU1dRUFUxNWhPQ21QVCtvUis0R3NyRk5aU0k0?=
 =?utf-8?B?aWFxb2NMTGJXSW1nNUQwS0xySzBKVG1XRmpmNFREQWNMdjBERUlNY200T2kr?=
 =?utf-8?B?RUVsWlVWdVpMdXRwam9zMjZlNjNxZHpidC9hcGRkT0tJTEVkMTZWSVkvaGxR?=
 =?utf-8?B?R1lmWkM5a3Y1bXptbU92VElEMUlSK0RRL1dvV2UxVG1oUDlJSlR4dTdERXB4?=
 =?utf-8?Q?FFOWSre9hx8Jl9IvFUDYkGY2uuv9IKfZqnBfRrz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpFQ2dPUjFoc3NtUHF0bmNHVmJ1YWpFR0Z4UlVvWWdGS2kzZ3g5MU1yYVhn?=
 =?utf-8?B?Vmt3bm9vUmlPNEVwMEdsL0RXeXF5UmtQMXJrU0dmbnRKTEhkUENDRisyU1FF?=
 =?utf-8?B?OTdpSkZCYWMwaXY1OFB1SU43bjl2VDRpdDAyWE5XZ3lIUmp6czUybXp0UUxR?=
 =?utf-8?B?VXd4MkowM3FFVk9uQUszY1lCU3prbVEwOFZJNkFvZTRIL040U2o2Q0UwZHBy?=
 =?utf-8?B?OUpNS3M3WU5kcDhFRG9WTTNzRVpnbXZkOEE5SWQvcTUzcW9mb1B4M1NZejZN?=
 =?utf-8?B?endWL2xieHJER25VdjZiN2pkSGd4ME9kbWZNTFdCMEtkc2VPTHdCVlhTMkJO?=
 =?utf-8?B?YUwrZEVCTHo1NUJIUlY2MVJmNWxIVklMbkJpVVVZZlVmaE9sbWY3Y0Y3RVEx?=
 =?utf-8?B?MUxrdnRHSkVuYUUxVEdVRlBpNnB3SFlZcmtyOWZlMnFtMm1LYVhvcWNscSti?=
 =?utf-8?B?dDlvb2xLK29ENEg4UlhxTytZb1lnWTZHRlJuT2FWTUdQd0F0U0Yva0ZkS2JP?=
 =?utf-8?B?WVEwTVdEb1lBMEVJQ0srZVlPOXN4MG9oV3Q5dDhwT1pOZExoUm5KUkduL2pl?=
 =?utf-8?B?VndDOXhBbDRVVjB1VXE3QmVQU0V5U3Z2SmVJRnUzZGtqQmJIY0U1SUxkbzlZ?=
 =?utf-8?B?akRHbWhQb3A3N1JCUlk5OTM0Q0llS01rbGlNNnVnWE1KZnU1MTMranJ3Wkth?=
 =?utf-8?B?NzJYMFBWK1ZJdDNXNVRabXcwRjRrZDFSOEQ4S2ltREhSU2p0VWM1MjROM2Zn?=
 =?utf-8?B?QWNsTml3bHVXU1o2bzNJNFNLR0NzSUs5d05ic0kzQ0NvSUF4OVhNYkdMbnJu?=
 =?utf-8?B?SHZzMWFqYkZSZW1pcHFPdGFlU05YYWc1YnN1SnJIMlBuSzlDL1RwTXFYL3A1?=
 =?utf-8?B?Qnl3RFZzRlg4QXM4d1NXTS9MVTBqcWtjamJYelhnUlAxQ2dnR1ZVYXZIcVJU?=
 =?utf-8?B?dDNnOEFqTFlXQWdUWCtmeGtiV2UyRTE0TUtqUmVwbG4rLzdXbnNwMzhQMW5l?=
 =?utf-8?B?WDJzcjZtYVZCY0J2L1kvTUZwQ2pKcENYZklzbER2TlphZnFFTnd2eEZDVzlN?=
 =?utf-8?B?NkZXSGtIVFZ4NmFMZ2RyRkpsVHd2QmdIb2wyNXp5eXlVa0FNSTg5Z0I4OG5Q?=
 =?utf-8?B?M000OXlrNGlXeEFhUElrTW84eUdvUFJYVGMzSTI3NWRuZ1NhaDRtZGF5Q2h3?=
 =?utf-8?B?bXNRbnJrRHZSK0ZFMkNDY3phVnJDUGQ5S1p0Z1QrR0pIa1hyaWYvV25ISWo2?=
 =?utf-8?B?U3Q3OGIyQ3ZyQVp2WW1vcUdWekRhUU5qalF0aGV2RElhVVNPR1Y1SWZPVHQ4?=
 =?utf-8?B?M0l1TkdxdWZnSFdHYVFsYlByM2czSWFDRDhrbzV4aW83SGtqYyt1NENIVXNw?=
 =?utf-8?B?RFVvNlpkWk9Kb2VTUk5KenB5SFdxTW1FcnJOTHloYTViRVJPU2tld2g5OVFy?=
 =?utf-8?B?ZEtqWVVWeGIram9ZSkNHZ1QrcjFlS2tlSE90ZnBYWGhPbTkydWVpQ3RoYkto?=
 =?utf-8?B?dEZEeFpvS2hCdzFlYzNOcFgwTVNVSFZibHFqTGRncmN5OFVrckkxaHpUaXN2?=
 =?utf-8?B?ckd4a3J1SWcvcnlsZDNHZXJWd05WT2ROV01adnZyT1JVM0FqVHdaUDVaNEl3?=
 =?utf-8?B?MDcweUhhaTF5L1RmUE16OGhWNTMybGhCY2dlbnppdzErc0JMSXZjelY1M0Jv?=
 =?utf-8?B?U3gwdEk3WkwyN0lwTWRCWkdtZUs2UFB2RnZCNmtMTVlXcmYzR245QXg5d2g1?=
 =?utf-8?B?Y0UzeXRyN2lEeVV0WkxTR0szeFN2UHRqUmRQbDNGSWprZitPdllWQUlDcDJR?=
 =?utf-8?B?Mk9kV3pnOTBXekdwQnFITFNKRXN5dnZDcUxaTXJ5Q2dTWEZtMTYrcEZLWjRR?=
 =?utf-8?B?TlRqbkswVjRmcGtHQnV0cFJlakRPcmRWZnpMajFIWDFPYk9BbWhDSUU1RkZy?=
 =?utf-8?B?WWkyd295Uk82T3lpcy9hdTd2L1ZHNDNGYmg1L3NTZ0IvaFlhZVI3QVdYNnBP?=
 =?utf-8?B?UURadStIZzNmQVcxK29mZjBCMllUUTBXWTBZa25hOUZYZ2RuOEdSRWEwU1JR?=
 =?utf-8?B?QytUSHdHcFhKRWZUVGRaQXYyUE5pdDhHazZZZ1VCUnhJazF1UUFSUDM4VFpU?=
 =?utf-8?Q?ZkYIWst7vZhauKACxGst1Yzw9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1f59d9-eb2f-4fae-a1e4-08dcfd624e61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:23:04.4872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4kJiakpcNXaxtJKM49iKk46nZaBzo6YNDrKpBUd3rC8oOL2PW10eQMrS7PEIshS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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



On 11/5/2024 11:45 AM, Ma, Le wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
>> Sent: Tuesday, November 5, 2024 1:39 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
>>
>> In current logic, it calls ring_alloc followed by a ring_test. ring_test in turn will call
>> another ring_alloc. This is illegal usage as a ring_alloc is expected to be closed
>> properly with a ring_commit. Change to commit the unmap queue packet first
>> followed by a ring_test. Add a comment about the usage of ring_test.
> 
> Regarding the description " This is illegal usage as a ring_alloc is expected to be closed properly with a ring_commit ", does this only apply to unmap queue logic ?
> The current logic to do map queue is also to commit once in ring_test but ring_alloc twice.
> 

Should be applicable for this case also - ring_alloc calls begin_use and
ring_commit marks end_use. It could be working fine because those are
not implemented for these rings currently.

But using ring_test without a commit doesn't appear to be the correct
usage of API.

Will fix map calls in another patch.

Thanks,
Lijo
>>
>> Also, reorder the current pre-condition checks of job hang or kiq ring scheduler not
>> ready. Without them being met, it is not useful to attempt ring or memory allocations.
>>
>> Fixes tag refers to the original patch which introduced this issue which then got
>> carried over into newer code.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Fixes: 6c10b5cc4eaa ("drm/amdgpu: Remove duplicate code in gfx_v8_0.c")
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +++++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 47 ++++++++++++++--------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  7 ++++
>>  3 files changed, 49 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index c218e8f117e4..2a40150ae10f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -844,6 +844,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device
>> *adev, u32 doorbell_off,
>>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>               return -EINVAL;
>>
>> +     if (!kiq_ring->sched.ready || adev->job_hang)
>> +             return 0;
>> +
>>       ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
>>       if (!ring_funcs)
>>               return -ENOMEM;
>> @@ -868,8 +871,14 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device
>> *adev, u32 doorbell_off,
>>
>>       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
>>
>> -     if (kiq_ring->sched.ready && !adev->job_hang)
>> -             r = amdgpu_ring_test_helper(kiq_ring);
>> +     /* Submit unmap queue packet */
>> +     amdgpu_ring_commit(kiq_ring);
>> +     /*
>> +      * Ring test will do a basic scratch register change check. Just run
>> +      * this to ensure that unmap queues that is submitted before got
>> +      * processed successfully before returning.
>> +      */
>> +     r = amdgpu_ring_test_helper(kiq_ring);
>>
>>       spin_unlock(&kiq->ring_lock);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index dabc01cf1fbb..6733ff5d9628 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -515,6 +515,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev,
>> int xcc_id)
>>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>               return -EINVAL;
>>
>> +     if (!kiq_ring->sched.ready || adev->job_hang)
>> +             return 0;
>> +     /**
>> +      * This is workaround: only skip kiq_ring test
>> +      * during ras recovery in suspend stage for gfx9.4.3
>> +      */
>> +     if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>> +          amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
>> +         amdgpu_ras_in_recovery(adev))
>> +             return 0;
>> +
>>       spin_lock(&kiq->ring_lock);
>>       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
>>                                       adev->gfx.num_compute_rings)) {
>> @@ -528,20 +539,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device
>> *adev, int xcc_id)
>>                                          &adev->gfx.compute_ring[j],
>>                                          RESET_QUEUES, 0, 0);
>>       }
>> -
>> -     /**
>> -      * This is workaround: only skip kiq_ring test
>> -      * during ras recovery in suspend stage for gfx9.4.3
>> +     /* Submit unmap queue packet */
>> +     amdgpu_ring_commit(kiq_ring);
>> +     /*
>> +      * Ring test will do a basic scratch register change check. Just run
>> +      * this to ensure that unmap queues that is submitted before got
>> +      * processed successfully before returning.
>>        */
>> -     if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>> -         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
>> -         amdgpu_ras_in_recovery(adev)) {
>> -             spin_unlock(&kiq->ring_lock);
>> -             return 0;
>> -     }
>> +     r = amdgpu_ring_test_helper(kiq_ring);
>>
>> -     if (kiq_ring->sched.ready && !adev->job_hang)
>> -             r = amdgpu_ring_test_helper(kiq_ring);
>>       spin_unlock(&kiq->ring_lock);
>>
>>       return r;
>> @@ -569,8 +575,11 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev,
>> int xcc_id)
>>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>               return -EINVAL;
>>
>> -     spin_lock(&kiq->ring_lock);
>> +     if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
>> +             return 0;
>> +
>>       if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
>> +             spin_lock(&kiq->ring_lock);
>>               if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
>>                                               adev->gfx.num_gfx_rings)) {
>>                       spin_unlock(&kiq->ring_lock);
>> @@ -583,11 +592,17 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device
>> *adev, int xcc_id)
>>                                                  &adev->gfx.gfx_ring[j],
>>                                                  PREEMPT_QUEUES, 0, 0);
>>               }
>> -     }
>> +             /* Submit unmap queue packet */
>> +             amdgpu_ring_commit(kiq_ring);
>>
>> -     if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
>> +             /*
>> +              * Ring test will do a basic scratch register change check.
>> +              * Just run this to ensure that unmap queues that is submitted
>> +              * before got processed successfully before returning.
>> +              */
>>               r = amdgpu_ring_test_helper(kiq_ring);
>> -     spin_unlock(&kiq->ring_lock);
>> +             spin_unlock(&kiq->ring_lock);
>> +     }
>>
>>       return r;
>>  }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index f85e545653c7..553a6113fa67 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -4823,6 +4823,13 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_device
>> *adev)
>>               amdgpu_ring_write(kiq_ring, 0);
>>               amdgpu_ring_write(kiq_ring, 0);
>>       }
>> +     /* Submit unmap queue packet */
>> +     amdgpu_ring_commit(kiq_ring);
>> +     /*
>> +      * Ring test will do a basic scratch register change check. Just run
>> +      * this to ensure that unmap queues that is submitted before got
>> +      * processed successfully before returning.
>> +      */
>>       r = amdgpu_ring_test_helper(kiq_ring);
>>       if (r)
>>               DRM_ERROR("KCQ disable failed\n");
>> --
>> 2.25.1
> 
