Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B495D0E6DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 10:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18DA10E2D3;
	Mon, 21 Oct 2024 10:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fxtKRrxY";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2EB10E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 10:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUXjB0SBUCeEtYFa5ZPHN7Hi2PvlY6BT3HQZVgsIl1gX2jiO3OSop3rSiDPBeCYxzg1YSUqf4VGzj1m8a5ioZCcIkKQOpgiryMwMMjQ0fhbGvkJM6vc6yUB97XPFJ4cuosRtuKxvZ9JEfA4u1dk8h8v3PPj+WQhwTRiVHKWgjrGjtJSohVB1f/v/c0+2PQ8czcaFQyRMwtVZcAwzrFg/f/ev05IkGUkp+9gUxFChQXCNQAVsh/+CKZsaYz+IMaG+GwKVhcOmnJz5iREEHXlfahAVI8DcF6amcbYUUKkgY7ecAlydHJ8TVCWJd11FjtgibF1qXPfyPdFgeo86BPtDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWARFTQi8nin3uqVYZJiwZL+QkeNZdgjX+YxeI2uKlM=;
 b=kmvuddRQbW2TDJRnk4/PRRXpSmxyExtb2HFx1U1ZpldMccSvlf7DLhi3GUBlVa0Ufl5CopnVtDpAlAoTLw7Lw4pYgHi3TXH1oMTw3ggwK2b/1ImiHfKXgVmWhnOoyjbzEhwBVb6A6iQB9YzxJSnmqSouwVqLVniIEBvqmD+oS7ms+z0fi5s26BaJPn0b2kd+g0cABS4hR3Qi9gmtqHCxhMHVQglrEIsVssv1l1DD+Yy3QHicjAbvUSUmXWSzWXKy/jtjDp/ZOLWP354+1WeNWOY7YSfLcNyrEYCOx2FzhM4iYAfdbe2QwvCY+QgWbN9sTjpQy6iI1iT0+F/wcOWlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWARFTQi8nin3uqVYZJiwZL+QkeNZdgjX+YxeI2uKlM=;
 b=fxtKRrxYeGGpXCR1m6t22TgElSoxUC87FswcV/BfUmExnpfHbQ7I+iU708NUOAldMOOsRBqgsDQyJjLNaFoB28saKBzSaAUmGS/dh5fAT9M6MKHY7yAh6jhYfF+Hps5QF/iVsfREJ3kqdDDdA/GpNHXEjUNupIltMLZBk3LQ2B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:08:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:08:14 +0000
Content-Type: multipart/alternative;
 boundary="------------sDIQKIJ4m7lsJ3fzzIdAEv1z"
Message-ID: <62916d2c-5a94-4f07-b6c6-12582948483d@amd.com>
Date: Mon, 21 Oct 2024 12:08:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: change the flush gpu tlb mode to sync
 mode.
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "Raina, Yera" <Yera.Raina@amd.com>
Cc: "cao, lin" <lin.cao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241021055644.158966-1-chongli2@amd.com>
 <7cf21ef7-c43a-4ab8-b439-c845f0b429fa@amd.com>
 <DS7PR12MB57688ACFA41BEA8FD636ECB89B432@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB57688ACFA41BEA8FD636ECB89B432@DS7PR12MB5768.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 852aef3b-69ff-4235-3a80-08dcf1b846e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2h2WUc0SE5sMDdQdEkvWkE1SzcyK0lVcWRSWWtwNUFMRWg1YllHQ2NaMUhk?=
 =?utf-8?B?R2FNWmRCRmFibGx0NXc3aHB4TmRlUmMvVUNrREU3SnBBUmFtY1N1cDhqaUZ2?=
 =?utf-8?B?QVo2S1JKRHY1Vmt6dE9qNTN6OUdPa0NmMTJyZnNzZ1dVVVVENXJIeDVraHdr?=
 =?utf-8?B?bmo2T0tRaEN2enJib0JMY1VsYThPM2R6R2RxamJpT0VWbWU4cUFLOFBETUwy?=
 =?utf-8?B?Y2o3ZlpxUENaUVN0VGRzeldQR3dOUXg2a2svckpFeGx3Tmp4STNnSlNsc2E5?=
 =?utf-8?B?U0kwWU91cFpFWUJxdE1aT09hYkRIM2w4bFdpVkFiNW9IREJWVlVzbVErYXFl?=
 =?utf-8?B?VThDWUwyeVlmT0RPdW5McCtNRzlBNGVWdXFmK3lWSEQvSzJkYmdjb1RkOGtC?=
 =?utf-8?B?VUVUb3RGWDNsbThIcC9tK2FuQ1hPUjJ5RE4rdG4rRjk4UWg1VC9vL21YR0cx?=
 =?utf-8?B?cVU4ZFl6djAyVnVmenp3MFFEaE53cG83MkRUVFk1UFpDS2UrWDlDTFBMb1lC?=
 =?utf-8?B?TWJ6YW9rc2tMdExMMkxtUEZ4cDZIVFBNL1dDRzZHSnp4bmR1Y3hyekw5Uk9u?=
 =?utf-8?B?QUVySW5SdUpqVi9mVEFlV29HSHJSNG5melJSbWdxTExQWHJBeFplSTExeEJW?=
 =?utf-8?B?Mkxibmo4S2k2bEJrMC9BZlJqeDdMeVc2NG15KzNXdGNnblVRTlFqVUJ5OUNi?=
 =?utf-8?B?RUlpanUwVzlQMVVVeEFKZ2gwYU1VM3c2WHhBM3dDc3RUcjQzWkg2RnJsb2ZV?=
 =?utf-8?B?eWJnUG52L1pWZ2kyeVBFWmhYTjVYd0tJOVIxOTlibndwRlQxYVZEc0hmVGJa?=
 =?utf-8?B?NEw2UG5YbVh4YTBhTytOUmdBNGdWQlhJbk54N0ZrdnAzTk1tWGJiYlV1NFBZ?=
 =?utf-8?B?M1lVNGhGZjcyVmtsNGRSb1loVGJUOU5obkJ1WnlCOU5uVGpqeTZGbTJHM0FI?=
 =?utf-8?B?UGlDL0ZjVGRGZ05GWDJySnhjNU5PUG0vWlVLYTg5WGo5aDV3UmIrQk44a0t1?=
 =?utf-8?B?bkZHVXoyL0xiaUFnWkQyOVQwN2lFUkMvV21qL1NwYVhpOEdlQjBxQzZlQU5w?=
 =?utf-8?B?dUtLZlVuMVp2a3dOTm4vSXVFVHp0R05wZ0p2cTNCOGhaSWE3MWU2Y0F2amha?=
 =?utf-8?B?enJjMWN0R3dMK2wwbVdGb0lDc2E4SXNWdjBycXZoUjRHOTFOWWt5WlU5eVF4?=
 =?utf-8?B?Tm1Xc3JZL215Z2tRUDZXKzNIa0svWWdzT0RzVlhCWW12aFZ4NlA1aEt4UjVX?=
 =?utf-8?B?OFBHOWxrekpIRU9CWU1pUEkyTkd2eDNyZlhsZFpDcWRldlIyd1U0Q29INUR0?=
 =?utf-8?B?QU5NdzVWVExIczFXYXdpRmlxaTlLcE5qcTRpL08zNk1Pcm42RHpVakc3QkJa?=
 =?utf-8?B?TUVsOVNIa2QydTgyQWlac2x2UnVyOENWZ1Zza0E2YmlocDNJTWJ6MTVRR1NF?=
 =?utf-8?B?bkpHcDVLMm9Rc3FGT2VmdEhTT0RRMGNlSFZrbXRXZ0RMVExPSUYxc3ZVWm5T?=
 =?utf-8?B?RTJYeEVZdjhTWFZmclgxTjdEWTNGNWZYcXlEa2ZTSldNcDJ6aXR0WVlsc1ps?=
 =?utf-8?B?bWpZNEJhakdZTHdubjIxWkY2bGtXNDJyTTdHNENETWp0ZFRHRHByVWp0YkR4?=
 =?utf-8?B?b3lGOFc4NWY4SWcyTGpBKy95dUFhb1hLVXhEcGlsQ0VzdGNNNEhVVk55TXNm?=
 =?utf-8?B?QkhZRFFOMnlhb0k1WEJkQ1VSRVJJOWpCdHkrR3QrZGJsRjYzZDgrcnB0c3c3?=
 =?utf-8?Q?2AousZ+qdSUHF4ORYQT5WRzCaj+s4AUnzzVZnjm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0ppVXRkd244MUM5dU5jSVpYTkNtOXE5VG9TQ0lOMXVMaE0vWUJHeERaVUtO?=
 =?utf-8?B?d0FDbTVNSFQzMlR6ZGlQMXdvZlhHaHB1UFIxMlQ3WXNROS9VVCtDNXZwOXJZ?=
 =?utf-8?B?bHRHb0ZVKytHZDYydkVJNlpqenJlZWg1NERCV1Ztcnk5TkZnN3UrbnJuVitv?=
 =?utf-8?B?OWc2THdDejJ3UkZmQjRFSnBYQnhsaS9LMjBJRHJTM3FGMWljM3c5ZmRYMEhU?=
 =?utf-8?B?a3JmOVdoVUVKdTVjL3F6dFBLOVJybVRldlpGcDZ4TTl4R09oNElhT3d0WGlO?=
 =?utf-8?B?Y0dqU25OZnllc3hpbTFGM0J6REx6aTYrbTBIUCtSM0tnelVTdzVRMnhHME5T?=
 =?utf-8?B?VEF6Q3phRllKSmE2TXFlUEd1aFhxaU43bS9wSm55cEJneVZFZWt1Ny9vQStw?=
 =?utf-8?B?eTdwbmdhUDBFUm05QU4rOEFsNzlieWVCL1BBTHkzekZSTktZU1Y5Z3VZUUJz?=
 =?utf-8?B?K0VkcytsMnlqZXd1YWdUWGJNNWJ3ZXppTDNHQ0NIVTVpZEs4VzlZRU9wUHNt?=
 =?utf-8?B?N3IzS0pnajdTQXZQekZ3bXIwVzlESVBiZ0VxcElkd2kyOEhQY01kMkhUb2xr?=
 =?utf-8?B?dm9iSmVpY3djV0hsREhxNWJQZDJrYUx5Z2FvVXJzbW5ubEljVzYvUmI1aDRi?=
 =?utf-8?B?Y1p0b1g1dFVGZC8vMExYMSsyTHkyWGR3b1FmUWs4ZmJKNm5YTGtZQS9ZSkw4?=
 =?utf-8?B?U0ZNcFZjU0QxcnhLNTNyMFh1MnplelMvU05PQUpiUWY3RitOWUZxL0VpelRK?=
 =?utf-8?B?TTN6OE04WDI2UXlHa0VPNWovc1pEZEFrUlVyd2tpejRUNWg3MWhxSUk0SVJl?=
 =?utf-8?B?cnBRQ1Q2Ujhmc2dPZHNsZDJkanlYQmMzMmlPZWtjMUV5S3hYZWZveUpsbFpo?=
 =?utf-8?B?SENMMXdwWlZsSnRSbjYzaTJod0IrNC9KczFUdWtMUnhYZVhYUHRYeXgzODZK?=
 =?utf-8?B?MThwZ2laMHdyVUhvNnVMNU5oQ3NORk9GRVNYYmZjK2RmU3NOaGxnU0JoV00z?=
 =?utf-8?B?amRMRURSRGhqYU1uSE5BbkNSTXdkQlZCalhPbnpBMUNwNTlyRC96VHQrUlBs?=
 =?utf-8?B?Y2RUSkh3NzhUZ3VLRkZtd3ZZUWVGUGxiRXYyeFNLWjNqU0dxVkQ5cEtwSHJt?=
 =?utf-8?B?Zm9oZDJuMlk1K2daRkROMXBXRkZxeXY4Slp4MG43QVlZQjRNME9oeXRGeVB3?=
 =?utf-8?B?bFZXbGROWEh3VFNrWWFZK3J4NEMvQ0FEejJXNXlZbWV2THBWNEVRTXBjak9p?=
 =?utf-8?B?T2VubjdlWVdwRUFmdnp2dzNiTnpBa3ZsVGovd0RKYWtpS1BGMWNvamswaThG?=
 =?utf-8?B?Vmgyd0dqUmZpUlhwYlhYTkZwTUNMN2V0b3V1OXNRWUZnaHl3M2g1RWU3eFZL?=
 =?utf-8?B?L2ZENXZqc2hBQzMzRllPNGRVWGhaeEd5MUs5NnVuT204TFBUaWRYZ2E3bmlj?=
 =?utf-8?B?RHdaVjFuMmVleEhMVHhkTUJKRGVvVFZQTmcvRXcwQ2NFa3U1Nm1TSVF6Qkc3?=
 =?utf-8?B?YWN0d21jQk5vTnpxSWVQN0NNdzM0RGFYN3BxVGFNTzI1UUptT1drOG1MS3pJ?=
 =?utf-8?B?Qmh1ZWxRempFOEQ3NzAxd043dVhaL0s4dWM5ck9jN1pzSkdUMitudG01Nm9w?=
 =?utf-8?B?VjdSbW02c0p3eXhnOU9oK0ljOUttMnYzMWVoYkIwbjY5c285RWN5SXM1K28v?=
 =?utf-8?B?aWxncVFyVThiOXZmUElDT1pSb0VBeXRMTWZ1M2JjZUFuaFFaUjRFVGZiOXdI?=
 =?utf-8?B?S0hEVjBBbkJIaWZpdGFNWnJBNmM3aW8yTkNaczJ4eFc0RTFuTmJGVW9uOUYr?=
 =?utf-8?B?T25DN3FzUlRiWHd3TVFjSDRhYnBKSGVnWnlueU40SjBRaDRLbTE1VWZZdVQy?=
 =?utf-8?B?VDB5em5PdUhTU0MvYXE5N1FwSW5pZ0NLV3pML3lWdGJHbzdmakRjUnROTm5a?=
 =?utf-8?B?bzQrc2o5YVFQcXdxdTJKMmVkOVdtYjBHcG55SHJQWUU2Y0tJR0pjSnlvQnRS?=
 =?utf-8?B?SVVrNG85TG04aHBQMERKMFExV3RVV0wxSERxUHdncTMwQStmUytnaGZsemo1?=
 =?utf-8?B?bjBuUHlzWWZDd1lKb2F4ak5KNFJYSlJOcnhCSEl0UEdiclBZdVhqclRRTE9U?=
 =?utf-8?Q?/y6Vbc8vhg7BLyTwU1GuUebTj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852aef3b-69ff-4235-3a80-08dcf1b846e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:08:14.6731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XReRvTEB+zbKRdMFer2mjaN85wtk4vvaWkMDy1eJXfltMPpmcFmqmJxMtxN0k3jp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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

--------------sDIQKIJ4m7lsJ3fzzIdAEv1z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chong,

Andjelkovic just shared a bunch of traces from rocm on teams with me 
which I analyzed.

When you know what you look for it's actually pretty obvious what's 
going on. Just look at the timestamp of the fault and compare that with 
the timestamp of the operation mapping something at the given address.

When mapping an address happens only after accessing an address then 
there is clearly something wrong in the code which coordinates this and 
that is the ROCm stress test tool in this case.

Regards,
Christian.

Am 21.10.24 um 11:02 schrieb Li, Chong(Alan):
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi, Christian, Raina, Yera.
>
> If this issue in rocm, I need assign my ticket SWDEV-459983 
> <https://ontrack-internal.amd.com/browse/SWDEV-459983> to rocm team.
>
> Is there anything to share with the rocm pm?
>
> Such as the Email or chat history or the ticket you talk with Andjelkovic.
>
> Thanks,
>
> Chong.
>
> *From:*Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Monday, October 21, 2024 4:00 PM
> *To:* Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* cao, lin <lin.cao@amd.com>
> *Subject:* Re: [PATCH] drm/amd/amdgpu: change the flush gpu tlb mode 
> to sync mode.
>
> Am 21.10.24 um 07:56 schrieb Chong Li:
>
>     change the gpu tlb flush mode to sync mode to
>
>     solve the issue in the rocm stress test.
>
>
> And again complete NAK to this.
>
> I've already proven together with Andjelkovic that the problem is that 
> the rocm stress test is broken.
>
> The test tries to access memory before it is probably mapped and that 
> is provable by looking into the tracelogs.
>
> Regards,
> Christian.
>
>
>     Signed-off-by: Chong Li<chongli2@amd.com>  <mailto:chongli2@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
>
>       1 file changed, 2 insertions(+), 2 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
>     index 51cddfa3f1e8..4d9ff7b31618 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
>     @@ -98,7 +98,6 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>
>        f->adev = adev;
>
>        f->dependency = *fence;
>
>        f->pasid = vm->pasid;
>
>     - INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>
>        spin_lock_init(&f->lock);
>
>       
>
>        dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>
>     @@ -106,7 +105,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>
>       
>
>        /* TODO: We probably need a separate wq here */
>
>        dma_fence_get(&f->base);
>
>     - schedule_work(&f->work);
>
>       
>
>        *fence = &f->base;
>
>     +
>
>     + amdgpu_tlb_fence_work(&f->work);
>
>       }
>

--------------sDIQKIJ4m7lsJ3fzzIdAEv1z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Chong,<br>
    <br>
    Andjelkovic just shared a bunch of traces from rocm on teams with me
    which I analyzed.<br>
    <br>
    When you know what you look for it's actually pretty obvious what's
    going on. Just look at the timestamp of the fault and compare that
    with the timestamp of the operation mapping something at the given
    address.<br>
    <br>
    When mapping an address happens only after accessing an address then
    there is clearly something wrong in the code which coordinates this
    and that is the ROCm stress test tool in this case.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 21.10.24 um 11:02 schrieb Li,
      Chong(Alan):<br>
    </div>
    <blockquote type="cite" cite="mid:DS7PR12MB57688ACFA41BEA8FD636ECB89B432@DS7PR12MB5768.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.ui-provider
	{mso-style-name:ui-provider;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}ol
	{margin-bottom:0in;}ul
	{margin-bottom:0in;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Hi,
              Christian,&nbsp;
            </span>&nbsp;&nbsp;&nbsp;<span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Raina,
              Yera.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">If
              this issue in rocm, I need assign my ticket
              <a href="https://ontrack-internal.amd.com/browse/SWDEV-459983" moz-do-not-send="true">SWDEV-459983</a> to rocm team.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Is
              there anything to share with the rocm pm?<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Such
              as the Email or chat history or the ticket you talk with
            </span><span class="ui-provider">Andjelkovic.</span><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Thanks,<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Chong.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Monday, October 21, 2024 4:00 PM<br>
                  <b>To:</b> Li, Chong(Alan) <a class="moz-txt-link-rfc2396E" href="mailto:Chong.Li@amd.com">&lt;Chong.Li@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Cc:</b> cao, lin <a class="moz-txt-link-rfc2396E" href="mailto:lin.cao@amd.com">&lt;lin.cao@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: change the
                  flush gpu tlb mode to sync mode.<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Am 21.10.24 um 07:56 schrieb Chong Li:<br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>change the gpu tlb flush mode to sync mode to<o:p></o:p></pre>
            <pre>solve the issue in the rocm stress test.<o:p></o:p></pre>
          </blockquote>
          <p class="MsoNormal"><br>
            And again complete NAK to this.<br>
            <br>
            I've already proven together with <span class="ui-provider">Andjelkovic
              that the problem is that the rocm stress test is broken.</span><br>
            <br>
            <span class="ui-provider">The test tries to access memory
              before it is probably mapped and that is provable by
              looking into the tracelogs.</span><br>
            <br>
            <span class="ui-provider">Regards,</span><br>
            <span class="ui-provider">Christian. </span><br>
            <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Signed-off-by: Chong Li <a href="mailto:chongli2@amd.com" moz-do-not-send="true">&lt;chongli2@amd.com&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--<o:p></o:p></pre>
            <pre> 1 file changed, 2 insertions(+), 2 deletions(-)<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c<o:p></o:p></pre>
            <pre>index 51cddfa3f1e8..4d9ff7b31618 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c<o:p></o:p></pre>
            <pre>@@ -98,7 +98,6 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm<o:p></o:p></pre>
            <pre>  f-&gt;adev = adev;<o:p></o:p></pre>
            <pre>  f-&gt;dependency = *fence;<o:p></o:p></pre>
            <pre>  f-&gt;pasid = vm-&gt;pasid;<o:p></o:p></pre>
            <pre>- INIT_WORK(&amp;f-&gt;work, amdgpu_tlb_fence_work);<o:p></o:p></pre>
            <pre>  spin_lock_init(&amp;f-&gt;lock);<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>&nbsp; dma_fence_init(&amp;f-&gt;base, &amp;amdgpu_tlb_fence_ops, &amp;f-&gt;lock,<o:p></o:p></pre>
            <pre>@@ -106,7 +105,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>&nbsp; /* TODO: We probably need a separate wq here */<o:p></o:p></pre>
            <pre>  dma_fence_get(&amp;f-&gt;base);<o:p></o:p></pre>
            <pre>- schedule_work(&amp;f-&gt;work);<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>&nbsp; *fence = &amp;f-&gt;base;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+ amdgpu_tlb_fence_work(&amp;f-&gt;work);<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
          </blockquote>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------sDIQKIJ4m7lsJ3fzzIdAEv1z--
