Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC89E7E0D2
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3A510E445;
	Mon,  9 Feb 2026 18:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="el5CL4EP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A4A10E447
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 18:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOsSrtd6TxT0Uf5Ht4CLWXI4S3dF44nJLDbu4pz0TYrUmf/sdzN49fcCd91gcb2WXFKQFMDFXKbdBXBkdF20ASFEXPiDaxQDJomFlJ44lakAmCj2C09tp+XVMLrFC8x79oPRR3sb5xJ1g5PtnsNRXr0RQdUZZomC05opSeA5lMirlDWV+mnUInARihVQC0Da1IS8cDxW5L10zVVM9DhHlXPdZ/X4QBj+fdFUbMQR5XJWQ1+7CNt0avpxH753q/gStwMCNH+AJutFV9neKS8X7HB2Xfih8YWJLAt8PKCfkNQ4d2FGJyiaengiVSBaJbK4wq2IlaO35ErTCsz9X/pi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dajBK+u4UFK9c6NIwIJ/rLkTCM6Fw2JITh8dGG7wFHc=;
 b=HxAHt1NLvoxLru0gQUas6NYwfby6+rhv5LIUhp9AKvn5Uc8F6Hv0gxFTKOA7PrKnNZ84Nh7k14QWP3H2Qsqr0kzhWxjQTlviuA1hezhil1vug8dVd1+b5tm1F8t1oTMNNN+BGK/oX+w6N+SPa8KWJR3vGinkiw1De3G1VdGV2yuKEo+tps0zNRfi7wX4MpB1hD9E/PzIV0ViNx0yJYaUDw2+NXtSkbSxqQdMURt5Ip+gyHL/C9FYU5JlGZ/fSqb2N0I/s5GcKH23gPTyJtZ7UwwK11IitTyU3iC08+P/gsHaRbdZSva98YyNNF2bNhppo8Y1Kno+uuBUYAoobeJF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dajBK+u4UFK9c6NIwIJ/rLkTCM6Fw2JITh8dGG7wFHc=;
 b=el5CL4EP/gqM/Vexoslm2SBtHgy4H8U/brytXGPdYIyVlwtG37yjgbxdIjzhO6ZiCxUwY6V9ievWq5knqA/831JAboqKdiI6UqF31vcUFi2bxDCCx5fH5GZ8fF7w9OxhUy5x+R86Ey22lQWGJ/rslxStOGAHyE4rKDCQtDZPaH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Mon, 9 Feb 2026 18:12:26 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:12:26 +0000
Message-ID: <b98dca3d-15b3-4202-94eb-cd4063ec12a5@amd.com>
Date: Mon, 9 Feb 2026 11:12:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] drm/amd/display: Add support for external DP bridge
 encoders in DC
To: Rodrigo Siqueira <siqueira@igalia.com>,
 "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
 <aYn9dPS0R5lh7hQO@atmagalia>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <aYn9dPS0R5lh7hQO@atmagalia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c425633-6631-4095-1623-08de6806c778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGNoa0tzZlc0c21wNlZWV09sRHlxaFZPemkxdk5Kd3hqcDduNGg3bXpoa1NJ?=
 =?utf-8?B?WXlUeFl4VGRyZXByeFlWUnF4aTRUZ3JyVEdobkZuT04zUFgrV1ZoNjJOWWlt?=
 =?utf-8?B?cTBVbUx0V0NDYXlyeEg2VjlSRVhQUzViV2FldHJKaGdjaWc1UnBkY1hFNzVV?=
 =?utf-8?B?NFhxYlRPZFhsV3VyWmhRZzFyZTR6dFBJQkJxWjJoSG9sVnJLVUdOZzlnQy82?=
 =?utf-8?B?bHQ1ZHh1UUFjQS94SGs4MXBMLzRNWnJCQ0swMCsrRkhVMGVhMlNxU1dSajNi?=
 =?utf-8?B?OElzT0FvOUY1dk9TaFRiRVd3bVF0R2p5WWE2YjBzb0ZqUTRWT0ZUVUE4SUEz?=
 =?utf-8?B?dzNMR1NXRlZzaGxFbHlyVXpWVEJIbG04czdPZ0FLdTVyMDI1anE5YVpWVURw?=
 =?utf-8?B?L0N6UjhSYkFSZVd0TEtYaHJqRml3QkoyQmpFbTFMSnYyV0ZIaDRubG1yczBy?=
 =?utf-8?B?MFJ0YTM4cmJMU1B3MnBEdThBNWZTOXljNHo5VEgxSEYxV29rdTJkYzRkREJZ?=
 =?utf-8?B?RG5vYjRoVFRwaEZ0WTQxbWt1RERCREJoRU8yaG90dHR1QTBYUjgzZFBEL3BC?=
 =?utf-8?B?WHhMQ0RXTlpXM2VWSWE2eTc3L0NjWTBmVkJLeHdGMklQdk9ZQitEdXZWZmcv?=
 =?utf-8?B?SnhybWxTSVROb0ltdW9IZ1lNVTJqWHRlN2NmUm5YQXkrbXlpOUs4azlsSnZ6?=
 =?utf-8?B?Uzc2U0F6MjczQjVIVlZTL0V0ZmZjdUFzei9IcDhDWjZrVitRamZndzZjd3N1?=
 =?utf-8?B?MGxjYi9xRDE1R0RHSisyUUdFQmFuWFI2WnpsbGRDL2dUbzBkdGFxQ2U2OVB3?=
 =?utf-8?B?OFBpOVlKdFhtMStXbU1jekFGZXJ4QUJ1TE12eDRaQlYwSUZiSWFkSTI4SzJh?=
 =?utf-8?B?bmVwSkZyS1hhbmg0NDRqR29Mc2lRZTJZZ2hBbWs5NWQvdDlvaE84bklUNEox?=
 =?utf-8?B?UG9qWjE0QS9DQXl4UWNhZyttd3JxY1orQlVxeUNPRmxMSlBoT1BoYUNydGxP?=
 =?utf-8?B?ZVZjL0Frb09XZ0tMbjVrU3p4VFJIa3VBRW40eEpHMkNJOTA0ZGxIa1lLbWkx?=
 =?utf-8?B?bGdIUUUyV3VMcjNSMHNoeUQ2VEovOVhtL0JhZVpqcWFtcVVKL2Zvdm1IcTZ4?=
 =?utf-8?B?MlIrVVcvUi9CeFRDc2N5NWlwNWg0dDhnbVU4OHlrQmpSYUk2c3dkTWJsandN?=
 =?utf-8?B?NEFCVHpOODRDQmFURFdqQkRISUtLdGJMMUpMYnF5V3RiOHB1OHhEN2tuY2s2?=
 =?utf-8?B?UDlIVWRtcWZsSk1POFBNWXVHazR1VVYvWFp4R05lYlgreDIwcjlaejZXUVVD?=
 =?utf-8?B?dDIwdU9Ub2E0QTc3Ri9CYnRxRTZqK1pWV3NEQ2ljL2ZKcTdneU9uZUJzcmd2?=
 =?utf-8?B?OVpEbmtjVVc3TFN2R2FweEx3UWNQM2dZaFpwcXh4S3dQYUtLVWNjaXR2MlBp?=
 =?utf-8?B?SE5QcDJKcXIyVjdrd3p5bVFTNVA3bzRNMktyWUNsZkRzRXhlcFcrMjdYZVBW?=
 =?utf-8?B?NXpVMThXaEoxOVJWajZZVzBzRk9lWnMvRERESlh4aG13cFhEc2xMU3B1Wmxo?=
 =?utf-8?B?cFFwRVhKRmR6L1VBNDRXajdsS1h1anVKUnlxdi9zYW55elRqNzJOR3dId05u?=
 =?utf-8?B?Z0MvZDM0c1k5Z2dkL0lnd3RXVUprNmpqRU5uZ3lSN1FVSnZZazAyL2ZjSGlh?=
 =?utf-8?B?TnQ4ZkwwVU5jOTA2dWR3cFl3NzNmaE9XSzNEUHN2UTByV0JadndYZkpqQTRC?=
 =?utf-8?B?UHEzZGxXd1RjdHVKZmdFTUk2TjdBbFgxa1N1M1Q2dXhOeVIvcVg4ZHRvbVRK?=
 =?utf-8?B?NFVIeWFKd0dwVFdqek1kMU1Lb1ltblBEazBsSmFtdytEQ2ZGZENsa1dzMmlU?=
 =?utf-8?B?VzF6cXEwYmZ6TkJYTUZGdlJ4VjZzd0lydzZaQXA1RGw2YXoxbm1TU2FBYkJG?=
 =?utf-8?B?OHRuL0hwcGxYcXlxRTM5VVpsZ0ZMVXorQktRU1FZRlBYZGpob3BVbnlMb2pS?=
 =?utf-8?B?bVNrS0hjUFFEWXZMQlZ3dGJ2YUdwN0wweE4rQUpScCtPb3B4T2ZrcUJla1lu?=
 =?utf-8?B?MVBYbHh5bGtON0MxL1BiZUU4YVVqNUc2R3RndktBb0NPWnhSR0ttLy9iUk9J?=
 =?utf-8?Q?zjog=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFUNVpuS0t3UTRmb2dwNWlER2Jkd3U2clZXMmM4OFBJVzQzMG12ZXVGQ0tN?=
 =?utf-8?B?aERIT1ZzU1cxcmlFdU5rbWdLalQ2dCtKbG80Sk5YZ2l0QW5mUFZncGlxSXZD?=
 =?utf-8?B?azdxY091VHVBdzAwbEw2aUkwNGMrYTF2dFlWK0hVZEo0dDlXQitlODN2cWtr?=
 =?utf-8?B?bTBDZEJMNWI5bFNGai9RamZlQVZkeHlCYXliS2tjRFlrQUZSbE1Ka3RPTXkr?=
 =?utf-8?B?MkJkQlkrWHVHTW8yKzVPSGRVTWcxVzRyT0FIQTNqOEV1bS81WUwwNEo1VHcr?=
 =?utf-8?B?ZXRTTXdONTNaazB0R3NPV2dLeGZsbzMraUhtM2JrbzJ4QmZnMXpiMDE1cldR?=
 =?utf-8?B?MGdja3J3OXc3TWpQb3MwR01mWWRCTEYrUnF3aURXWDl2cWIzWW9MS2NoNnlK?=
 =?utf-8?B?dnlSM3dEM245Y3ZrV3pFT2VzRlBFMWRlUWtsM3dwZzNIdXFaWVp5U2p5WlJE?=
 =?utf-8?B?cHNhY1NqV3d6VlBlRVRubFJWV0xzcjk3KzYvNlpvRExuOEt2RWU5eS9DdkxC?=
 =?utf-8?B?MEo3QmxQaGxySS90TVFnOGs4WWRVN3ByMjV3OTl6U2pITWJWWmNQc1A1UVIz?=
 =?utf-8?B?ZmI4dHFzUkZ0RkF1L3IvbmtyRDNTUk8vQUlOOHUvM1lDbldaVkxHalZqanpr?=
 =?utf-8?B?UjE3bE9vTVZHWGRCTlRUZDkyOUhlNjdURTdoY0cyeHAxTVk5VDlvNXRQRHNu?=
 =?utf-8?B?Zmx6R1gvbUFOdEo0Mm04N3FkelBJbWZQSWlnKy9qLzZPVVFkdjF4ODNENEsx?=
 =?utf-8?B?Sy9pU0R3VnZxd2NmMVRyek12MFlXSGtkY3Y4U3FwU3lGRFdFem84WEJQbU9J?=
 =?utf-8?B?WXZIRENWSHpEZzlmZ1BxNXpNTEFHalNUTS9Ha0NaQXlGam90TElNUzF6NllB?=
 =?utf-8?B?NnhpTGt1MGlwcm5VZm9wRld2ZnJjVklkbm9Kcm9LUXRWSHZCajZjSGdBdnNa?=
 =?utf-8?B?bUNCQjhnRjR5MWZ6bzRMN2dXdDFzS3QxcHVUV0pFSGduU2pwZlpxdnliWFpJ?=
 =?utf-8?B?dkZCVDgyTnNBNVN5MEwwMUVmc2dJSDNiYlJNc2xiNFVFa2MyVlZSeEtRQzRX?=
 =?utf-8?B?UXRTVXVpdCs5aTcreGQ0dHlEQVRQK2t0VmdxaEczTzRhajFOaW02NDU5dWNU?=
 =?utf-8?B?NUhDY0xZcUtSVWRLNW1FSkM4a0lyR0JHRTZZZnpsZG0xeGdSTXdYVlJXR210?=
 =?utf-8?B?SnoxN3kyZTBGZmpTeEttTDZza2NTVVB3S2VoWGgrWlpVZW5NVFIyVTZ5OUwy?=
 =?utf-8?B?QjNUWTFxdkRBME4rNUE5eE5NUjRUV3ZPWUpVbjBRaU8wQkthWE8vTTdIRHli?=
 =?utf-8?B?SkVheGNrVzVHZ0pTSExNTWpuQkwrbVdyR0lMSWxiNFNkczNWYXVPMk1LWG8z?=
 =?utf-8?B?ejg3eFlDbjJhS1lmcHhJT053eFQ1UG9jenN2Z0tzQTNQT1pFa2MxYXgwL0RC?=
 =?utf-8?B?Wi9hOHVSbmp3dUlTei93NzVrcjZSajNMZWNwditRQnBQTmlwYXdTbTE2UUt3?=
 =?utf-8?B?aXJMbUVZSjRNR0J5Y2VHajlHeVRJWHNGWTJpaXlENjM1TG5SajJDbmtPOUlN?=
 =?utf-8?B?MitnNWd1QSs0VXdHNm1WbjRvZG0vVWpxRHE0RmIyL2FBTEFyVDlKZ1F5Vkhw?=
 =?utf-8?B?MGpxN0lYaEZXMnBjVXNhTURxa1A2U3kydnBtcml5dnlCWnFEbzJxQnpMTERs?=
 =?utf-8?B?MXpacTN6bWlXdkhRamNzZ0JPSU5hY0gxcjhrNEg2ZzFGbkhvOVNNKzQxTkN2?=
 =?utf-8?B?YjltejVJR0J1OTVMbW9PcHFTd0Y4ZzZwVGh5dGFsczNlZm1MQktkR1lVamVF?=
 =?utf-8?B?a2Y1VTYvdXlZQUpDTjFXa1FSUDhmWEdUODFUZmd6Y0RDcWZZcG5XMXlpcmEx?=
 =?utf-8?B?MzRmeHU3ZnBpRUhEaVloOTRkVjk1M2JNKzJ2SEM1b2dyRjVqYmZjT2tkMEZx?=
 =?utf-8?B?WjZjZVFKUE4xY1FOR0VGUWpaMUdsS1Q1aE4vbEFkTmtER1lUSVhOMGFISU5D?=
 =?utf-8?B?alhIcE1xZCswVFNodEFXU0hJTXRiUnY5c05TVHMybWUxN1B2c1pYOTl5djI4?=
 =?utf-8?B?RDd5RTdFMlpwUjJkOFhTWVYrQmdIUDFpY1liQnJNOGJUMVR4ZXM3V0t5VkVp?=
 =?utf-8?B?Z3ZRbFN1S1c5VUFXQ2F2dlU1aHFhSkxqVDNsZXY2end4aGFXVTFDNHpDbklG?=
 =?utf-8?B?NFVHV0MrcUJZaHhFNFF4RkxNYTg5eXlxTUQ5UVdTc3hGdWhvTTRCZGd4azFh?=
 =?utf-8?B?dWthb3pNZ0U2TGFiMlhTNHNzQWlkSFdWTC96N3ZJeE0zNTQvNVdQUGdUT0xM?=
 =?utf-8?Q?wcbbhNCf5NHSYIIWEu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c425633-6631-4095-1623-08de6806c778
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:12:26.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXphTAQwJfdOrYRsAvH9+4sbWf/16FZee2GxFaOAlm+NEF33kg4SYG8kkAfNSx68pP3ZkT15uMfTV2OOtfoVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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



On 2/9/26 08:35, Rodrigo Siqueira wrote:
> On 01/26, Timur Kristóf wrote:
>> Some GPUs use external DP bridge encoders NUTMEG and TRAVIS
>> to implement analog and/or LVDS connections. Typically found in
>> CIK APU based laptops or on FM2 motherboards that have analog
>> connectors. These were necessary at the time because Kaveri
>> didn't have a built-in DAC nor LVDS support.
>>
>> These devices sadly don't work transparently and need to be
>> controlled by the driver. This series implements that.
>>
>> The first half of the series contains some minor fixes and
>> refactoring necessary for these external encoders to work.
>> The second half then adds the actual external encoder support.
>>
>> When we query connector information from the VBIOS and
>> discover a connector using such an encoder, let's find the
>> real DisplayPort encoder and use that. Set the connector
>> signal type to DP, so the pre-existing DP code paths can
>> work with it without refactoring every signal type check
>> in the DC code base.
>>
>> With that, we can now enable DC by default on CIK APUs too.
>> DC brings proper support for DP/HDMI audio, DP MST, VRR,
>> 10-bit colors, some HDR features, atomic modesetting, etc.
>> without any loss of functionality.
>>
>> Timur Kristóf (14):
>>    drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
>>    drm/amd/display: Only use analog link encoder with analog engine
>>    drm/amd/display: Only use analog stream encoder with analog engine
>>    drm/amd/display: Add color depth helper function to BIOS parser
>>    drm/amd/display: Refactor DAC load detection, move to HWSS
>>    drm/amd/display: Implement BIOS parser external encoder control
>>    drm/amd/display: Implement DDC probe over AUX channel
>>    drm/amd/display: Add ability for HWSS to prepare the DDC before use
>>    drm/amd/display: Use preferred DP link rate if specified
>>    drm/amd/display: Add DCE HWSS support for external DP bridge encoders
>>    drm/amd/display: Link detection for external DP bridge encoders
>>    drm/amd/display: Use external DP bridge encoders
>>    drm/amd/display: Implement DAC load detection on external DP bridge
>>      encoders
>>    drm/amdgpu: Use DC by default on CIK APUs
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  11 --
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 +
>>   .../gpu/drm/amd/display/dc/bios/bios_parser.c |  46 +++++--
>>   .../drm/amd/display/dc/bios/command_table.c   | 124 ++++++------------
>>   drivers/gpu/drm/amd/display/dc/dc.h           |   4 +
>>   .../gpu/drm/amd/display/dc/dc_bios_types.h    |   6 +-
>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  67 ++++++++++
>>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +
>>   .../drm/amd/display/dc/link/link_detection.c  |  56 ++++----
>>   .../drm/amd/display/dc/link/link_factory.c    |  29 +++-
>>   .../dc/link/protocols/link_dp_capability.c    |   2 +
>>   .../link/protocols/link_edp_panel_control.c   |   8 +-
>>   .../dc/resource/dce100/dce100_resource.c      |   8 +-
>>   .../dc/resource/dce60/dce60_resource.c        |   5 +-
>>   .../dc/resource/dce80/dce80_resource.c        |   3 +-
>>   .../amd/display/include/bios_parser_types.h   |   2 +
>>   17 files changed, 228 insertions(+), 157 deletions(-)
>>
>> -- 
>> 2.52.0
>>
> 
> Hi Alex, Dan, Tom,
> 
> This series is the last to enable amdgpu as the default for all GFX7
> GPUs. In this sense, could you include this series in the weekly
> promotion to check whether everything looks ok from a feature
> perspective?

This series was included in promotion test in previous week and no 
issues were found. However, it breaks CI tests and we will figure out 
what the causes are.

> 
> Thanks
> 

