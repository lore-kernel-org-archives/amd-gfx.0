Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D59C369CB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 09:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073CE10E51A;
	Tue, 22 Apr 2025 09:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZ24SQjn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A9410E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 09:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAUTjpY+tZScG4ya4GfUyjr0mwrCMSee5uRIWAWle7VkYpqVdKv8hLbXzCXOB88uodj6DmZoYJIXwQ7MweUxARICCbgRKpB5LHijgca2e8qX6B2TU8aW+p2vWRaT9/arGLUvY07SSz6SXoJ/Ps5ClEWtPz7RLwd9WYGoASN7wfk4u5i0bSchLPGWRttcBe11NGMsViX4gTwZeQBEt4EyXo8qW/D7/tOG50jtMuUyfEItolUZZblfHk2RbNEjGS2G2r0OCVzdCVhMK5/sm4aQ+hZrzfNmFQub9/mG2DlyDU9iDUYV8GfROvdcTO3osU2TcnU6eOwsS6rPIRgS1wDdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLltPOGyPbrQq81nVpjec1yixU9hSVioVyP+zzgb2nU=;
 b=MqapPemLaQzS5gZXHgyxTh9jWDdujkQUbQSim2In/zKtSfdzjhMeTHjCq5zSadZMJYps0cHIunbnmXPf9cxYHYCIf6cPgb5lZ/ezuXzNLloEnxzf+d/zKeygSz7c6elRc+4iSclyyBOnVrbuSHVd3byN06BeBtzTV8D/3HwqR+hBN/WmA8es0Y/pwepYi+fphmKUMkkiuYYSs/m+q8WkIu7zZBCLm1gOH+75aEdV30iLILapeEigOPA+FdFgif/C8lBlK4GvVi7jAnZfcAARD6OvGuRO/v8U+rPestCvPO4n8EIjkUoTB3O24ayKPiQnpHTTZUSo8I8nLkpEoy582A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLltPOGyPbrQq81nVpjec1yixU9hSVioVyP+zzgb2nU=;
 b=BZ24SQjnFyCm3RPmYcetLAYq7igjrVbVf5xiYhneCBd2En/E7FWS4ZH6NxxUmzSA9imYb4tkxy2vIbq/Z5TCFs2D10OKDgYWsWtCDVlExI1nYK4TjxWCWS1cV8blPVWmk5dieDJrrMXbZhJ9lKYGO856m/ZtV+F8L6gHeYdLKvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 09:27:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 09:27:58 +0000
Message-ID: <95986ce1-558c-4233-a769-bd08d2478538@amd.com>
Date: Tue, 22 Apr 2025 11:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
To: "Liang, Prike" <Prike.Liang@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
 <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
 <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <1a4990eb-a0cd-43fb-95aa-19dcae93e03c@gmail.com>
 <DS7PR12MB6005329D20C8DE2367BDEC8EFBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005329D20C8DE2367BDEC8EFBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0924d9-d1b7-4597-0877-08dd817ff864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNTSjQ0UGZ3dlUySkM0Tkh2Uy82R3JsZTQ3eE9lYTFZcGRldUMxZmVmTWt5?=
 =?utf-8?B?OG15VFFqQWhIWUtyWmdLT3U1QVllcmNmcW1uOTZ5cm11NktqaWw2QzM0VVpO?=
 =?utf-8?B?RUJPd2pzYzNjSGw3ckRoU2RNZTk5MitpWkUyNnFlMDdWa0pBOVBENzZkbTlP?=
 =?utf-8?B?d1dpbUFlSVR2Rk15OWRxbTI1YzM3dHgvY0kzWHgyaFlWTXVEMWM2U0g3TUFP?=
 =?utf-8?B?eHVHUytCOGdwaDFCRmNOODFCeHU4TXA4YmhtZUpIQlpKVTNaM1lMUkFGSkhN?=
 =?utf-8?B?bzB4REM5MStoNkVOU3BjMklUc0psbWdlbGNaZkZQQmp4MG1LWS9DelBlazc0?=
 =?utf-8?B?TkdmSXpBVjMxUDIxbjVteVBqMWdjdnV2SDVHUE0wYXp1SkRCc0puRnhVNUU5?=
 =?utf-8?B?elVFZXJVS3BLVWprdnZCU0dhS0ZESldHS2VZcFM2N3dLTGZwRnBNS2JneDcz?=
 =?utf-8?B?VlMwOXFnYkNxbEg2YVlRUjlMTFNVVW55c2JnZHp4Vjd6RDMwRmhFVlJab1I2?=
 =?utf-8?B?OVdBYjJOSCtHQmRVN1U4eEFvTytBSkRrV0ZlV1llcXNBbGRQd3M0ZHFCZ0gr?=
 =?utf-8?B?cTcxZUhoekgzTHpZRlgxc1pLWXNqSHQvVE9oWGxmaTRKb0RTa29EMjU1RFB3?=
 =?utf-8?B?NFBnbi85QmduRGxWL2gvb2NzYlRyK1RadU1jMXlSVWFkakltWW5vOUMzRTV4?=
 =?utf-8?B?SVI0TFliNy9RZEsrbkdlelIzTjMyWTRZNXlib3ZrSHpKeUp5V2JKYnlrZ1Zi?=
 =?utf-8?B?WENTOTNMTG1ld1dCMWFLblJxSXZjVnVHV0xmVDBuYWRmN2RqOWloR3hnMFhT?=
 =?utf-8?B?a1FlN0drNDVCMTVlQURVWU1QTFd6ZEw3bnAwV2NzRWRlVUJSK1c2dkJrMk5R?=
 =?utf-8?B?S3krZWNWdXl5b2JtNzdrSDYvZFNIRWo0d2dKbG1IMUNoZkRXN1NwL3F4djVS?=
 =?utf-8?B?RzJkMitxcGNYSi9lKzF5ZXRscjhpMExHSGtOSi9nQ0JIZlJ2ZElZSkNaemxn?=
 =?utf-8?B?ZmhWclpJRkxBQVRYcDVENWFkUG1oR2tQOFhYdnd5MzkrS1NwQnBZZ0xCZ0tM?=
 =?utf-8?B?eGtNZUtlamhTYjl2UlY4dWZzdi9yYkg4M1J2UDdOcGJ4NEJTMDQ5UDVNTmU3?=
 =?utf-8?B?eWt0SHBGSWMvZkNmUmx1Y3gyb1JGTitmRUlIRzdaNm1FZnF3Rkxsc2R5aGFv?=
 =?utf-8?B?UVBtOFkzbVRPc082dUp6UVhBaVlSYVFsUis4c2dFNXk5ZlgvQzhCVHZ4dDFt?=
 =?utf-8?B?RE1zV3BQL1ExT0x5eGlORHh4ZnhwODBlVVA5QnRtQjdLM2VZMkdvWi91N2R6?=
 =?utf-8?B?TXpjeG05SHQyNEJocHRMTUFDcm04eFJub2ZGajlXWGdRRjl6Rzg0L3B5K09O?=
 =?utf-8?B?RWhkSW1GNkxxcHJQejJXcVJEU05GeExLTWViOHhZSjJwS04ycHBuSC9HUGY2?=
 =?utf-8?B?MFd3WlZpaXJmQXFqVWJ5S1JmNGVhaXJhQ3FkQWltZDFaRDlmZVVhS0o2ai8z?=
 =?utf-8?B?YjZBelRTYkxTaGxpaGhVS2QvanNMRHp3YnkrUlo3cWllc0RMbmxjd0crbDhi?=
 =?utf-8?B?K3owM2JFVjUyUVlQcC9TS3JuVDU0VG04LzVnb2ltOFdEanI1Qi9aOFVLYWpx?=
 =?utf-8?B?eWNUNVZYZEdaOHl3UUZBZmxPbVdFWVpYY2dILzNCNDVLVEpWa0R4ZDVCUXho?=
 =?utf-8?B?RVU1UmtnTzlQT1ZLZndyaEFiSUtqc3NKeFAxdHFyU21jcUZUaFlrS3NNYTBV?=
 =?utf-8?B?cmxlZjFWNlZPeWVmbXljRTRSSlRuK2s4a3pnclU0TzR5NkFrdzRXeVVhdlpH?=
 =?utf-8?B?bWRqNnJHajQ5VjFNeWptQmZ6K2g4cU1RUXU4MGR0L3ZIdWk1U2U1MnRhYXJO?=
 =?utf-8?B?ZUpENFNoN3J3RGRzZnhxeEt1NWRRUi81VEFxdUtmb1IxRmRhcEpGU0tuQ0NU?=
 =?utf-8?Q?v83nSTo8v4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkg3RGgxMHpDRkpjWUIrQ1JwZHlkWlZEbHcvcVk4S3VKQ0JsRXY4MmluNGgr?=
 =?utf-8?B?VVhqRnd4dmNRaVZtTzExV3dscnYwYUJWM2l6ZEdSZVBwTXFkSU5HM2sySzN4?=
 =?utf-8?B?M2U1VmVuNEsxMzQ1S3NNVVUvZDdrL0p2ZU82SnEvUkdHNUh4cXFnSVRXR3V4?=
 =?utf-8?B?NDVHLzZMcmVReHJmM29INFRCTGFCM21kcDA5YUs0dTRLUXQ1Slg4bEdNNFdi?=
 =?utf-8?B?c1grcnUrSjlUMUZKMStjbm1ubHhJT2VpQ3hSRHFMZTd2SWVRSnAraWc2SUtv?=
 =?utf-8?B?bEF5VmxPQ1phdHZ4U05maTRBN2QzUDUwajlHZG42Uyt2VnRTMHp5UmsyVmR6?=
 =?utf-8?B?SFNOMkpxM2RSVTlMdlRPdDhiNVl5OS9YSkNGYjZrU1BPQUpnRnBSOW54TUJy?=
 =?utf-8?B?ZmpGbENYbEhOc1VOWnppc0xaSXBoNy9GVnhtZUd3ZWVJRXNkRzVFR0NTSkRI?=
 =?utf-8?B?T0lsUE5rRXFXOWE1NXNxOVFlUXkxbnVCUE5mTVBKSXpSQUN6eW9hQlk0bEh6?=
 =?utf-8?B?LzhJZ2U2bEpPMUF0UmpGZTdYeDExaEQwblRPb0swbDJpRlgxczJzYnkrMGps?=
 =?utf-8?B?RXJkQmY3YjE4Sjg0WmE5UkFrekNvTU8wRUdZY3pieHFFTkhxcVU4M0tueS90?=
 =?utf-8?B?RHcybXkvRCt2SEpLUGVjNVBsd2ttUHdaMWw1MjQwdktWN0QxaHZ6Z2hYSktW?=
 =?utf-8?B?emhneHBscEhBY1Bjb2RnMlhHTGZEUmN4eFkycGxsYmlBZ01kcks5ZnpsdVZP?=
 =?utf-8?B?L0tSL1NLVjFOaStGVTg4SCtjQVZlRjh3UFAzNGlDcWdKMzJUNjVYSHMxam5L?=
 =?utf-8?B?YkdhWjB6V0NjS2NIRzdYQksxeWFiWGlYWENEV1ByUTZsUEozSnBrekNCWTU4?=
 =?utf-8?B?eXJnZ1RzNENwRnZmdEFIeCtmU3IzdDZYTEpLeUlxM290NzJWNHBkUTNpNjUv?=
 =?utf-8?B?T0lPbXBQWkViRFRJbzFqV3hBQmdTSElwb1dmL3MzUW1RcjB2MHdLMzIySUpU?=
 =?utf-8?B?M1RUNlpvNTBSVnkveHRJTWR0STVjbC9DenhWdDBFb3ZHMzVnT0NPOXpzYWdD?=
 =?utf-8?B?aXJHdzB1UlplVU10SkQySEFXSFBpRnlEYlZERkVudVlRdm1DK3psbS9tTzJD?=
 =?utf-8?B?dWkzc1pFL2ZvZGJLZ2hoVVF3Y0JZVm5sMW1RY1JyZnoyc2tmSFlqLy9pejJz?=
 =?utf-8?B?bFRLU3UwOVJCbGVDUUxHWkdrblpqcnJ4L2JlckFLMDZSRW9SelQ5VysxUWR4?=
 =?utf-8?B?UnZhQUM1VUVSUnBaUjNrdkh4STEyeU1kTWs1TmlqR2VMVmh6NWcrUTYrcG90?=
 =?utf-8?B?ZXBMRkRiRWFwYzMwUlFPTEV6L3lhSlR5QzhMNTlXaFpoeVpXaVpxaUVQZll5?=
 =?utf-8?B?aUMrZEhxclpGdXkrWG9zc2k0MHNmMEE2VW1BcXVRMzRGYUhBZVJiQXpudHMx?=
 =?utf-8?B?TXR3VTkyWDYxampwQ2M1blhlcVZHRmlFQmJQaTY0NFRDcm5GbjNqUldVZ0dv?=
 =?utf-8?B?K0RkbU05bU1NMEl0bzR4SlZLeE5POUVoZUpCT3lZRDJMbDdyTldKQStUSVc4?=
 =?utf-8?B?Wjc5cWpkeG9qWEN0UElGa1RabGRjWFByTk9NdUFmU0N6WGg2T1p1SW54Mncx?=
 =?utf-8?B?TFVlNE5WYzNzV1pDVE0yYXh4YmZyOXYzMTQvMVlIdWpzVm8wZTlicDk5ZVdn?=
 =?utf-8?B?NkZEZXM1NlpKd1Qxdm9wVXZGVmRKN0VvTFdOd0lJa3VBL0Y4TUhsN3VnVG9X?=
 =?utf-8?B?TDRWQXBqMEFtamhCdDhwbnVvelM1Ymx3T2FoVlM1ZWNiN1dXN283MDFBSnVZ?=
 =?utf-8?B?QURXdFgrc0pEU2J2VlNVWGMvdXEwZVVLTGtmN2w3U09oUVFxN0VFTkdnMExa?=
 =?utf-8?B?bGF5UHFoYkZDNjBQaVJic2Y4Q1c5QlkraERPbUc3RnF3MEJPZHpBV3Y3RC9I?=
 =?utf-8?B?cExNK0xJMVRUbnNwVytxOXJxbnd3MlVIRVJuT1l1NUJ6cDhjR0pDdXB1b3JB?=
 =?utf-8?B?MHNXRmdkWlFhTVZVZTJUSVhuQ1VISTY5NzAxNUVyYW1XcnF3WDhlOS9QL240?=
 =?utf-8?B?K2VVQjBYcVlQN3hNL2xGOG1IWjNnRW5MWlF5RExEREtNL1FtWkRmdWEyR09u?=
 =?utf-8?Q?+itJt9fLQn3Hb3LbcoDTYE2Ma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0924d9-d1b7-4597-0877-08dd817ff864
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:27:58.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhsC/vQp3AIVPkJExxkZbzn7i2wAve9qi8wV6FwpRDtPJtzhIUQcl45OWn1jnVHX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

Am 22.04.25 um 11:14 schrieb Liang, Prike:
> [Public]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Thursday, April 17, 2025 3:40 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
>>
>> Am 16.04.25 um 16:47 schrieb Liang, Prike:
>>> [Public]
>>>
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, April 16, 2025 7:07 PM
>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached
>>>> bo release
>>>>
>>>> Am 16.04.25 um 10:50 schrieb Prike Liang:
>>>>> Free the evf when the attached bo released. The evf still be
>>>>> dependent on and referred to by the attached bo that is scheduled by
>>>>> the kernel queue SDMA or gfx after the evf signalled.
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 31 ++++++++++++++++--
>> -
>>>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  1 +
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
>>>>>  3 files changed, 28 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> index b34225bbd85d..60be1ac5047d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> @@ -27,6 +27,7 @@
>>>>>
>>>>>  #define work_to_evf_mgr(w, name) container_of(w, struct
>>>>> amdgpu_eviction_fence_mgr, name)  #define evf_mgr_to_fpriv(e)
>>>>> container_of(e, struct amdgpu_fpriv, evf_mgr)
>>>>> +#define fence_to_evf(f)  container_of(f, struct
>>>>> +amdgpu_eviction_fence, base)
>>>>>
>>>>>  static const char *
>>>>>  amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence) @@
>>>>> -47,7 +48,7 @@ int  amdgpu_eviction_fence_replace_fence(struct
>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>                                 struct drm_exec *exec)  {
>>>>> -   struct amdgpu_eviction_fence *old_ef, *new_ef;
>>>>> +   struct amdgpu_eviction_fence *new_ef;
>>>>>     struct drm_gem_object *obj;
>>>>>     unsigned long index;
>>>>>     int ret;
>>>>> @@ -72,7 +73,6 @@ amdgpu_eviction_fence_replace_fence(struct
>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>
>>>>>     /* Update the eviction fence now */
>>>>>     spin_lock(&evf_mgr->ev_fence_lock);
>>>>> -   old_ef = evf_mgr->ev_fence;
>>>>>     evf_mgr->ev_fence = new_ef;
>>>>>     spin_unlock(&evf_mgr->ev_fence_lock);
>>>>>
>>>>> @@ -102,9 +102,6 @@ amdgpu_eviction_fence_replace_fence(struct
>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>             }
>>>>>     }
>>>>>
>>>>> -   /* Free old fence */
>>>>> -   if (old_ef)
>>>>> -           dma_fence_put(&old_ef->base);
>>>> That change looks completely incorrect to me, you will now leak the old fence.
>>> The eviction fence is attached and shared by all the restored validated VM BOs
>> during UQ restore, and at this placement the eviction fence is only detached from
>> one of the BOs. Using amdgpu_userq_remove_all_eviction_fences() will walk over
>> the resv objects and detach the fence from the resv objs when freeing the BO.
>>
>> Yeah, but that doesn't justify this change here. See you're completely messing up
>> the fence reference count with that.
>>
>>> But there's a problem: even though dropping all the evf attached to VM BOs with
>> this patch, the evf still referred to by the SDMA and GFX kernel queue jobs at the
>> case when enabling the kq and uq at the same time. Thoughts?
>>
>> Mhm, the eviction fence is always added as bookmark isn't it? As long as the GFX
>> and SDMA jobs are not for evicting something then they should only depend on
>> fences with usage < bookmark.
>>
>> Can you dig up when they are added to the dependencies of the job?
> When the eviction fence was added to the user queue VM BOs reservation and then updated the BO page table, which will add the eviction fence to the VM sync at amdgpu_sync_resv()

Stop, wait a second. That shouldn't happen at the first place. Why is the eviction fence considered a dependency for page table updates?

When it is added only as bookkeep then we should never consider that here. Looks like something in the sync obj is messed up.

Regards,
Christian.

> , and then the eviction fence will be added as a dependent fence by propagating with amdgpu_sync_push_to_job(). With removing the eviction fence from the VM sync at amdgpu_sync_resv(), then the eviction fence can be released properly.
>
> Thanks,
> Prike
>> Thanks,
>> Christian.
>>
>> PS: Please stop calling the eviction fence evf.
>>
>>>>>     return 0;
>>>>>
>>>>>  free_err:
>>>>> @@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct
>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>     dma_fence_put(stub);
>>>>>  }
>>>>>
>>>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo)
>>>> Please name that amdgpu_eviction_fence_remove_all().
>>> Noted.
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +{
>>>>> +   struct dma_resv *resv = &bo->tbo.base._resv;
>>>>> +   struct dma_fence *fence, *stub;
>>>>> +   struct dma_resv_iter cursor;
>>>>> +
>>>>> +   dma_resv_assert_held(resv);
>>>>> +
>>>>> +   stub = dma_fence_get_stub();
>>>>> +   dma_resv_for_each_fence(&cursor, resv,
>>>> DMA_RESV_USAGE_BOOKKEEP, fence) {
>>>>> +           struct amdgpu_eviction_fence *ev_fence;
>>>>> +
>>>>> +           ev_fence = fence_to_evf(fence);
>>>>> +           if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
>>>>> +                   continue;
>>>>> +
>>>>> +           dma_resv_replace_fences(resv, fence->context, stub,
>>>>> +                           DMA_RESV_USAGE_BOOKKEEP);
>>>>> +
>>>>> +   }
>>>>> +
>>>>> +   dma_fence_put(stub);
>>>>> +}
>>>>> +
>>>>>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
>>>>> *evf_mgr)  {
>>>>>     /* This needs to be done one time per open */ diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>> index fcd867b7147d..da99ac322a2e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>> @@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct
>>>>> amdgpu_eviction_fence_mgr *evf_mgr,  int
>>>>> amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
>>>> *evf_mgr,
>>>>>                                 struct drm_exec *exec);
>>>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo);
>>>>>  #endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 1e73ce30d4d7..f001018a01eb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct
>>>> ttm_buffer_object *bo)
>>>>>     amdgpu_vram_mgr_set_cleared(bo->resource);
>>>>>     dma_resv_add_fence(&bo->base._resv, fence,
>>>> DMA_RESV_USAGE_KERNEL);
>>>>>     dma_fence_put(fence);
>>>>> +   amdgpu_userq_remove_all_eviction_fences(abo);
>>>>>
>>>>>  out:
>>>>>     dma_resv_unlock(&bo->base._resv);

