Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B39CAC582
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 00:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAB210E00F;
	Tue,  9 Sep 2025 00:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+S1+hyW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C57D10E00F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 00:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK4AsfXETfjjC3+CeDxDnXCLGIH0qnTIVzFWcHkRBEc3kzkozpmxvIm16hUaYiCT0kGFMpSAh/CqeHpDN7lOuVun/QtejAVlhAYxfXLzducPtU3JjrZq+MuaAzL/J/2E3O+a971Pf6fCnoAyek37KfEB1SM0Hothsc96btlz/QX2shcFgNhxErqZwWCrNeb+9Ppwzx4Ldr5ywn+x8JWYzKzSWMxKAC9GmjevvMZmG+FhCiJn4Te4eLt9MjsUgbwJA+VPZRyQRz5f3sEPLwpDI8YD4njE/gomM0WNZaJ0q745k/vu7T4j5Iev283B+28xFPHVdceuTJEOzFQrgWZs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH0QdizlVcXi2WaZS0pnfN9znQn/mOx3kOHGUeqswOI=;
 b=qjq25S94ahAmhsHKJg4rRbtUBqZtDr4MrbUtc6fk+9iRqvqLstfREeXFN/jEhG3+EDXl6uX/Ng6Zr37NdFE5XxYJrdtGprg0OdauFQZijK+1llitj4fOpcICtvTwP+q//6Dw0bsZHbKNltcxEq7WwWhAzs19un734bZ6h67UBYdoPrJfRQIhTGbVARdK9kHNHmNOX1EJ+n1Ocl0GCsMVu95+nxuyYwsxw9RqXlGYku+HLo6WdKgExLzOkU1PjAWvWjznpahg0g6+ki8liD5wvut0aGQYFVbDuNKhGHnyXi2bNsVENJVhzqnsURbjwJEyZrneQnorRXIndJhyh3nsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH0QdizlVcXi2WaZS0pnfN9znQn/mOx3kOHGUeqswOI=;
 b=r+S1+hyWcGWY3dIjI3cMpU9XA3b7zcqBM4mILfxYHDvDuBQHiR/utkNLIeId3CwD/DMbghLDZ5Tx303cUyNNnUM+CxeBJ+PsS2GxHDFPcczbpeLCAwQyr1OQelJ7i9S6LoqesRDf5rjmC3+K2V94piMSU4GCXnCYYWOWZA8a9oI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 00:30:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 00:30:57 +0000
Message-ID: <60816311-1f5f-4021-acb3-f56d4d6de6fc@amd.com>
Date: Mon, 8 Sep 2025 18:30:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Remove unnecessary
 amdgpu_irq_get/put"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>
References: <20250908154733.418648-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250908154733.418648-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0a53c4-1f98-4db8-e129-08ddef3824e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE45dXg2YkJGTDJ6RXVaSGR4dVdoUFVSaDdNM1AzL3JuclRnRDViMTB1SG5H?=
 =?utf-8?B?Uldva3lHclowSS9CaTI0WHpQazBGaU5zK1FBT0pOMVRSR05VbVdlNkY0czdU?=
 =?utf-8?B?UWpCOUlLekpqVmNqNi8velBDSGRCUytBcUdLdUtUbHVEN3JhaCs0ZWdMY3cr?=
 =?utf-8?B?VEwxalVwR1VNanAyNG5XNEphRkRCYm85dlE0clZhSWpxVk4xVlhaTktPb0M0?=
 =?utf-8?B?VHRPSDRhekMzNWlCVE9ubExCQm4xR1RDdDZ1VDRLbXVCZTJOOGZ0STRFUlU4?=
 =?utf-8?B?RzZTK0VySVVSWmpEQVVDYW1aeEo3NmNJYTNBVDZtV3I4NTEvNUc0dTVIcG5K?=
 =?utf-8?B?S0NJaTA0bDZDNjV1RWVtalB4M1hOTUU5QzlOdnNvSk1EbTZQV0pYODJEbURN?=
 =?utf-8?B?Z1BLQmVQbFZwWFhsTmIrYUZxb1VwZXRObGp0WGgzOXFYWjFSakVUMmV1dGpK?=
 =?utf-8?B?T1diU0pSM2ZpYWJwZTY2eFdHN01SV05ra3crS3ZmeHFnRnBJTENjWSs3TktI?=
 =?utf-8?B?OWMxcFdCV01rWWpoRVlvclRwZWpQcldrcUhzamxrQUFNeEJLQzVPZmdib3JY?=
 =?utf-8?B?ekJRZ2pDaTJvRFlRL012ZzJranQrZUgwZzUrMGtub1ZmVXdZcEhyNG9ralRV?=
 =?utf-8?B?UHZUVkJNMEtkc1QxcHlKTjdsb1U3Z2RMY1BQWWdBWHlwN05ldzcvOEZMNEEx?=
 =?utf-8?B?RUlwS2N4eG1GRjM2ZVY4eG5abkd2ajlObldtczB2VjRJUFEzNTh2Z1EvcXNZ?=
 =?utf-8?B?VEkrbXB0aXhrR3ZGSG1yVnJXdFhVZVFKdGRHazJoVzIzakZWS05oa21zTzVF?=
 =?utf-8?B?NUl6RzgzdlVHcDhTR2pXbUtUenlybGNvWkltSDdScklrejZrZVVXcWg2Q09y?=
 =?utf-8?B?c3YvdmpuaHJYZFc5QlAyREpvNGVqRzZmRWZmRkZXZmNxTzh0T3p3RDRqSXNC?=
 =?utf-8?B?OFBzS2Z6NEpGbFNUbVBMQXNuQnZuK1c4Yjh0S3F0M2Nyd1lKbm4vSHdHeHFJ?=
 =?utf-8?B?WDMrb0NYOUpwcUxPWUtFeWZ3ZUxGRm41WGZWdHBBYndJVDkraXFUNlhObVZC?=
 =?utf-8?B?aytiVFBEN3BFL25mMExTeDdsai95WnB1TEdIYWxySXo4UU1kc2RZRUQ5VVE1?=
 =?utf-8?B?Y1U1Y3BXanpvT3IvY0VaVjBQYWhXSExVQzdPOG93UE4wZU5JNjVpUiszcDV2?=
 =?utf-8?B?THRPRkxrTE55cnlsSTZVM1RVbjdsRmVJelhoQTBjTFU5ZnBhWVZLM2p5SWRa?=
 =?utf-8?B?Z0ZEWXdqaVVIa1ByMy9tcVBoZVZzRi90TGRZVTN6eU5PSjM3TlJFRWlxRzV3?=
 =?utf-8?B?QXZxNHNVYVN2U3daM1BWSjgvWFE4VXdKVDV4eTFzb2VHS1RiY3dLVnpyRHNF?=
 =?utf-8?B?cXRLZmlmb1dNWmJNWlp0NExqazdCNFNycjVCYjVHbkczQlo0VEc3c2FTb3hq?=
 =?utf-8?B?SXZuWHZZeWp3T0p3VDdENmZ4b3Z0eW5wMjJvTGNkMEdnbG9XVGVLbUs5aGJQ?=
 =?utf-8?B?VVVJUGNTUE5JUzduT21pRFVyNStlZ05JVEQ3RERySFJHZkNjZU9RM25oN0ox?=
 =?utf-8?B?aEhQeHRYRUN6Vk5xQkVjc0dlMWVuOStSTTZhanNiQ0J3Lzd6Q01qaDZYcW1i?=
 =?utf-8?B?dmFwSlJKeDJYajlCSFQ4YmdiYXFmNldwbGlHQ1AvYXdpWjJVZzdhTnJ5OWFr?=
 =?utf-8?B?aG9oZk45SnBwSG5Kd3A3L2toRXFUZ092Q3ZVZFNqU2pMa1ozZ3lXK1pJdUpD?=
 =?utf-8?B?VHFNUmVVODVZWHBCT2VnOC83Wm5ETkVvdEk1M2ZpcE1ONjJKUEM5WWk4eGVp?=
 =?utf-8?Q?txVgDO4sqqEzs//xQLh8eqTfrDNRpLbecbW5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUw2ZXczTEcxSytBU1NCaUd4U0x0eDYzS1B3WU45SEhiOUNqL2oxbEJVWHR3?=
 =?utf-8?B?elY0NkF1Vkx0b0xHbThDbkFReS9vMXIyOUQyK2dyNFFKMmRDNzhNOG1yK0cy?=
 =?utf-8?B?NVJrVkxnc0N0bUlvcWFxZ1kzWlhiMFhkNVZSK0ZBQk5GQ0JiS2FJTXpTWVdh?=
 =?utf-8?B?TXYzY2pjZWJzbzJ1SHlxVThBUG1GcDlxaFBya2dzbXlZNDBHK2R4TFFWMFB6?=
 =?utf-8?B?WlFPV2J3N3FJakcxWjhZaUdza3Brd2NFWWNrU1NIamJSekpJbDU0VjBEWFQr?=
 =?utf-8?B?T0Z4TXVrdGdZUmJxSWRvb1dROGhiK3hOSzE1cWVRUkwxQTBVU2pmWElUejZq?=
 =?utf-8?B?MngvL2FWUDVtRUN1SmdnRXNtMEN1bnR1NWMyRGdRTFBCQWNFdE81SW5jYXA4?=
 =?utf-8?B?Z1l2S1lLaXArVS80blZzU0xhZnFsNTZLNGtPUEJYcXNMNG5kTWp1MnkxVzBu?=
 =?utf-8?B?TVV6N2t0NFE0SGtIVG5PZDZtY1RseUJqMDF4VE02OEU0VVhQNGNFc3czNnNH?=
 =?utf-8?B?MjVOQnFwcFhFeS80KzdlWHBST2lLYUNSQXRwb2QzSm1xbmpXZGJFOERyNG15?=
 =?utf-8?B?bkdFdE5xNjYwVmw0YnViN01qajl5N09ScUp5NkdXV0FVQ2RCK2ZiUUFuWXVR?=
 =?utf-8?B?SW5MUXBwZmdpbFY5OGNxN1ZEclI5c0syNExrdHV1R3d5enQ2N1BDV0N5YVdw?=
 =?utf-8?B?TGpmdnlKNnFoMHlYa2M3aU9pTFBHYlNCYVdEUC9KemVvRDRqbGNNTmRnRmhP?=
 =?utf-8?B?WWU3NnJoeUxmenhNM2ZiVWpkM01IenRnODVtY3hyTi9zbU5NWDVaVW5TcUcr?=
 =?utf-8?B?K3A5VFd2cmdGcGQzZzEwTkQ4TW5mMlNOUk5WWFhSVFBteTJRZUwxallpa0Rn?=
 =?utf-8?B?endNLzFLTU50WXY1c2ZlcndzNllObWdVMEZtaG5jSUM5UGc3b3ZoY3QzODdp?=
 =?utf-8?B?dVBZY2NqRzg3WHUvRGxETmo3Mk9DVjdleUUyYVFLRFJTWCtYb0VMayt5N053?=
 =?utf-8?B?OEpmQUNTSW5SczByYTNQYXRLOEk4S1A0YTF2VERkZ3Z3RFBoY0hVb3hWRENs?=
 =?utf-8?B?eFZHNUlUaWh1dFFwZXB5OGNGZkJlRzcvSkozbFAzSkRwekJkSDY2cDBodTNB?=
 =?utf-8?B?akFuREhnYVRWY05la29SSTZKb1gza0RTSGZHQjhrUlp3M0oyc3N1TEFTaEV5?=
 =?utf-8?B?b1Q0T3I0aWo5M1JMd0ZHaUxQNGM3LzZQUlN0eW5uS2NSVGlBYWN3eHNRdHV0?=
 =?utf-8?B?blhoclNPZTd0SzZOdHE0MnQrTFdzNkJ1YTVtWGtESzk4N3ViUUlPSlZVOE1Y?=
 =?utf-8?B?Ky9XRERuSC9zQ2kzL2xJckxoMnJ3dVNid2l1bU5VWlVIWWk2aUNCRjRHWHVV?=
 =?utf-8?B?aXJqUE5tTjg5K0YzNzcvYkt4OEFneW1YcXFxek93L0NUNTBSL3UyNWc4cWUv?=
 =?utf-8?B?bjdDN1N5WmtCRVNBc0crU1dUNHpOTndlTXdlM3VFUHErL3dRVFpJbUpnYnR6?=
 =?utf-8?B?YmNKTW91dk1MTitWYWlWeS84Zm42NngySkd4RXFZczRzVkE0aHVFanBMc2JH?=
 =?utf-8?B?a3VwdHM0SlhqWFdqeDJSRTk3Rk5xQkNQSDVDU0dzTC83TmEvYzV3TTIraHZP?=
 =?utf-8?B?aGdocm96Q1F3N3BNRlJXUWFnNk40RU5seWxBNXJzK2plUTF0R2U2Y1RhaWhR?=
 =?utf-8?B?NE5jY1YrOXo0T2lXR0VSUGNhZ01LNi9mU3llSFA5V3pUMkthYVJwUjZTWml4?=
 =?utf-8?B?OERFS0I4OHhONEpiR1NoVTFwbnd4UGlxUld5aVJrcnptMG05L1UyOU85NkE4?=
 =?utf-8?B?VkxyNWVIVU5lZXBlbDVvOWtIYzVlU1Npa0dXL3VJc1FpbndTMG5BbkpVbXBR?=
 =?utf-8?B?eFNHMC9HSHRoS2xyZURabjY4UDBWSWFGNVNLL2ZyWjlIUjBFV3VMbVVIazJh?=
 =?utf-8?B?dTJpN1FHMHN5V1ZoOHNMMXVVOUE4b1RBWnJxWmJ6WUFJR09yZEI4YnluaCtU?=
 =?utf-8?B?c0pSMDVMbVZ1NTQyK3AyVk5kSEZhQ3p6ZU9EN24waVdIWm50S2NpNDVPWlJD?=
 =?utf-8?B?OVU2a3FYYUJIRURGUGtVRGE0MnR6U2Y0UEN5UWRlZ3ZjNVVsc05WYlRBaEhI?=
 =?utf-8?Q?7SHM6AaKnqxDY4abZbkibcPaO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a53c4-1f98-4db8-e129-08ddef3824e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 00:30:57.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8w3MErxFKnFpiCZ2UAqz1qfKlgGcs+ZoVT8lVpilr5VYg5nWvKyWeGseq9V7HN0OquB0Th236iVphBXU8a4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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

Hi Alex,

There is a similar patch pending for this week's promotion but specific 
for RX6xxx & RX7700: "drm/amd/display: Allow RX6xxx & RX7700 to invoke 
amdgpu_irq_get/put".

It should be public in two days.

Cheers,
Alex H.

On 9/8/25 09:47, Alex Deucher wrote:
> This reverts commit 3782305ce5807c18fbf092124b9e8303cf1723ae.
> 
> This commit breaks init on some boards so revert for now.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3994
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3936
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 611a935890571..f1ff0f95a719f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8797,6 +8797,16 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>   				 struct amdgpu_crtc *acrtc,
>   				 struct dm_crtc_state *acrtc_state)
>   {
> +	/*
> +	 * We have no guarantee that the frontend index maps to the same
> +	 * backend index - some even map to more than one.
> +	 *
> +	 * TODO: Use a different interrupt or check DC itself for the mapping.
> +	 */
> +	int irq_type =
> +		amdgpu_display_crtc_idx_to_irq_type(
> +			adev,
> +			acrtc->crtc_id);
>   	struct drm_vblank_crtc_config config = {0};
>   	struct dc_crtc_timing *timing;
>   	int offdelay;
> @@ -8849,7 +8859,28 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>   
>   		drm_crtc_vblank_on_config(&acrtc->base,
>   					  &config);
> +
> +		amdgpu_irq_get(
> +			adev,
> +			&adev->pageflip_irq,
> +			irq_type);
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +		amdgpu_irq_get(
> +			adev,
> +			&adev->vline0_irq,
> +			irq_type);
> +#endif
>   	} else {
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +		amdgpu_irq_put(
> +			adev,
> +			&adev->vline0_irq,
> +			irq_type);
> +#endif
> +		amdgpu_irq_put(
> +			adev,
> +			&adev->pageflip_irq,
> +			irq_type);
>   		drm_crtc_vblank_off(&acrtc->base);
>   	}
>   }

