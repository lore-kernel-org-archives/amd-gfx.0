Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5841EEE49A6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 13:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA8210EA1A;
	Wed, 11 Sep 2024 13:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHk3Lv4E";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE58110EA12
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 13:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJo6EPdL7FMxA/YsFcebmm5Grr23FpAgdlW0OtKqE7r6WrWr5/JB5Ppn5nyC6GRDWQSP/rGDobskEC53qKA5gdJJlgu43kZynb2fMmL0ErCWFWPGluJz4qNT9UXCJXp95j2Wf6jf+ZRn+CnbNixxY7zCYhkHUlxTSsmQrEHWEZqKjHSIVgZnxqxdUojir8rLpdbp0V29qq+Dbdq5g+tWOlbiYTiZGtPA1t39kNU97w1hBti/8j7j8QFU6wKUJ5Alf84lcksiXP7/GK/JpUJuFpBUTrIkfiZpesFr4sED3UgkIFTgF4F/6i69/J3KUrSaC6Chi6u/DYk1g31uB5/VRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpajg0fo6j42QkGh8aJN2XQ8CpEAMG9ZLwtj7yVQ84s=;
 b=sK3wCEVoZ5tkGqXwGH+DMkPQ3j5wW5vkiaJZPknmYcPUNgffkB6it9HMteMJsY1ee6fk8YIk4f+HIn+I2WEIkR77LslECcsIzXNNksRNIDbMe3NfkZ3d0lqob7ll/FX+3J3hoJhwuTO/Z3qZv44arZR6RnACfa1WVf1xUXclIQ8VyDWI+RLfzoMRXjuw25LXR+e5K/88VSNoAHO6hEbUaGlWw5M/mAsemmZEgDzY09lbBmcN2mp8dC/nKE1V+Jr8lkii1mbB/wnqlvrD2gZRpXyFrCxhGDpxyejYOhy9jCjAXuR07uSdL28P+qjnW9872LWbVaU5xFE+Cv0DiPr8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpajg0fo6j42QkGh8aJN2XQ8CpEAMG9ZLwtj7yVQ84s=;
 b=tHk3Lv4E3KgApnG4tKwMfvsnlGUNVuo5bOz9n7ge2PSIslvBUh4tGsRq3MdHrwrzP8+MixY9PHMAenLkLqO7ekqqqtWkJ0bWOtPBVYtlkTroCLw8zmHuLDiGBd0DCsw2Tf0g5PRaB2WcxP5JeTv3E3KUX0Y9ogr7dyaS7ZDlbLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 13:40:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7962.017; Wed, 11 Sep 2024
 13:40:22 +0000
Message-ID: <2c6fe61b-d223-40a8-d8ba-974857676512@amd.com>
Date: Wed, 11 Sep 2024 09:40:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for multiple partitions
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20240819175935.4014241-1-Jonathan.Kim@amd.com>
 <0de27442-9271-44ad-9e99-0c719836bad8@gmail.com>
 <CY8PR12MB7435D74AA7571BCFF433369F85992@CY8PR12MB7435.namprd12.prod.outlook.com>
 <5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com>
 <ca0aa805-afca-1758-cf6f-718111f87cd6@amd.com>
 <CY8PR12MB743552BE87CE07964CC89558859A2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <be8eb0ef-2368-47c2-b4bb-d24f8cb0165d@amd.com>
 <a0c252aa-e232-4d61-8dad-3782fe864ba5@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a0c252aa-e232-4d61-8dad-3782fe864ba5@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0299.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a47f7e2-8dd4-4043-615a-08dcd26748d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEhNNUZtVVlnNEZiNHgrcysvWFlCWkNDVXJjOS8wd3lRTTJjbjJ3NDR3c3hl?=
 =?utf-8?B?S1ZydzRteGpuVVZ3K05ldndmKys5WVQwNDVXRTNsZUR1dzM0d0Nzem1DY1NI?=
 =?utf-8?B?bWVPdEFqcEdLcURKaFY0THpIcEYzTkQ2VSsxOGo4bEcyYmJ2eWNsTDBncFE4?=
 =?utf-8?B?S05BVWUxS0hYYURnZGMreDF6L1B1NVVueTRmWjQzY2l5TmNpVDMxL0I1RlRu?=
 =?utf-8?B?VnhNOTQvNnFFYUlKb29JODU4ZGhONTBGdTBxbHYyaUQwOWtkMzJ3T2syMGhI?=
 =?utf-8?B?Mm5tcmpKclpOV1JBNWphQkJzY2JJaVdkb1ZnV0pPazRqN1BNRW1UcmpmTFVX?=
 =?utf-8?B?a3habG5KTDhEbTdVSDZvUURNUFdhWnRSdXNhL09SVDVoMGlaWUVZNGt2VURB?=
 =?utf-8?B?S0dBWHhzSjBtbFdqaEpqaDJyc2RseVFvZjNjT0pIblpYaDZBbHFrcDArckR1?=
 =?utf-8?B?dFVteE56Y1hHWTUrcGpseTBkQkdtTXhBSG4rUDlzQ2JRb0JhUkg2Unc2THNi?=
 =?utf-8?B?WDBscGN4bTdyTFMvRnJ2dHNaVU1lY0gzODNZRjNIdTRHMkNhaWIvWElsY25Q?=
 =?utf-8?B?Ui83WVgxYmRXeU1ERWpLS3N5am5GQjk4OFFuUHZSL241SEpKR3gwN1hjQ2k1?=
 =?utf-8?B?TmI0VnA5amNwUElZVUdOYWM1WXllUXNyUXBjNERtVWxMTzZ4Q0NSY3VRYnlz?=
 =?utf-8?B?aTcrL2JCSnhMRkFFVm8zbHdvRFQ5VThDUE1WRUxBL1ZXeVRoWXJ6QVBCMDFI?=
 =?utf-8?B?UTZTWDBtZGZKakxqTmZub2haQVNuV3VSY2lqWndZWnh0NXB2elZYeS9ONER1?=
 =?utf-8?B?eTBSZ3ZjdXBqYmxPOVdINTV4Z3VtWlh3aXRiYTMyK0g4dUcxTXh1N3RMRnZD?=
 =?utf-8?B?SlVRQWR0Tnl4S1EwRmI0ZzRiSGtZR2pKUk5kWXdiV0p4QjNYOUd0ZXdYNzlv?=
 =?utf-8?B?VzBoS3VYVy9VT2pNNGhIMzhSbWJxbUtVMmE1SCtuc0VQb3ByaExzT1J5NnVJ?=
 =?utf-8?B?QXRiUjNqUVpjcVVENVFvK0FZaVNzQWcwb2NtbUgvYXRiUE1UTE1vNGdRVVQ4?=
 =?utf-8?B?a1BTQ1dhTEhiR1B5ZkZhbnQ1akhzK1kwU0JJdkRGV3RtZzFIWHlreWpXOHlE?=
 =?utf-8?B?a3VXT0dUZXdsNlhDZkkxdm5VWjZqTzVTdzgvTFh5cWNLV1BJcExDTmxSRDk5?=
 =?utf-8?B?WDlFVE1JUUVvTEtnMHNHVzBIcWszR2x6aC9DamxXcU9iZ1RyYnF3cENCNjkr?=
 =?utf-8?B?MmNGTGlrWllXS2VBZUtrOEF1TDkvODN6ZEpFS0p0aWZLNzZHaTcvZFdQTXZp?=
 =?utf-8?B?MGd4NStpUHdHMnZ1K1pxT3A1VXgzNFpuN2g3clE1WGZyMlhiZmdmNW1GM3ZE?=
 =?utf-8?B?TmM3MVg3dGhBeFRFbHl4SndiaWNETE44UHJZcUhSVjByc3JMSUlQRU5KcVN6?=
 =?utf-8?B?Y0FPOWZ5U1NUUWxmTy9TYytLOWRLVUluSm16VThjMTBHSVE2WVpYWE5iSFVJ?=
 =?utf-8?B?RWF1TEk3NnpzcUdIL3llZG9rczBCRWhRMmZnQVk1aDc3bG1qNFZ2TENMNldu?=
 =?utf-8?B?MUEyZTZBdUlmcWp6eDFFcG9raFVsN04wWnA5SWtpbDhrZk93WDNJYTM5SnhF?=
 =?utf-8?B?VnNlakdLa01jU3JNN0preVdjSDRDRVZubUJJQkMrWU5lK0w5VHRkWWdJS1JO?=
 =?utf-8?B?Y1JVWVFldVk1YzQ0Mm9TMWVjaFBYTEJqUWdFanZQSU40eXBvb2JDQTcvN25D?=
 =?utf-8?B?M2pORmZZKytmZ2l4SmkwY0dPMURHQnZGRlFUK1BYWFhRSXRnTUhsZC9uRVRv?=
 =?utf-8?B?TWRhdXliMGxBUjhsU2x0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3o2blJOSHRzWEQ0cTZ1Yzc1VEVWWTBHMC84N1o3ai91ZVpid0phREFUc3Ri?=
 =?utf-8?B?ZHNlZ2ZNYjZDV3M4WGNpU2Fxdi9QU05ORGFZRUN1NXhGQWV1aE8rRXBZU25m?=
 =?utf-8?B?NDRTSnZEcmZoR0J4QWk3aGhQQlBMREo3K05YL3VHNnhNT211SEFFelNTcW5X?=
 =?utf-8?B?WW9PMFBFTkdJMjhXMXIvUFZBSVZoZUVLNklScURzVURyNVBSSm5CTktCVFJa?=
 =?utf-8?B?R0tMR3haZnJCVmhRSjN1MjduUUcrVXJLNWhxQWFVT1J4dUt5QWhxTUEzUFVG?=
 =?utf-8?B?L3Fod0hIaWJvRFM1U1JORlBBZlc5SFhsaHFpZTJnVUF0YW13WDlNZElTUi9D?=
 =?utf-8?B?Mk93Qk9Fc1ZHd25zaUczVkZkMzlobUJOZmdUUnlIWFZNd2phc29Sb0QrM3pl?=
 =?utf-8?B?NkRMbEtBU1Jmb3BhbzhkQVA0UjVyUnJCWno2LzdBaENSMDlrT0dZMVNMQ3JH?=
 =?utf-8?B?ZUtYVjIvSzhmcms2ZTU4L3Yvc05iWDNZSGIwdUVpRHdHVlp6QmZ3VFdsMEZM?=
 =?utf-8?B?QXhIZ1dSeTNGVXBSZUdubXVrdmY4eENOYTEyVXRZKytrMUd4bDhoalVuV1J5?=
 =?utf-8?B?MEJxNVV4SXpWemRxT2cxZ2JGUTJGTkV2a1JCT0RnMERQZ0w0L0FOZFlPcitG?=
 =?utf-8?B?R2JlVTRzTUlWTlhGcE1Dc2J5WHRXUmVqR0c2Tlp2cVRIcnFXVFZGK2toY2sv?=
 =?utf-8?B?TjZ3WmpLN3Z3bTdaWFIxME84djlCV3JBSEJUSVZXWkpMcmFMdnFXemEybVUz?=
 =?utf-8?B?NUd5dDJ4NzczR3hqMVpJN3FLMGJIMXNhOHl1ZjBZaXB4V1QzMGNvSFltKy9a?=
 =?utf-8?B?dUdqRHZCTjVoRHBvU3I4Sm8waXU0amJRV2RLYVQ1cGtOdERtUVoySTNjNVha?=
 =?utf-8?B?dkNnM3NGMy9xc21xUWh5UlF4bDN3blZZTlNZUjJpcmFpQ2x1MlBiQjJKMGFN?=
 =?utf-8?B?dzBrOTR2MXk4d1MwZUlldE9SWHN5WmROVG5HdkFtTG50ai80Wm9XT0ZUaFRQ?=
 =?utf-8?B?UEtRbjJUNmZML2cyUmpQOENKUHNPUHFENHdCR0x4SVVtelZmQ2dseUxNckxJ?=
 =?utf-8?B?RTQwRUg0R2tpZnBmWDNkRjlrdW5WVmZXeG4rVFZLYUI4M21yYUZ3Mk0vYkRy?=
 =?utf-8?B?blRYcG1sSWRuWUJTdVpCdnFEODdKdTJDcmpNL0F5Vk5wYWsrY1MxZHdUNTZk?=
 =?utf-8?B?alFrS2UzUEVSVXZmanNlRDlxY1dYcGFRMERVbFdEdk5GbUJUdmJOallDSFNJ?=
 =?utf-8?B?eVZQaG1yNVRCSWlQRFgrQzdTY0Q0QlNsSzFkbDlSQ1ZMaUtiNkd1cXVqdW9o?=
 =?utf-8?B?RTVhVldNVytSNVlzWUNnRDBVOFpmRW9GS2piVFRDZ3ZWWG9uQkFwUXNRUWtk?=
 =?utf-8?B?V0g4d1FpVEVvNElRUmRLeFVCZmlkSmZjYzlqR291OXdDcUIyR2NTRGxtMnpx?=
 =?utf-8?B?TGlRcmhqMmUveXdSZFhsYjJmTEVYK01MdmpQN2JuWlUwTHVwM096UENIMmJP?=
 =?utf-8?B?ZjRFcEpCUHFzaEkxdVFCOFh5QVM3RUErc1V4OXBydTV5ZlhweTZYYm5FTnRl?=
 =?utf-8?B?dUhELzBIUTcyc3RLN2xJcTZlcTNSU09HRi9PQmFySERoVVpPbXpwZ29hVXJ3?=
 =?utf-8?B?ZVV2L2ZBQ0wreE9jQmFMME90bWxOZzZZZklFMG4vak1yMFdkeXFRTkRpVHFq?=
 =?utf-8?B?SlZQbXNDRGUvRzMxckRSK3ZmZXRSYmRwQnZtSU44MW84ZE8rbHhKUTJBM1Br?=
 =?utf-8?B?cU1VenVTUWlxTWkrcUltaTB1N0swazJsT05EVXZ1dGlhVGhMNjJzVlBZczdD?=
 =?utf-8?B?N2VVS29qZGxqTjhNSXVrNWt2MHBCMnZHL2U1TzBEelhpM0R3OSttWEZuV0Fr?=
 =?utf-8?B?Q1kzTWpUUDNEMGUxQVNBZzE4ZnBaRkNFRXBzS1lzU21UZzBxSkljaFZJZllE?=
 =?utf-8?B?OVBTSWZ2bmVIMGhSREVVaTVuTlNEMTVCbm5xQjVmemIwbzUxYW1iVmMrOVhP?=
 =?utf-8?B?MHc4SUVRTHhFWFZHblVudXZBTXBtaXB2UFFkRElXVWVnSjZiL1E5NTJTMDBF?=
 =?utf-8?B?b3R5TW02SzFEbktOcGJmYmdrS25WUDVJaUlqMExDSU90emhjb2YxejRnTk9W?=
 =?utf-8?Q?/joQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a47f7e2-8dd4-4043-615a-08dcd26748d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:40:22.7476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLVHMo887GTgCwjVfufsOKpIhvuhLwVhMyDPaX8Lcoxjz6RuCr35vQlngw9Zdm4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-09-11 02:54, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a0c252aa-e232-4d61-8dad-3782fe864ba5@amd.com">
      
      Yeah, I completely agree with Xiaogang.<br>
      <br>
      The PASID is an identifier of an address space. And the idea of
      the KFD was that we can just use the same address space and with
      it the page tables for multiple execution devices, e.g. CPUs, GPUs
      etc...<br>
      <br>
      That idea turned out to be a bad one because it clashes with some
      use cases (e.g. native context virtualization). The better
      approach is to see the CPU and GPU processes as separate things
      which just share the same underlying data.<br>
      <br>
      Opening the KFD node multiple times currently results in the same
      KFD process being used. We should probably consider changing that.<br>
    </blockquote>
    <p>It is one KFD process binding to one app process, with count to
      support multiple open/close of for the same process.<br>
    </p>
    <p>The IOMMU most likely uses Linux process pid, not from kfd
      process-&gt;pasid. The KFD process-&gt;pasid is passed to F/W to
      map queues, flush TLB.</p>
    <p>The reason to replace vm-&gt;pasid with KFD process-&gt;pasid is
      to find vm from fault pasid, then for compute vm, find the kfd
      process from pasid.</p>
    <p>I can see a bug in amdgpu_vm_handle_fault, only for compute vm,
      to force update PTE no-retry-fault to the incorrect VM for
      multiple partitions. This patch will fix this bug but we can have
      a simple fix.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a0c252aa-e232-4d61-8dad-3782fe864ba5@amd.com"> <br>
      Regards,<br>
      Christian.<br>
      <br>
      <div class="moz-cite-prefix">Am 11.09.24 um 01:59 schrieb Chen,
        Xiaogang:<br>
      </div>
      <blockquote type="cite" cite="mid:be8eb0ef-2368-47c2-b4bb-d24f8cb0165d@amd.com">
        <p><br>
        </p>
        <p>You want have 1:1 mapping between vm and pasid so can query
          vm from pasid.&nbsp; I think there is a basic existing issue that
          we cannot have vm and pasid 1:1 correspondence.</p>
        <p>PASIDs are global address space identifiers that can be
          shared between the GPU, an IOMMU and the driver. One app
          should have one pasid that iommu uses to decide which page
          table to use when device access system resource. But one app
          can open render/kfd node multiple times even for one gpu. That
          said one app could have multiple GPU vms .</p>
        <p>I think we did not have this issue because app usually open a
          rent node or kfd node only once. With one adev has multiple
          partitions there are multiple vms on one adev, so have this
          issue.&nbsp; But the root cause is not from multiple partitions and
          solution is not to introduce multiple pasids. I think we
          should have one pasid for one app and use different way to get
          vm from pasid.</p>
        <p><br>
        </p>
        <p>Regards</p>
        <p>Xiaogang<br>
        </p>
        <div class="moz-cite-prefix">On 9/10/2024 3:47 PM, Kim, Jonathan
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:CY8PR12MB743552BE87CE07964CC89558859A2@CY8PR12MB7435.namprd12.prod.outlook.com">
          <meta name="Generator" content="Microsoft Word 15 (filtered
            medium)">
          <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@Malgun Gothic";}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
          <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [Public]<br>
          </p>
          <br>
          <div><!-- Yellow caution banner -->
            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="left">
              <tbody>
                <tr>
                  <!-- Remove the next line if you don't want the Yellow bar on the left side -->
                  <td style="background:#ffb900;padding:5pt 2pt 5pt 2pt"><br>
                  </td>
                  <td cellpadding="7px 6px 7px 15px" style="background:#fff8e5;padding:5pt 4pt 5pt
                    12pt;word-wrap:break-word" width="100%">
                    <div style="color:#222222;"><span style="color:#222;
                        font-weight:bold;">Caution:</span> This message
                      originated from an External Source. Use proper
                      caution when opening attachments, clicking links,
                      or responding. </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <br>
            <div>
              <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [Public]<br>
              </p>
              <br>
              <div>
                <div class="WordSection1">
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">KMS
                      open still set per pasid-vm bindings per adev
                      (socket) so I don’t see how the per-partition
                      overwrite PASID issue is primarily a KFD concern.<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Are
                      you saying the KFD process devices holds a shadow
                      copy of the correct VM during page restore during
                      fault?<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Doesn’t
                      it acquire the wrong VM object on process init in
                      the first place?<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Even
                      if it were the case the KFD had a separate VM
                      reference, the underlying IRQ fault handling is
                      still broken.<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">We
                      probably don’t want to bandage over something to
                      fix one symptom.<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Jon<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                  <p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                  <div style="border:none;border-left:solid blue
                    1.5pt;padding:0in 0in 0in 4.0pt">
                    <div>
                      <div style="border:none;border-top:solid #E1E1E1
                        1.0pt;padding:3.0pt 0in 0in 0in">
                        <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                            Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
                            <br>
                            <b>Sent:</b> Tuesday, September 10, 2024
                            11:24 AM<br>
                            <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                            Kim, Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">&lt;Jonathan.Kim@amd.com&gt;</a>;
                            <a class="moz-txt-link-abbreviated
                              moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                            <b>Cc:</b> Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                            Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                            Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com" moz-do-not-send="true">&lt;Mukul.Joshi@amd.com&gt;</a><br>
                            <b>Subject:</b> Re: [PATCH] drm/amdkfd: fix
                            vm-pasid lookup for multiple partitions<o:p></o:p></span></p>
                      </div>
                    </div>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                    <p><o:p>&nbsp;</o:p></p>
                    <div>
                      <p class="MsoNormal">On 2024-09-09 14:46,
                        Christian König wrote:<o:p></o:p></p>
                    </div>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <p class="MsoNormal">Am 09.09.24 um 18:02 schrieb
                        Kim, Jonathan: <br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p class="MsoNormal">[Public] <br>
                          <br>
                          <br>
                          <o:p></o:p></p>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <p class="MsoNormal">-----Original
                            Message----- <br>
                            From: Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
                            <br>
                            Sent: Thursday, September 5, 2024 10:24 AM <br>
                            To: Kim, Jonathan <a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">&lt;Jonathan.Kim@amd.com&gt;</a>;
                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
                            <br>
                            Cc: Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                            Deucher, Alexander <br>
                            <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                            Joshi, Mukul <a href="mailto:Mukul.Joshi@amd.com" moz-do-not-send="true">&lt;Mukul.Joshi@amd.com&gt;</a>
                            <br>
                            Subject: Re: [PATCH] drm/amdkfd: fix
                            vm-pasid lookup for multiple partitions <br>
                            <br>
                            Caution: This message originated from an
                            External Source. Use proper caution <br>
                            when opening attachments, clicking links, or
                            responding. <br>
                            <br>
                            <br>
                            Am 19.08.24 um 19:59 schrieb Jonathan Kim: <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">Currently multiple
                              partitions will incorrectly overwrite the
                              VM lookup <br>
                              table since the table is indexed by PASID
                              and multiple partitions can <br>
                              register different VM objects on the same
                              PASID. <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">That's a rather bad idea.
                            Why do we have the same PASID for different
                            VM <br>
                            objects in the first place? <o:p></o:p></p>
                        </blockquote>
                        <p class="MsoNormal">Alex can probably elaborate
                          on the KGD side, but from what I can see, the
                          KMS driver open call has always assigned a new
                          VM object per PASID on an open call. <br>
                          The KFD acquires and replaces the KGD
                          PASID-VMID registration on its own compute
                          process open/creation call. <br>
                          If this is the bad_idea you're referring to,
                          then someone else will have to chime in.&nbsp; I
                          don't have much history on this unfortunately.
                          <o:p></o:p></p>
                      </blockquote>
                      <p class="MsoNormal"><br>
                        Yeah, Felix and I designed that. <o:p></o:p></p>
                    </blockquote>
                    <p>app opens drm node to create vm for each
                      partition, with different vm-&gt;pasid for each
                      vm, issue is from kfd_ioctl_acquire_vm -&gt;
                      kfd_process_device_init_vm -&gt;&nbsp;
                      amdgpu_amdkfd_gpuvm_set_vm_pasid, to replace all
                      vm-&gt;pasid with kfd process-&gt;pasid, which is
                      from open kfd node. This ends up to store only one
                      vm to adev-&gt;vm_manager.pasids with KFD process
                      pasid, so we cannot retrieve correct vm from
                      adev-&gt;vm_manager.pasids on mGPUs or multiple
                      partitions.<o:p></o:p></p>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <p class="MsoNormal"><br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p class="MsoNormal">That aside, the current
                          problem is, is that all KFD device structures
                          are logical partitions and register their
                          PASID-VM binding using this concept of a
                          device. <o:p></o:p></p>
                      </blockquote>
                      <p class="MsoNormal"><br>
                        As far as I can see that is the fundamental
                        problem. This needs to be fixed instead. <br>
                        <br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p class="MsoNormal">On the KGD side however,
                          the registration table is maintained in the
                          adev struct, which is a physical socket. <br>
                          So there's a mismatch in understanding of what
                          a device is between the KFD &amp; KGD with
                          regard to the look up table that results in
                          bad bindings. <br>
                          <br>
                          Adding a per-partition dimension to the
                          existing lookup table resolves issues where
                          seeing, for example, with memory violation
                          interception and XNACK i.e bad bindings result
                          in wrong vm object found to set no-retry flags
                          on memory violations. <o:p></o:p></p>
                      </blockquote>
                    </blockquote>
                    <p>svm_range_restore_pages retry fault recover uses
                      fault pasid to get kfd process, and use the fault
                      node_id to get pdd-&gt;vm, maybe you can use this
                      way to fix the debugger issue.<o:p></o:p></p>
                    <p>Regards,<o:p></o:p></p>
                    <p>Philip<o:p></o:p></p>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <p class="MsoNormal"><br>
                        Yeah that is pretty much a no-go. <br>
                        <br>
                        The PASID and how it is used is defined by the
                        PCIe specifications. If we now start to assign
                        multiple VMs to the same PASID then we are
                        violating the PCIe specification. <br>
                        <br>
                        The problems you see are most likely just the
                        tip of the iceberg here. <br>
                        <br>
                        Regards, <br>
                        Christian. <br>
                        <br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p class="MsoNormal"><br>
                          Jon <br>
                          <br>
                          <br>
                          <o:p></o:p></p>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <p class="MsoNormal">Regards, <br>
                            Christian. <br>
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">This results in loading
                              the wrong VM object on PASID query. <br>
                              <br>
                              To correct this, setup the lookup table to
                              be per-partition-per-PASID <br>
                              instead. <br>
                              <br>
                              Signed-off-by: Jonathan Kim <a href="mailto:jonathan.kim@amd.com" moz-do-not-send="true">&lt;jonathan.kim@amd.com&gt;</a>
                              <br>
                              --- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp;
                              | 12 ++++ <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;
                              |&nbsp; 1 + <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 4 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 7 ++- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              | 55 +++++++++++------ <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">-- <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              | 11 +++- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 5 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 5 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 5 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 3 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 5 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              | 16 ++---- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 2 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 4 +- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp; 3 +- <br>
                              &nbsp;&nbsp;
                              .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c&nbsp;
                              |&nbsp; 8 +-- <br>
                              &nbsp;&nbsp;
                              .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp;&nbsp;
                              |&nbsp; 8 +-- <br>
                              &nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c&nbsp;&nbsp;
                              |&nbsp; 3 +- <br>
                              &nbsp;&nbsp; 18 files changed, 92 insertions(+), 65
                              deletions(-) <br>
                              <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              c272461d70a9..28db789610e1 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                              <br>
                              @@ -887,3 +887,15 @@ int
                              amdgpu_amdkfd_unmap_hiq(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, u32
                            doorbell_off, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                              &nbsp;&nbsp; } <br>
                              + <br>
                              +int
                              amdgpu_amdkfd_node_id_to_xcc_id(struct
                              amdgpu_device *adev, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">uint32_t node_id) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+{ <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; if
                              (adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc)
                              { <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id =
                              adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(adev,
                              node_id); <br>
                              + <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcc_id &gt;= 0) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xcc_id; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              + <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
                              +} <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              4ed49265c764..bf8bb45d8ab6 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                              <br>
                              @@ -356,6 +356,7 @@ void
                              amdgpu_amdkfd_unreserve_mem_limit(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                              size, u32 alloc_flag, int8_t xcp_id); <br>
                              <br>
                              &nbsp;&nbsp; u64
                              amdgpu_amdkfd_xcp_memory_size(struct
                              amdgpu_device *adev, int <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">xcp_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+int
                              amdgpu_amdkfd_node_id_to_xcc_id(struct
                              amdgpu_device *adev, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">uint32_t node_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; #define
                              KFD_XCP_MEM_ID(adev, xcp_id) \ <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;xcp_mgr
                              &amp;&amp; (xcp_id) &gt;= 0 ?\ <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              c6a1783fc9ef..bf9f8802e18d 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
                              <br>
                              @@ -37,7 +37,7 @@ static enum
                              drm_gpu_sched_stat <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_job_timedout(struct
                            drm_sched_job *s_job) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              amdgpu_job *job = to_amdgpu_job(s_job); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *ti; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                              ring-&gt;adev; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; int idx; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; int idx, xcp_id = !job-&gt;vm ? 0 :
                              job-&gt;vm-&gt;xcp_id; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                              (!drm_dev_enter(adev_to_drm(adev),
                              &amp;idx)) { <br>
                              @@ -62,7 +62,7 @@ static enum
                              drm_gpu_sched_stat <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_job_timedout(struct
                            drm_sched_job *s_job) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              job-&gt;base.sched-&gt;name,
                              atomic_read(&amp;ring-&gt;fence_drv.last_seq),
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              ring-&gt;fence_drv.sync_seq); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; ti =
                              amdgpu_vm_get_task_info_pasid(ring-&gt;adev,
                              job-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; ti =
                              amdgpu_vm_get_task_info_pasid(ring-&gt;adev,
                              job-&gt;pasid, xcp_id); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ti) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Process
                              information: process %s pid %d thread %s
                              pid %d\n&quot;, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              d9fde38f6ee2..e413bf4a3e84 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
                              <br>
                              @@ -1275,17 +1275,20 @@ int
                              amdgpu_info_ioctl(struct drm_device *dev,
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">void *data, struct
                            drm_file *filp) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              amdgpu_vm *vm = &amp;fpriv-&gt;vm; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              drm_amdgpu_info_gpuvm_fault gpuvm_fault; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;gpuvm_fault, 0,
                              sizeof(gpuvm_fault)); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
                              flags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                              adev-&gt;xcp_mgr-&gt;num_xcps; i++) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[i],
                              flags); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuvm_fault.addr =
                              vm-&gt;fault_info.addr; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuvm_fault.status =
                              vm-&gt;fault_info.status; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuvm_fault.vmhub =
                              vm-&gt;fault_info.vmhub; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
                              flags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                              adev-&gt;xcp_mgr-&gt;num_xcps; i++) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[i],
                              flags); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out,
                              &amp;gpuvm_fault, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              min((size_t)size, sizeof(gpuvm_fault))) ?
                              -EFAULT : 0; <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              bcb729094521..f43e1c15f423 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                              @@ -146,7 +146,7 @@ int
                              amdgpu_vm_set_pasid(struct amdgpu_device <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">*adev, struct amdgpu_vm
                            *vm, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
                              0; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) { <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                              xa_err(xa_erase_irq(&amp;adev-&gt;vm_manager.pasids,
                              vm-&gt;pasid)); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                              xa_err(xa_erase_irq(&amp;adev-&gt;vm_manager.pasids[vm-&gt;xcp_id],
                              <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">vm-&gt;pasid)); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r
                              &lt; 0) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                              <br>
                              @@ -154,7 +154,7 @@ int
                              amdgpu_vm_set_pasid(struct amdgpu_device <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">*adev, struct amdgpu_vm
                            *vm, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pasid) { <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                              xa_err(xa_store_irq(&amp;adev-&gt;vm_manager.pasids,
                              pasid, vm, <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                              xa_err(xa_store_irq(&amp;adev-&gt;vm_manager.pasids[vm-&gt;xcp_id],
                              <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">pasid, vm, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              GFP_KERNEL)); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                              @@ -2288,14 +2288,14 @@ static void <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_vm_destroy_task_info(struct
                            kref *kref) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp; static inline struct amdgpu_vm * <br>
                              -amdgpu_vm_get_vm_from_pasid(struct
                              amdgpu_device *adev, u32 pasid) <br>
                              +amdgpu_vm_get_vm_from_pasid(struct
                              amdgpu_device *adev, u32 pasid, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">u32 xcp_id) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
                              flags); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids,
                              pasid); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
                              flags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              flags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              flags); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vm; <br>
                              &nbsp;&nbsp; } <br>
                              @@ -2343,10 +2343,10 @@
                              amdgpu_vm_get_task_info_vm(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_vm *vm) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp; * referenced down
                              with amdgpu_vm_put_task_info. <br>
                              &nbsp;&nbsp;&nbsp; */ <br>
                              &nbsp;&nbsp; struct amdgpu_task_info * <br>
                              -amdgpu_vm_get_task_info_pasid(struct
                              amdgpu_device *adev, u32 pasid) <br>
                              +amdgpu_vm_get_task_info_pasid(struct
                              amdgpu_device *adev, u32 pasid, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">u32 xcp_id) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_get_task_info_vm(
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_vm_get_vm_from_pasid(adev, pasid));
                              <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_vm_get_vm_from_pasid(adev, pasid,
                              xcp_id)); <br>
                              &nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp; static int
                              amdgpu_vm_create_task_info(struct
                              amdgpu_vm *vm) <br>
                              @@ -2481,6 +2481,8 @@ int
                              amdgpu_vm_init(struct amdgpu_device <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">*adev, struct amdgpu_vm
                            *vm, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_bo_unreserve(vm-&gt;root.bo); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;root_bo); <br>
                              <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;xcp_id = xcp_id &lt; 0 ? 0 :
                              xcp_id; <br>
                              + <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
                              <br>
                              &nbsp;&nbsp; error_free_root: <br>
                              @@ -2695,8 +2697,8 @@ void
                              amdgpu_vm_manager_init(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; #else <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_update_mode
                              = 0; <br>
                              &nbsp;&nbsp; #endif <br>
                              - <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_init_flags(&amp;adev-&gt;vm_manager.pasids,
                              XA_FLAGS_LOCK_IRQ); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; MAX_XCP; i++) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_init_flags(&amp;(adev-&gt;vm_manager.pasids[i]),
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">XA_FLAGS_LOCK_IRQ); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp; /** <br>
                              @@ -2708,10 +2710,15 @@ void
                              amdgpu_vm_manager_init(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp; */ <br>
                              &nbsp;&nbsp; void amdgpu_vm_manager_fini(struct
                              amdgpu_device *adev) <br>
                              &nbsp;&nbsp; { <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids));
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_destroy(&amp;adev-&gt;vm_manager.pasids);
                              <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; int i; <br>
                              + <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; MAX_XCP; i++) { <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids[i]));
                              <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_destroy(&amp;adev-&gt;vm_manager.pasids[i]);
                              <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vmid_mgr_fini(adev); <br>
                              + <br>
                              &nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp; /** <br>
                              @@ -2778,17 +2785,18 @@ bool
                              amdgpu_vm_handle_fault(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, u32
                            pasid, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long
                              irqflags; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value, flags; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; int r; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; int r, xcp_id; <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
                              irqflags); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids,
                              pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; xcp_id =
                              amdgpu_amdkfd_node_id_to_xcc_id(adev,
                              node_id)/adev- <br>
                              gfx.num_xcc_per_xcp; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              irqflags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              pasid); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root =
                              amdgpu_bo_ref(vm-&gt;root.bo); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_compute_context =
                              vm-&gt;is_compute_context; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = NULL; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
                              irqflags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              irqflags); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!root) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false; <br>
                              @@ -2806,11 +2814,11 @@ bool
                              amdgpu_vm_handle_fault(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, u32
                            pasid, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
                              error_unref; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Double check that the VM still
                              exists */ <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
                              irqflags); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids,
                              pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              irqflags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              pasid); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; vm-&gt;root.bo !=
                              root) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm = NULL; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
                              irqflags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              irqflags); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock; <br>
                              <br>
                              @@ -2968,14 +2976,15 @@ void
                              amdgpu_vm_update_fault_cache(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              unsigned int pasid, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                              addr, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
                              status, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                              int vmhub) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                              int vmhub, <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
                              xcp_id) <br>
                              &nbsp;&nbsp; { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
                              flags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              flags); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids,
                              pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; vm =
                              xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              pasid); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Don't update the fault cache if
                              status is 0.&nbsp; In the multiple <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fault case, subsequent faults
                              will return a 0 status which is <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * useless for userspace and
                              replaces the useful fault status, so <br>
                              @@ -3008,7 +3017,7 @@ void
                              amdgpu_vm_update_fault_cache(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              WARN_ONCE(1, &quot;Invalid vmhub %u\n&quot;, vmhub);
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
                              flags); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;
                              xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
                              flags); <br>
                              &nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp; /** <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              046949c4b695..1499f5f731e9 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h <br>
                              @@ -35,6 +35,7 @@ <br>
                              &nbsp;&nbsp; #include &quot;amdgpu_sync.h&quot; <br>
                              &nbsp;&nbsp; #include &quot;amdgpu_ring.h&quot; <br>
                              &nbsp;&nbsp; #include &quot;amdgpu_ids.h&quot; <br>
                              +#include &quot;amdgpu_xcp.h&quot; <br>
                              <br>
                              &nbsp;&nbsp; struct drm_exec; <br>
                              <br>
                              @@ -418,6 +419,9 @@ struct amdgpu_vm { <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cached fault info */ <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_fault_info
                              fault_info; <br>
                              + <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; /* XCP ID */ <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; int xcp_id; <br>
                              &nbsp;&nbsp; }; <br>
                              <br>
                              &nbsp;&nbsp; struct amdgpu_vm_manager { <br>
                              @@ -456,7 +460,7 @@ struct
                              amdgpu_vm_manager { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PASID to VM mapping, will be
                              used in interrupt context to <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * look up VM of a page fault <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; struct
                              xarray&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasids; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; struct
                              xarray&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              pasids[MAX_XCP]; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Global registration of recent
                              page fault information */ <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_fault_info&nbsp;&nbsp;&nbsp;&nbsp;
                              fault_info; <br>
                              &nbsp;&nbsp; }; <br>
                              @@ -550,7 +554,7 @@ bool
                              amdgpu_vm_need_pipeline_sync(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_ring *ring, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; void
                              amdgpu_vm_check_compute_bug(struct
                              amdgpu_device *adev); <br>
                              <br>
                              &nbsp;&nbsp; struct amdgpu_task_info * <br>
                              -amdgpu_vm_get_task_info_pasid(struct
                              amdgpu_device *adev, u32 pasid); <br>
                              +amdgpu_vm_get_task_info_pasid(struct
                              amdgpu_device *adev, u32 pasid, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">u32 xcp_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; struct
                              amdgpu_task_info * <br>
                              &nbsp;&nbsp; amdgpu_vm_get_task_info_vm(struct
                              amdgpu_vm *vm); <br>
                              @@ -649,7 +653,8 @@ void
                              amdgpu_vm_update_fault_cache(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              unsigned int pasid, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                              addr, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
                              status, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                              int vmhub); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                              int vmhub, <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
                              xcp_id); <br>
                              &nbsp;&nbsp; void amdgpu_vm_tlb_fence_create(struct
                              amdgpu_device *adev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              amdgpu_vm *vm, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              dma_fence **fence); <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              f0ceab3ce5bf..24b042febf5c 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c <br>
                              @@ -151,7 +151,8 @@ static int
                              gmc_v10_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1,
                              ~1); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, addr, status, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : <o:p>
                              </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0)); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0), <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!printk_ratelimit()) <br>
                              @@ -161,7 +162,7 @@ static int
                              gmc_v10_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[%s]
                              page fault (src_id:%u ring:%u vmid:%u
                              pasid:%u)\n&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src ?
                              &quot;mmhub&quot; : &quot;gfxhub&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id,
                              entry-&gt;ring_id, entry-&gt;vmid,
                              entry-&gt;pasid); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, 0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; in process %s pid
                              %d thread %s pid %d\n&quot;, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              2797fd84432b..3507046d33e6 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c <br>
                              @@ -122,7 +122,8 @@ static int
                              gmc_v11_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1,
                              ~1); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, addr, status, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : <o:p>
                              </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0)); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0), <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (printk_ratelimit()) { <br>
                              @@ -132,7 +133,7 @@ static int
                              gmc_v11_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &quot;[%s] page fault (src_id:%u ring:%u
                              vmid:%u pasid:%u)\n&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src
                              ? &quot;mmhub&quot; : &quot;gfxhub&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id,
                              entry-&gt;ring_id, entry-&gt;vmid,
                              entry-&gt;pasid); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, 0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_err(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; in
                              process %s pid %d thread %s pid %d)\n&quot;, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              60acf676000b..9844564c6c74 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c <br>
                              @@ -115,7 +115,8 @@ static int
                              gmc_v12_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1,
                              ~1); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, addr, status, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : <o:p>
                              </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0)); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0), <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (printk_ratelimit()) { <br>
                              @@ -125,7 +126,7 @@ static int
                              gmc_v12_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &quot;[%s] page fault (src_id:%u ring:%u
                              vmid:%u pasid:%u)\n&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src
                              ? &quot;mmhub&quot; : &quot;gfxhub&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id,
                              entry-&gt;ring_id, entry-&gt;vmid,
                              entry-&gt;pasid); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, 0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_err(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; in
                              process %s pid %d thread %s pid %d)\n&quot;, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              994432fb57ea..2cdb0cbb7c4d 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c <br>
                              @@ -1268,7 +1268,8 @@ static int
                              gmc_v7_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
                              0; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              ((u64)addr) &lt;&lt;
                              AMDGPU_GPU_PAGE_SHIFT, status, <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0)); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              ((u64)addr) &lt;&lt;
                              AMDGPU_GPU_PAGE_SHIFT, status, <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              AMDGPU_GFXHUB(0), 0); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_fault_stop ==
                              AMDGPU_VM_FAULT_STOP_FIRST) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              gmc_v7_0_set_fault_enable_default(adev,
                              false); <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              86488c052f82..6855caeb7f74 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c <br>
                              @@ -1437,7 +1437,8 @@ static int
                              gmc_v8_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
                              0; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              ((u64)addr) &lt;&lt;
                              AMDGPU_GPU_PAGE_SHIFT, status, <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">AMDGPU_GFXHUB(0)); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              ((u64)addr) &lt;&lt;
                              AMDGPU_GPU_PAGE_SHIFT, status, <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              AMDGPU_GFXHUB(0), 0); <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_fault_stop ==
                              AMDGPU_VM_FAULT_STOP_FIRST) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              gmc_v8_0_set_fault_enable_default(adev,
                              false); <br>
                              @@ -1448,7 +1449,7 @@ static int
                              gmc_v8_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_err(adev-&gt;dev, &quot;GPU fault detected:
                              %d 0x%08x\n&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id,
                              entry-&gt;src_data[0]); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, 0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_err(adev-&gt;dev, &quot; for process %s pid
                              %d thread %s pid %d\n&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              task_info-&gt;process_name,
                              task_info-&gt;tgid, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              b73136d390cc..e183e08b2c02 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c <br>
                              @@ -556,10 +556,12 @@ static int
                              gmc_v9_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int
                              vmhub; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cam_index = 0; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; int ret, xcc_id = 0; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t node_id; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; int ret; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t node_id, xcc_id, xcp_id; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id = entry-&gt;node_id; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; xcc_id =
                              amdgpu_amdkfd_node_id_to_xcc_id(adev,
                              node_id); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; xcp_id =
                              xcc_id/adev-&gt;gfx.num_xcc_per_xcp; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = (u64)entry-&gt;src_data[0]
                              &lt;&lt; 12; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr |= ((u64)entry-&gt;src_data[1]
                              &amp; 0xf) &lt;&lt; 44; <br>
                              @@ -572,12 +574,6 @@ static int
                              gmc_v9_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmhub =
                              AMDGPU_MMHUB1(0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_name = &quot;gfxhub0&quot;; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                              (adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc)
                              { <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_id =
                              adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(adev,
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcc_id &lt; 0) <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_id = 0;
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmhub = xcc_id; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub = &amp;adev-&gt;vmhub[vmhub]; <br>
                              @@ -631,7 +627,7 @@ static int
                              gmc_v9_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              retry_fault ? &quot;retry&quot; : &quot;no-retry&quot;, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id,
                              entry-&gt;ring_id, entry-&gt;vmid,
                              entry-&gt;pasid); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">xcp_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; for process %s
                              pid %d thread %s pid %d)\n&quot;, <br>
                              @@ -675,7 +671,7 @@ static int
                              gmc_v9_0_process_interrupt(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                              (!amdgpu_sriov_vf(adev)) <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1,
                              ~1); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, addr, status, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">vmhub); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_vm_update_fault_cache(adev,
                              entry-&gt;pasid, addr, status, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">vmhub, xcp_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_err(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &quot;VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,
                              <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              23ef4eb36b40..1ac4224bbe5b 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c <br>
                              @@ -2182,7 +2182,7 @@ static int
                              sdma_v4_0_print_iv_entry(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              instance, addr, entry-&gt;src_id,
                              entry-&gt;ring_id, entry-&gt;vmid, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;pasid); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, 0); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_dbg_ratelimited(adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; for
                              process %s pid %d thread %s pid %d\n&quot;, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              57f16c09abfc..c8b5c0302ca7 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
                              <br>
                              @@ -1683,6 +1683,8 @@ static int
                              sdma_v4_4_2_print_iv_entry(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int instance; <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *task_info;
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcc_id =
                              amdgpu_amdkfd_node_id_to_xcc_id(adev,
                              entry- <br>
                              node_id); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id =
                              xcc_id/adev-&gt;gfx.num_xcc_per_xcp; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =
                              sdma_v4_4_2_irq_id_to_seq(adev,
                              entry-&gt;client_id); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (instance &lt; 0 || instance
                              &gt;= adev-&gt;sdma.num_instances) { <br>
                              @@ -1698,7 +1700,7 @@ static int
                              sdma_v4_4_2_print_iv_entry(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">amdgpu_device *adev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              instance, addr, entry-&gt;src_id,
                              entry-&gt;ring_id, entry-&gt;vmid, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              entry-&gt;pasid); <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(adev,
                              entry-&gt;pasid, <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">xcp_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_dbg_ratelimited(adev-&gt;dev, &quot; for
                              process %s pid %d thread %s <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">pid %d\n&quot;, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              task_info-&gt;process_name,
                              task_info-&gt;tgid, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              ea3792249209..c098fbaf0e1c 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
                              <br>
                              @@ -1262,8 +1262,9 @@ void
                              kfd_signal_reset_event(struct kfd_node <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">*dev) <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                              (dev-&gt;dqm-&gt;detect_hang_count) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              amdgpu_task_info *ti; <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id =
                              dev-&gt;xcp ? dev-&gt;xcp-&gt;id : 0; <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti =
                              amdgpu_vm_get_task_info_pasid(dev-&gt;adev,
                              p-&gt;pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti =
                              amdgpu_vm_get_task_info_pasid(dev-&gt;adev,
                              p-&gt;pasid, <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">xcp_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              if (ti) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              dev_err(dev-&gt;adev-&gt;dev, <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &quot;Queues reset on process %s tid %d thread
                              %s pid %d\n&quot;, <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              8e0d0356e810..d7cbf9525698 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
                              <br>
                              @@ -377,12 +377,8 @@ static void
                              event_interrupt_wq_v10(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">kfd_node *dev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              kfd_hsa_memory_exception_data
                              exception_data; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxhub */ <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type &amp;&amp;
                              dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc)
                              { <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
                              dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(dev-
                              <br>
                              adev, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hub_inst &lt; 0)
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
                              0; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
                              amdgpu_amdkfd_node_id_to_xcc_id(dev-&gt;adev,
                              <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">node_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mmhub
                              */ <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid_type &amp;&amp;
                              client_id == SOC15_IH_CLIENTID_VMC) <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              a9c3580be8c9..4708b8c811a5 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
                              <br>
                              @@ -437,12 +437,8 @@ static void
                              event_interrupt_wq_v9(struct <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">kfd_node *dev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                              kfd_hsa_memory_exception_data
                              exception_data; <br>
                              <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxhub */ <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type &amp;&amp;
                              dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc)
                              { <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
                              dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(dev-
                              <br>
                              adev, <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id); <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hub_inst &lt; 0)
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
                              0; <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type) <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
                              amdgpu_amdkfd_node_id_to_xcc_id(dev-&gt;adev,
                              <o:p> </o:p></p>
                          </blockquote>
                          <p class="MsoNormal">node_id); <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mmhub
                              */ <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid_type &amp;&amp;
                              client_id == SOC15_IH_CLIENTID_VMC) <br>
                              diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
                              <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
                            <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">index
                              ea6a8e43bd5b..b5f2f5b1069c 100644 <br>
                              ---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
                              <br>
                              +++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
                              <br>
                              @@ -251,8 +251,9 @@ void <o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">kfd_smi_event_update_thermal_throttling(struct
                            kfd_node *dev, <br>
                            <br>
                            <o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <p class="MsoNormal">&nbsp;&nbsp; void
                              kfd_smi_event_update_vmfault(struct
                              kfd_node *dev, uint16_t pasid) <br>
                              &nbsp;&nbsp; { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *task_info;
                              <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id = dev-&gt;xcp ?
                              dev-&gt;xcp-&gt;id : 0; <br>
                              <br>
                              -&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(dev-&gt;adev,
                              pasid); <br>
                              +&nbsp;&nbsp;&nbsp;&nbsp; task_info =
                              amdgpu_vm_get_task_info_pasid(dev-&gt;adev,
                              pasid, xcp_id); <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) { <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Report VM faults from
                              user applications, not retry from kernel
                              */ <br>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info-&gt;pid) <o:p></o:p></p>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                      <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                    </blockquote>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
