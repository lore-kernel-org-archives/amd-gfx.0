Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7B0CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 09:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DA910E866;
	Thu,  6 Nov 2025 09:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LCcQYtHX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A2410E86D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 09:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxCnUS9KFGyhhzZavvynVqOMX2D0UJLjkxadP3TU51hRN3Sxd6SOOVdpudWaGb8yJ7Vc1w3el5ffa1UEaVT3x4j05IWmv30zcYeo+mw/+W3QGhOE2qtLv4ul2jLh12qvB1fuiOLC4XfnOF64Cgz7OrNoNEWtNjBV5nH6gY6FpZ30BYvxaITcmmhYkjHC+r2rl9n2BUGDCKjA4H0harMjozm2/R8SpOH9m3Gpq1+kyyKfWRLgKW3m71JC2F/lTDYEUHuIUbtaXDI3yv0bdFxE2W53aGbDxmqF4nIi86XivuhLUxo6eXe3AUa1LQI9qVAJn+F+dE6R3ymQ/Ew2l8LSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l68LucGAJQNODPQnasv1FB9C8unguXV+LhC4PiTynwg=;
 b=nCs/F3ItgEQHVPunx5eO9qC3PDTh1nRZjPArSJ1vRZKLkqmQC3zDx6Vtl1QnCFSTE4hpPlnUgTxULaiXlhjTXHMydkRidl+b4RdkE4P28hsLnw8N5+xhILGmVuXVoGiOpSDfzGftlaJJRbzzwhncmE6YCVz9QPUhWBZYraPAN86rAClav22XQLUzClIG2EjL9SVBw71yN4ZBpvQvhuB/gzgKRxEemYPOexB8zC6SruIdQ1OFBNTfwPmcXpP1idR0OPum05VX9D5CPcx3TWxV5taFaLsS//px3HqKtiM+ZDA4umGjqivwXSUn0GWmssZKsR14+HybNHz0q44rTaWPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l68LucGAJQNODPQnasv1FB9C8unguXV+LhC4PiTynwg=;
 b=LCcQYtHXaUpNrL2RIj2Yizb93pOQFn6jmhERLPsl7yhYUqWm+ZH7os4CybWwgs91AnpuvpXnB/znjA6CEU1E6/GM8p6KfXCsDGOOY5fIM4PM0+JeM1zwczjvMBqsNAp/ufiOpLq43BLOe0biBoo3Jh1Da+fO1qqBpM2dKrkuFpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 09:56:56 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%7]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 09:56:56 +0000
Message-ID: <c4b4b1e4-6bc5-4233-a941-1f1c0943e5f8@amd.com>
Date: Thu, 6 Nov 2025 17:56:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Enable mst when it's detected but yet
 to be initialized
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>
References: <20251106095507.490618-1-Wayne.Lin@amd.com>
From: Tom Chung <chiahsuan.chung@amd.com>
In-Reply-To: <20251106095507.490618-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::16) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c320b6-0044-44a0-a9c9-08de1d1ad1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RENLaWg5eFBNN0xoM2NtV0U3aVNicWRqVEFZTTdjbjZIajhIdU5FWWEzNzZP?=
 =?utf-8?B?QWtVbkVTUW5ldkxMWmVZalRENklwVkl6UVVNRWN3VnVNZ0N5VWZ0anB6cXRD?=
 =?utf-8?B?cWtqOVA4MzRBRWVFUVhYK3I0UkdSNFAvaVJHNURtaWpwMHdYVzZiWHJSYlZZ?=
 =?utf-8?B?cDViVVgxOGJjY2E1WXdXYy8rQUIyTkNvdmNRSWc1SFFLRWZxR1MreWYzYVV2?=
 =?utf-8?B?UXl3UGhpcG82UlNFVzNMWDU3dEhFZlBQK0NNamdwbkp2RnFVYngvTjhxZCtu?=
 =?utf-8?B?WDlsUTJrUVBZTVlQUmFYRk9YWE4xREd1THhHVnZrZFkzTUVJWXpqOUhaUktQ?=
 =?utf-8?B?Z0pVNVd3SlFDWXBWdTdlbHlWbFF6cXhSVW1sa0hXajFEZ2JwKzQrd25qOThT?=
 =?utf-8?B?MXE2TTh4RjZVRzh5cS9DODhMKzV3VW0xd1Z2QzJKN0xLV2VGMXJ5SDBIZHNE?=
 =?utf-8?B?cGRkUU5aRU0rc2QzRGl6a21idWRBUUZBSFQ0TEN2R1kxcDI5ZGlQc0dkVXR2?=
 =?utf-8?B?WnlGY3hWZHE0NURId2hrVGFrTkJ5YjQ4b081Nzk3VHdQaTNuRlhicHNISWFZ?=
 =?utf-8?B?TzJZcGNvYm1xM2tzUkdscGZSL3ZJYVN4R1FHbzA5S0JHNkd4SlVrMU5rOElC?=
 =?utf-8?B?T0s5b3RZZ1VLQ0MwTm1MTW1IQXZ4UGxKVG4yYzBvKzRpM0N1QnFxb0d4YTU4?=
 =?utf-8?B?SGZBREpwUGYwejU2dUJvRFhqOTdhNHdKQW13T3BjQlZwUXVoTjNpanNFZjNH?=
 =?utf-8?B?MHdiZkhvanM4cHorNlBIVlJDdURWY3Y0R1pqWTZLRThDcVo2d3ZGMmpZNm9L?=
 =?utf-8?B?QWJiMThKYkMxdXRsclNFRklncllyTFZQa093Um5WcnNvcmp5Q21yMXNNdXJw?=
 =?utf-8?B?djRIYXk1K0VGL3dYQkcyTjNkbm93OWdyM0l0ejZIVVJTakNXSzdoV0habUlv?=
 =?utf-8?B?TEF1blhwaXVjcmRjZ0plYTZ5TFhwdkVCVS9uU250R241MFpPK1pSQVBpV1Qr?=
 =?utf-8?B?UGR0L2U1QWF6L0RlejRzNmpVcTNpT2I0ejhNbk5sc1VhTHdpbVNObk1zUVpB?=
 =?utf-8?B?QUlQQXVTM2YwSDdRUXVEbzgvaHpSMzBEbElLcFpzQUJPNFBOcVFBekJBUjFM?=
 =?utf-8?B?a3hZVVg0cnozdmMzRVd0RU1UdHhkZFlMOGs4MmI1Q2hOalNta2VVbFFVQllt?=
 =?utf-8?B?ZlRLWEx1VE96c013NWFhVUxVQ2FMb243blZpNmd5NXF3SWtrcTBiZVJlSjZO?=
 =?utf-8?B?OXlpTndleVFFcmJ5SWRIbXg1amtyMVNhWHEvSGYzV25aYXhIRzBuRDZoN0di?=
 =?utf-8?B?MmJUQlY1b2FqQ25leERBcU1qaUE2dzJsNHFrblhDYnNmY1VKMHE3eXFGTWNo?=
 =?utf-8?B?RjZCWHlxUTVBRC9BQzBMZXZvei9xcnNlemlucUkzV1UwMVRnMS9JZjc4d2ZD?=
 =?utf-8?B?T1hPOVcvaDR3RlRFWHc0QnFnTXBrT05sN2dFL05KU3dmNEl6MEhFekd3K3Q5?=
 =?utf-8?B?NnRIblh3Vk5DZmZWb2Z5NEcxTFN0eTdxUFhteFphdFV6dG1HWHhOSFpyRG1v?=
 =?utf-8?B?V0dyY2RyRzkrU0NwRVFKdHZGNzZjYVF1WUZFRGd2dm9SYnZYenQ3dHNYelRJ?=
 =?utf-8?B?V2J4M1poRUR5T1ZaODZKVXk2NTRPZmNHcE1zU2xuQnhKWUpuYmwveGVKamxt?=
 =?utf-8?B?VGlkbnAwblBXYjFIYjR3VkkxWk5UTFM1ZGVOZVlGOTFXNlBUaDZwcCtkK3N3?=
 =?utf-8?B?NlBhNUl1L1cxTnJEbDQzcElhUWhXR1lPT1NpdXd0dDlmUUFIL2FRblp4MWp5?=
 =?utf-8?B?b1RuQkx4bzZDeHpuZHkwT1h1NHBRMHNZVU1BVWxiZllFUGJtVWJKVjY0blJH?=
 =?utf-8?B?SmU1WmVZYTlnVnJqQmtvZERVdUtqNXNidlljUnBocGZ1MWtyM2ozUnNEaDdy?=
 =?utf-8?Q?Ormc/f8t3S+Kap75EujIWvHsppCarB0/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1gyczZzZGlLd1RkY0dtWTY5alpBWk8yTkdCdVVuaGE1OXA2WTBhSXZpTnRL?=
 =?utf-8?B?cGdwaERxc3lVNzRBZW9IaTBaeDQzZUpaam92K0c4YnVrMTF5bGNCK2NCalZZ?=
 =?utf-8?B?R25vS3ZJWi9jclFHaWZYaFM3dnRaeVpvcVhhb0RTTk9PWWNXaEpjZFJDT3d6?=
 =?utf-8?B?U1BNSlRqVlZjQi8rVmJoaWtCNkVCeFNrQnA4dWxiYlV5aHpsS2Y0QzU2ZlZS?=
 =?utf-8?B?ZjV6aGVROXdNZjJJUFc2bGZoWjR2RzRPekt3SWZDSXNpN2xpQzR4emlXR1E3?=
 =?utf-8?B?K0Z2REZRWkgwZVMwVWtBRnV5bDRiaVY3SmovdC8xZE1nK09ZYUpIWHhYUUcr?=
 =?utf-8?B?VktQZmMwWGZac1VoUkFkSnRDcDI2bVR1NkppM1ZrcVpTWnoxOUNCcUJwWmF1?=
 =?utf-8?B?VDNEUjdCNnZsODFOaThkb3VPK3oxNlVvaklqNkpkSnBWNmdkaDZ1MGhlMzB0?=
 =?utf-8?B?Ni9ZWVplT2Rib29jd2NGQ1M4U0krT0FhMkNta1QxeXVwcklJWWpRM3hTbWM5?=
 =?utf-8?B?TEtJTlA0Wi9LbEFiMEMrSkYzNEY3aStuekxGcS9vcHZHTW5GUm1Bb3hNdEZ2?=
 =?utf-8?B?cTJwSnVjMnF0cDBDZE1UTnFyNWRpdEl1Z2FnbjFGc1JIamN4a09lR2h2Qmll?=
 =?utf-8?B?ZFdUckw1MTV2bmhZTU83RTJDSUR6aXJRRnAzd2Zld2NsVk5Rckd3WWVEWlBz?=
 =?utf-8?B?OExtREg5VzJKaWJ2SjF5NGRuTWRxYml1R1ZxSnF4b0xJUWlTWVkxaHR1eXJw?=
 =?utf-8?B?dDRFT3NqSHR1UXIxQm8rUnU3VHg4S0hQK2F4MWRQcWJoWnpYYjEwQzZaL2xT?=
 =?utf-8?B?MWRNQmFCWWZNM0lrc0ZoWndTNlgxcFFHdE1xajEvcWpCSWlmWC9SSGNldVNi?=
 =?utf-8?B?R1lOb3ZNRm14dGp2Umo0ZFRoY28yQWk5S1ZJNHJwQ3VWRUx5L2xEZHgyaWlz?=
 =?utf-8?B?MHZNNnhxd0lYcGkxc3hIcHdnSnA5amphdTVEdkMrK2hYS292M09DRG1IOFdS?=
 =?utf-8?B?cmpFWHA5U3ZPTlg5c21sVkhHOGxrUEZPNkF3QjA3VEdSa0JnOXkvbGk0YUFi?=
 =?utf-8?B?VS9jUmVVVUpGdkxHU1BSUEJtTkg5WFF1Y210T2h1MHhiTVVuckRkTDdEYnZW?=
 =?utf-8?B?OXZrRTlBeGdUZFhSY2NIQWFxU2pRYVJjcFN1b29kZHAyU1ZzRVJjbzdSZlVu?=
 =?utf-8?B?WUNFUEV2Mk9neXFiTmhUelAyY1h4ajY5RjA3QjFBZFd3VjFPNlYvaDFZSndF?=
 =?utf-8?B?Y3hWM1BMMm5uY0I5QlNrTm45NnN0UTZZUjFZcVpLL0x1S0hvUVdBNHYwZUo3?=
 =?utf-8?B?NnRsK0JOZnVMd28wZkxsZHlmTFczYTBMSEVoZERjb0Z2U2cwVTV0cGx1MTVU?=
 =?utf-8?B?SFM5Ly93eDF5RndoeXhzMEI5UWtUVzhrNFd4eXZSY1ZaNHh3eW1BYVJMS0s0?=
 =?utf-8?B?NWhhazhzMmRET0VjYTVaSDBXeTM1aEJzNTBJaytRRHM2MGNUb0VVTlFDWUIw?=
 =?utf-8?B?K1Q4K3ZtOWc1clZhelk1UGhmTG56cUNHY2UrMWc1UGd3cEZwVnJYV3I2cmZW?=
 =?utf-8?B?dXA2L00rMUY5R0FrZVFKQ3piTHM3OWZMZHFPRllUWklNeFJOZEJXbjRYcThw?=
 =?utf-8?B?MHV0M0ZlcC9UZ2d4WXUvU2E1V1NXQ2lyOFpnbDl1L2hrMmFHREpXbHFDN2ZL?=
 =?utf-8?B?YmNSZlMzcHR2OThVMk1KYUZuZUtiREJCL2k1SkgvQTBZYS9NTzhkSU5aTkdi?=
 =?utf-8?B?dTB2TDZ3TUlmYXRUZ25NSGd0WWlVaHU4NDdSaVl4bkk5NDZLM29wUXB3VjFK?=
 =?utf-8?B?Zyt3SkhaNGhwWUVXUmRmanJJaE10bkxNUTRucjNSaDh6b2M1QlNXVEVTY2J5?=
 =?utf-8?B?ZUdsT0F5ck93M1F4WmExdk56ekJIZWRaelZlVkVmSG1pMGRXT0phRXRzMC80?=
 =?utf-8?B?a1BlcjRIS0M2Mm4wZklZbkZVbkljbmk2NGUwM1ZyQ1VuREN3aHZlSmxRL2hU?=
 =?utf-8?B?emZiZW1IeTBnb0VxZWs2ZXp4ODE3ZXNPSVppWndRQWpmVkxTV2N1SzJtTlhT?=
 =?utf-8?B?dVJIbUloRHhzMm50L01JdTZ4WU1XWGZMaUdQZjBqakRpM0x4WjJMUWtYTE5z?=
 =?utf-8?Q?ISx+OosL+tBwhwv26GzjiFRXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c320b6-0044-44a0-a9c9-08de1d1ad1b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:56:56.1338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMObXkIsA5SUpmkDNDJoocxzpAoQs6tgxkW4FW0HygJZqeiTZwdoHCjhqcpLJ4qkA3s+jskK863nsCu6I9jrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 11/6/2025 5:54 PM, Wayne Lin wrote:
> [Why]
> drm_dp_mst_topology_queue_probe() is used under the assumption that
> mst is already initialized. If we connect system with SST first
> then switch to the mst branch during suspend, we will fail probing
> topology by calling the wrong API since the mst manager is yet to
> be initialized.
>
> [How]
> At dm_resume(), once it's detected as mst branc connected, check if
> the mst is initialized already. If not, call
> dm_helpers_dp_mst_start_top_mgr() instead to initialize mst
>
> V2: Adjust the commit msg a bit
>
> Fixes: bc068194f548 ("drm/amd/display: Don't write DP_MSTM_CTRL after LT")
> Cc: Fangzhi Zuo <jerry.zuo@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 35566ac9232e..ba11421332da 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3624,6 +3624,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   	/* Do mst topology probing after resuming cached state*/
>   	drm_connector_list_iter_begin(ddev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> +		bool init = false;
>   
>   		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>   			continue;
> @@ -3633,7 +3634,14 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		    aconnector->mst_root)
>   			continue;
>   
> -		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
> +		scoped_guard(mutex, &aconnector->mst_mgr.lock) {
> +			init = !aconnector->mst_mgr.mst_primary;
> +		}
> +		if (init)
> +			dm_helpers_dp_mst_start_top_mgr(aconnector->dc_link->ctx,
> +				aconnector->dc_link, false);
> +		else
> +			drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
>   	}
>   	drm_connector_list_iter_end(&iter);
>   
