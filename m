Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A38AFC6181
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 20:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A16810E030;
	Fri, 13 Sep 2024 20:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQIhGhUs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B2410ED8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 20:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWKR3wR7qKp6HjmFwR6eiyiI4MCWwDXrgWMs6jAntDRQ4yPTjb7QigDU2SSrp7ybZJY4NLYL0zrCpYaZnbw8L07Kx62yI7U4827ZD4DbdpyNcPEqq4ho7sEm/WCjvp7VBNdxAPJw1u3zDu/mwiWYqsZ1HRQ1zx1DyZHxLvmJZ6hVJzYrj3brWr77En9lGzHsMwHP1VrGZuz37MH4Gl5qA20tGz9/xyw0/mQiZHQjZt5bg+KtjqTAVTUuvBt7kqYkm1cLg5aSPKYm6hSPLNnZud20CAJGwoMyJmarSHkspy8w4pPVtKU1WGmbfXA8+C4qDSDPrmVNTh/pftJAhF8Muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahlIbHTQUD/MlMZukeCis5NQe7sANYYln3BQhjj1ecQ=;
 b=cjtbnStKQajBqo4qFrz2MKSgcgYRgtLw4t4HvTDV7vCvJ/lMrzI1ZRQJPPeVE95iiy9jkuIxqjU3aAkNMIrWCDmC74jHzJfBdODPcR7Ol9vrBYyiQba3fKbsQUllbre7QzruIfN+26cA1NtXnaINJSECuUpvpihmbWp+XDdm9fXQNnwVgX9awxPaUah28lDfuCXHCHLpM62l8vecUskz3bTnXY/EFtAi6fjsceYo25QQd/trmbv4sRCMPbfuk3QBE3f0XLuJiDKOFnKFf17pRXM0hzzFebSkZHUzFW+Cy1o/MWUGdEJuv731OcSmpWfwRnpGdLtJ50R7N1Jd8hcqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahlIbHTQUD/MlMZukeCis5NQe7sANYYln3BQhjj1ecQ=;
 b=iQIhGhUs1pJZoYbbwpnbhja4gNVGnceVRLgutkzEbMPIame1U5PrlGn9mrqrJCJJAu2x+gNxOWlYu2Ppf267lHUELhYD6AUBeDH/GdNOwhJnScnhbEyQDHikZitHDdrDcOvdhvjqURl5voVx3KkQhUv3oSaNaE1Dos5Wl/6JMb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 20:48:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 20:48:57 +0000
Message-ID: <619e24cd-a382-41c7-bcc6-26656156ba3e@amd.com>
Date: Fri, 13 Sep 2024 15:48:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Validate backlight caps are sane
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 amd-gfx@lists.freedesktop.org
References: <20240913180039.38146-1-mario.limonciello@amd.com>
 <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
 <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
 <CADnq5_Pw6CKn-La4kUu0YL=M_4KdZ6PFL7+26pU421kEc30O=g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Pw6CKn-La4kUu0YL=M_4KdZ6PFL7+26pU421kEc30O=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0016.namprd05.prod.outlook.com
 (2603:10b6:803:40::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 32778c33-1658-4438-218b-08dcd4357cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjVublNjZUFQWXpUSWN3c0RXejR5Rm9OblNIUnFuUnMwSnlaT2hYbTRNZkps?=
 =?utf-8?B?cWEwQnU2MGhSVmZoeFNJNVUzVmJLZjYwMUpCY2VXR1pkWC80dFY3RDFlN1d6?=
 =?utf-8?B?OEhLdmoraTRFUk1vdFNWYXNoMmpjeW9BSHlSOVVHcVBIK3k5YUR3aVEwTHp5?=
 =?utf-8?B?aklUNmhCNE43UTNkbUpyRXg2aTAzUHhwQWZFNVVtUzljYjl1c1BDYkdDMDZ0?=
 =?utf-8?B?VTRlZjByWXJ5aHlBWVRxb3JDZTFvY09uY0J2RFpxdW9LMTBpdEpWcm4xN2xj?=
 =?utf-8?B?UUtiaDl3ZzczNDAzdFdSTUwvbHR3ZmRTSzdKb095bUU1Wk9tMjBNeTFTQzhm?=
 =?utf-8?B?QTVVMkk2UEVld3BKalY1T3VQQktkTVprMGpjSDJUNFFzSWJhQzdBUWVNcEMr?=
 =?utf-8?B?bDFIZ3p3eDg5QmtiY2thcWFndERMbnJrMzY5VExrSXBEWWtSd0IyWGNHUkRG?=
 =?utf-8?B?c3U2dXp6MWhNQzU4STNnWk5mODF6bnYzOEFGWEFzSEl2VHpPU3VlUlZlS3Fr?=
 =?utf-8?B?UGl5ZjQ0QWp4RENua3JEMzJzVGg1cjlZd2ZRdXg2aHQ0a0xRMzI3b281RU13?=
 =?utf-8?B?S1ZSdlRLVnluQ3U3czdabnJkQkYxTFpQRjRvWXlneUd0cVdlaFNxUE5tOFky?=
 =?utf-8?B?dXYraHNzcG15YlJnMUFNRndldnJBYnYxWlNoYm54eTZHUVgwdDd5WjlyVWNn?=
 =?utf-8?B?dDVXbVNiaVovMHZtOHA3OXhhL1lwdWI3WXRnbXlLd2dEL090ZlBORzhTZEE3?=
 =?utf-8?B?RGZ0amhuOWdNUys2M2NnSzR1NDl6aTl0d25mcVRuL3J3eHlBMGxUVDFsSzVj?=
 =?utf-8?B?a1JsRjhEa1QyWTZYWlZwNm5wQXBnQmtrNFhHK1JsZ1ZjQm9QMnNCM3JvbkFl?=
 =?utf-8?B?ZDhUZ2NuY1A0SVNvNkpNam5tQ2NTSFFUdnBvYVk2SGNOK2dhemFoU0RMc2Jp?=
 =?utf-8?B?UU1FNWJ0RWdRYlhiKzF3LzN5Wlc3Wlo2Q2c3RlFudytVaTN5cFVWNkx0YmJt?=
 =?utf-8?B?QjVidjcveVd4bElYd21jcEl4YzhlWDBNcjFXam9yMEh4OFA2Q1MwU284cTly?=
 =?utf-8?B?ZzFGRVR3dFdjQ1krSEkzRUh3Um01VlJyTlgwcGhWZ0JuNE1YemRRSTRJTmNT?=
 =?utf-8?B?NUl5UVBPWC85dDJVWXVQWmh1RE9WbGNEQmtONzdhRG9JVjM3RjR6NGpZVVhI?=
 =?utf-8?B?QldlOFNpRE51QzV2RUF5MW1DSmt4NnR5OUdLeUVlNzV5dUdWNVA3WWMyd1Zu?=
 =?utf-8?B?SjkvNXZKd2d3MCtUaWd1VUg1d2NobFE4czFIbVllQlpxdC8va3BkY29ZbFl5?=
 =?utf-8?B?b2ludEJGSHJITExGcTMxdHJJS0RxcHErVytQUWFXSXZYYlRRUXgyYWJzTHF5?=
 =?utf-8?B?eCtPeExab0M0Vlp6QnB5clh1QTJ1QTlrZnZTM21DbHhrcXVvc0RFS1Ywd0dw?=
 =?utf-8?B?cnhZN1hrU3ZlSnZCaVUvc2RTSEgxc2xpQ0tSYUZESE5pSzBtczhQY3A1Qk5h?=
 =?utf-8?B?L2o1aERZeG13QVYwWHB4SWtFcjdPeXRKeUY0SjBET0lpU0FJTzNHbjFIZ0sx?=
 =?utf-8?B?SXd2NG5zNzJOdVBqVS83ZE50WmJvMVlBcXFpSkZsUGh0N1hCOS93a2c5aWQ4?=
 =?utf-8?B?NnRtNk8yQTlibEpuVVQ4c3pHUTFhWVdFdzQ5dkhFVWJ1VjFVaU5rMm9QTU1D?=
 =?utf-8?B?QzduVTAyYi9SRlpRek1VSXlBY2pneko0Y0MybmZadkJCY0tpMFhHbmRoUHVv?=
 =?utf-8?Q?y474YcViyElY0Z2eY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5SK25PMVRaM09OcHVUOE84YUwrRmlEM3pQelhNRnV4LzFxaWRkUTV2ejdJ?=
 =?utf-8?B?QkR3RXBCdDRzY0p2dGQ0Y3J0WDB5c3hTa1EvRmVDRjFLWGZJWENUNHF2bGU3?=
 =?utf-8?B?M2ZmTGFOT1EzODN5MjN3S2Q3ckNVZjJuaW52OFhUcDgrYzhoaTNhSzg5bHk2?=
 =?utf-8?B?K2daRjhTQzIwSi83YmJvWW5ETVFsRng2VCs1cDRaSkpCak5vY1R4eTZBQmhY?=
 =?utf-8?B?RnlaNGt3VUdudHFQeXFJWE1sbVVGVEJ2MElUdTVZOWVyWFN2RXkwc2txd0xE?=
 =?utf-8?B?UVB5R2FDQmF1MXNkbU9oMDhqdzU5aHplVTJsVHZWQzdFNEN4bkVrZHhBZlZh?=
 =?utf-8?B?RHdOMzVzcGUwN1RjYjJiTWtVK0Y5NmdqTnlGUC90cEN5dkQza0FiY0FlUkM1?=
 =?utf-8?B?WCtaSExzTkFKWTFRY0kyOHhZdnZBNzIvaU5VbDQ2RjlzU3lFV25CM0ZyRFNt?=
 =?utf-8?B?RUhLSzRlN1JvcUt5UFUzSmJxa3h2aGtzdk9XdmQ4QiswNU0vL3BxQXg2SVpU?=
 =?utf-8?B?bmxaeXFzd1l2RnlKb3NXSDVydDFxS1dJWnFKVXdiUGdwMUV5dWdscjNneDhr?=
 =?utf-8?B?NTU2elNxa0M3ZWxVNG5wbjNtMmlXeXFRTUpQVENkMEJmVWRiK3RzaXBwM1d4?=
 =?utf-8?B?ZGs2RS9BRDYzMkJvTmc0RUtUWjdMS0tXS3RSTGloallzTUpFUktzTkU1Nngx?=
 =?utf-8?B?ODZ3TkxlaHhIZ3hReVhwTXA5b0lNWjFwM2txNWxONkNlckpacXpWc2ZXSWhQ?=
 =?utf-8?B?UWxZRUk1OWVvU3NvSU53cCtIWkFrZHNkVUxNaHlKcFFlbks0R0xidGE3cDFW?=
 =?utf-8?B?ckZ1ZTFQd0dNZ2lnT1IvTnBpV2gzUGlMZ1NCYWlYWk9XcTZ4U0ppMWtCYmVP?=
 =?utf-8?B?ODNjcHB0R0s1cjMzdS92K3FEc1ZidFZtSGF5WHFGdTVIdHhrWkdGT2lYaDRv?=
 =?utf-8?B?SW9qdTV2VG05dnMwelA4bk5DMml5MGFkSkkvTDNOQ3ZGK0RjTThQNWhtMFhR?=
 =?utf-8?B?aFJjQWpkTDA1aUdYRFJ5aTZtWlgvTUVZb2JIWXRQQlZaNE1QdERpVFBlYVVz?=
 =?utf-8?B?VXNQUkdqQkRNOVRhQUVmd0NOREtaRFFhVTdnWUR3V3dpSmtjaVZzU3hmWWhx?=
 =?utf-8?B?dDc1bkhzdlFYV0UxQnRnb3FEWklETlU4MGJPQWZaMzhpNGtRTjBPNmlyaHpY?=
 =?utf-8?B?eWdmRm9YYWpDUEJWdmJRMTNCbHpQVU5RNVc1QnZqaTU1blV4VlFNclRRU1ky?=
 =?utf-8?B?UHUwUWhhd1JsNDk2WWJMVStXSkFhWHVNNktuYy80YXkvbG9US3Z4NmZKeDBw?=
 =?utf-8?B?aUFIcGpiMGkzV2NwYW1BMEt3bGVNRWZuNXhJdlN1UW1BUDFMTlVFeW5ER04x?=
 =?utf-8?B?eFk0ZW96UW5sT1E1b0twTzNNWmx4djkra2xiU1pmVXJaYXRadHNYR2V4M3RX?=
 =?utf-8?B?V1BUaG4wekNaWngzUENkQllrcTN2OEZuWUEwdktmM3J2OGNRemxmRm8zVlhj?=
 =?utf-8?B?UC9ST29QWXZ5N2RSSEE5R0FIT0xnYlBDOUpNcmExOEgxVnJibkZUcGRFZTlk?=
 =?utf-8?B?RmFDL0ZzZVBiRVdibXlMWHNzZ2U5ajV1NjFlZFdneUROOGxLTnFXU0hmaXdz?=
 =?utf-8?B?NzEyWmNJOUt2dVZockU0VC9LUHFjR1JYaXVQenNlVUtJTmNHRUpiRWlQay9J?=
 =?utf-8?B?OFJ0NEFlbUZ0TDhFSkVZcFZmbGtFVWNUUEpUQm5CY3hqZGRkKzRYV0wwS1kz?=
 =?utf-8?B?Mzc1Z281UjhsQ0hrSHp3MkVpeVZmdXdqdVEvdTh3SGlRc0dHUXdBT3N3c0NT?=
 =?utf-8?B?a1ZRc3l2TzVCbDE4UVd5Y252V1ZFN2JSa0JYTW56RUpXLzBwRkl1TTRTK0No?=
 =?utf-8?B?TzhxQ01nU1lBSElwOUIrUGt2WlpudU5BVzFkUituSzQ3b0FrNlFDVXh0bGF4?=
 =?utf-8?B?ejQ1N1RHNEM4TE9xbTVqeS9hZ1RHSzhSN0hjYnlXVm56ZkpBWnZtbEs4TklS?=
 =?utf-8?B?eHFzd0MvZ2xDaVdVZ0lTZE9Zekpuemc2dWFuQnRsd3VXMkNXR0UwTlpaM0FK?=
 =?utf-8?B?MEgxVDA1VnFWL2JDRlVENWI4NEtEdUtsdy9RQjk2K1BYSGVQR1k2a1ppdm1C?=
 =?utf-8?Q?FcaLNxGo2UK/BIkgU6nSfyPhs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32778c33-1658-4438-218b-08dcd4357cef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:48:57.5355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mggrQubzquI7DNOhr+xn4zGTY0Qm2+9f65Sufry2xZws/wKSvBqpmaWK80Eo4w5QziKpCyqSu7owsXZulnnnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

On 9/13/2024 15:36, Alex Deucher wrote:
> On Fri, Sep 13, 2024 at 2:51 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 9/13/2024 13:47, Harry Wentland wrote:
>>>
>>>
>>> On 2024-09-13 14:00, Mario Limonciello wrote:
>>>> Currently amdgpu takes backlight caps provided by the ACPI tables
>>>> on systems as is.  If the firmware sets maximums that are too low
>>>> this means that users don't get a good experience.
>>>>
>>>> To avoid having to maintain a quirk list of such systems, do a sanity
>>>> check on the values.  Check that the spread is at least half of the
>>>> values that amdgpu would use if no ACPI table was found and if not
>>>> use the amdgpu defaults.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 5942fc4e1c86..ad66f09cd0bb 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>>>>
>>>>    #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
>>>>    #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
>>>> +#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
>>>>    #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
>>>>
>>>>    static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>>>> @@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>>>>               return;
>>>>
>>>>       amdgpu_acpi_get_backlight_caps(&caps);
>>>> +
>>>> +    /* validate the firmware value is sane */
>>>> +    if (caps.caps_valid) {
>>>> +            int spread = caps.max_input_signal - caps.min_input_signal;
>>>> +
>>>> +            if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>>>> +                caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
>>>
>>> Would we still want to allow signals below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT
>>> (but above 0)? The min backlight value of 12 is a bit conservative and
>>> I wouldn't be surprised if systems set it lower via ACPI.
>>>
>>> The rest looks like great checks that we should absolutely have.
>>
>> I'm waffling about that one because Thomas' testing showed that there
>> was some problems with panel power savings when he quirked the Framework
>> panels below their ACPI default (12) in his v6 series of the Framework
>> quirks.
> 
> What about systems without the need for a quirk?  E.g., the vendor put
> a value less than AMDGPU_DM_DEFAULT_MIN_BACKLIGHT in the ACPI tables
> because they validated it and it works.  Won't this break that?
> 

 From what I can tell from the observations that Thomas had (mentioned 
in this commit message) setting it below 12 causes panel power saving to 
not work properly; the issue should be specifically in how DC/DMCUB 
handles that case.

I think once that's fixed we should open it up further.

> Alex
> 
>>
>> So my thought process was we should put in an explicit check for now and
>> then when we have panel power savings working without a modeset landed
>> then we can also add code to the backlight set callback to turn off
>> panel power savings when set below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to
>> prevent the issue he found.
>>
>>>
>>> Harry
>>>
>>>> +                spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>>>> +                spread < AMDGPU_DM_MIN_SPREAD) {
>>>> +                    DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
>>>> +                                  caps.min_input_signal, caps.max_input_signal);
>>>> +                    caps.caps_valid = false;
>>>> +            }
>>>> +    }
>>>> +
>>>>       if (caps.caps_valid) {
>>>>               dm->backlight_caps[bl_idx].caps_valid = true;
>>>>               if (caps.aux_support)
>>>
>>

