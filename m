Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB05ECA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 11:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC5710E877;
	Thu, 14 Aug 2025 11:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0XIvAHGC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62DB10E876
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 11:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agcNvGpxJ+RODaljCscE6IygehwJRn84LNUOlDKyWveXlV7i0DutRyOeYKzlpa8MFyEFzarNM9xp7TOPA1L/hZDBBAgWcBU2uzWRyDpbW4v9gc1m9Omkh2YJgMiDZpAA7esmevCQR8nu8iT/uSstEscDxlQqkM2PsAOn89dCJ4w+M6NNcjdPYqu11Mn0rRhL8Mu76VT97XNEGbT02ovtKUXQ6mcMUeuJ6wv2EScA8pFmGaVydKVurlD+QKHuQmOfzPvyfOeX0uHei0YnMSTSAkXxTkl7jUWYu6jKp6Lan4uGg3PjZ/GJFzI6DDrZdVoRqeAqLnnUCUQCfTFAYHyH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDmIrwLiA9epcti0clarY8M6SL5lAJxab9CxJAFe0sQ=;
 b=dDqwJfu4wzZ1mXxGeY+RQqUDMXJmSsopHWC7vFRyiCNsmJjcKgv8jDpBhIou1+XARZJ64hcyTfbrbcwVME5IGt9vn2/nM5cELQYFeOZADFWnr3GjAkzzgPAWWI4wiYj/r2TeZEk1P6MhAbKVIv6cIcjMlBIiJmU6UEItYnNcZpwzVMNqLF5yFfK1+Ujkx9fAVEDlyUfbtPfgfPKH7/7hV5wH6pXgydu2InRwRlkny6Q3nx/8bDTAxH/0HZnOWyC6vDQAWhkUIFt1v7N9u5zKGTr9Jw57MdkLoUvMrmhVGTcDalCbXaRnqa4Mpzi+LXL4tg78DiIOwwk2AQL1pR9FzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDmIrwLiA9epcti0clarY8M6SL5lAJxab9CxJAFe0sQ=;
 b=0XIvAHGClLqTl4moP470XqiciRTSNPVxR3dOZ1H+mrmKSF3TNHzZnbjC90Ql/EsBnTwzXk1Wr0CTeXPnbe//9H4ARzX9t5DOqf4BhC/XXduLJLce2Tx+ip1s/GUcOkCxl0OMagGrY4mPJln88DpR+8oCtlaoAX+ZVcyJU/Rn3CU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 11:52:48 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 11:52:48 +0000
Message-ID: <6ecd4ff4-d427-6c62-0c9f-21b7c601de79@amd.com>
Date: Thu, 14 Aug 2025 17:22:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <David.Wu3@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
 <DS0PR12MB780432BEB1D74FE5685273F59735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: d21c864f-6d09-4c5f-e56f-08dddb2916fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TytXbWpaSnN2ZFR0OWlVMFovN2JKNmtYRlhVdUhDZHE1cXU0UXgxdVRtV1pv?=
 =?utf-8?B?dDV2VVEweGFMS0VITXpsSmVNbisrOW9teHBsSWRoblN0UFkyeDI4TEhRZzdK?=
 =?utf-8?B?V2U4ZzlxVlZtUVU5aVVYeW85THZiYVM2NkxGTG9LR1h2NC9OY1hLR1oyWFE1?=
 =?utf-8?B?VFMyKzhwUy9obThLNzJ2aTZMVHcyUmVQblBxdTIyRmdWZ0hyWXdreFh4Q0Ez?=
 =?utf-8?B?TjRFaVJ5RmpXVkE1empMdzZkSm83UUtRalZPVGlkUW1JaHVuTVVRNXQ3b3A4?=
 =?utf-8?B?SEErRk5wZTlaQVcvK3kzZnlLWXZ1cDRzVXZDektYcGJQeWpPUXpld2tRR0tx?=
 =?utf-8?B?Y253RWVHdUF2UFRiNVhxRTNUTlUycU10N3hRb1FXQi9ER05icUpleUY0Mlpt?=
 =?utf-8?B?bS90SGpBNXlKMERldVYzdDBMM0g4dUdNendMKzk1eGxtcW9Dc21QTTUvbWhN?=
 =?utf-8?B?Y3BRNGdvTHI0Vlc3RHVueHN4MjBsMmRiWk1GM3VYcTdENGdUbXNyTE5Xb1h0?=
 =?utf-8?B?YTVlV2Eyc05WQ3R5T3gvdzU2ZWRuU2V1TDJsOWhoQXIwdkNUL3BCbDBsbkJO?=
 =?utf-8?B?ajJjTFFrTnhjWjA3MEhoM1RNdFlOM1BMY2hPZElZRnlvaWJ6bFhFWjZRS3dS?=
 =?utf-8?B?SFNvS3hpTGFRZHMyRXpMSjZFMkNoWDZVWTB5UXFITllJa3BHM1BMbEFibGdw?=
 =?utf-8?B?cVVyVjFOc2NUOVBST3FDK3l3V0g2cWxUdUpMSTdYdUl4ckxabzFHVEhtZXhm?=
 =?utf-8?B?S0pLOXFqY00zT0V2R1F5cm10OVIyMTFCRzVSL21mR2ppVXBqWVcwTk9YcVZC?=
 =?utf-8?B?YUFPZXFIUUxLT005Z0FBRzNhRHZET2RXL1Vscys5WVhacG82a0wzSm9kamtE?=
 =?utf-8?B?cnk0M0lQZ1NYNFZSRXlmWE9YUlF2M0ttVGQzQnNUS1gwbjQxcUJHZjdBcC9t?=
 =?utf-8?B?ZnVEVlhJZXFYcW5DMFVsZXpFR2hQSzZHTWZraVdKSGFzZDh0VW1qSS9PRTB6?=
 =?utf-8?B?R0FzZ3RWcXpzRkpreXptNllvV3RBY1RKZXJRMURoL3drNzZqM1d3MDFKK0o1?=
 =?utf-8?B?NFNVK3RCd1VpQkpXRUNCcnQrVWRPVEFqdXZFbktvc0hwQXRCVXg3dUM5amFw?=
 =?utf-8?B?MDVwbVF5dm1WMk85eFhXNUNYMzNjTmVWcys0aGd0YS8wcm1mekJhYkpGK29w?=
 =?utf-8?B?d1E2ZHFDTXhoQXBOOXJLWVFTaENwdUZCbkVZbnJMQWladW5hbHYyUmpVTEFW?=
 =?utf-8?B?TzQxM1V5cG40akRXOGhVOHgwK3BTdjFONm85K3kvTFlNU0hxSHdVUlBBL1Ft?=
 =?utf-8?B?N202dlYzeE1GN2lCWFlsUTYyM1JkSVA5dUhackgxeWNjanFpQWU0WVU4a0lO?=
 =?utf-8?B?TE1NdEVkUjZ6QlgwNjl6TDJ1TU1OdzNESnRZamc4NmJDSEg2K2ZOSUVxcFBU?=
 =?utf-8?B?MFJnS2xBTTBJazZuMEEvZHJoUHJ1Nmc5TEhsdDdhek1JYjdLOVUrSURKRXJG?=
 =?utf-8?B?WXlYVlA4MEdPR1dBM3ZXeHZzb3VqS202VDdOZ2tMdW16R3lkOHhxVDR6LzJE?=
 =?utf-8?B?L0J0V1RMQWpzcWRZNzF5eUl2NDJRdFFWa3czcXFxMWc2bWNiaGdad3FDWjBt?=
 =?utf-8?B?aEQwR3dzVnpoSTBPUmNqbFpsM1p2ZWRoVHNDY3U2ckh0WDI0MUxHTGtnV1JJ?=
 =?utf-8?B?SmN6L0VZSnFuUnptekQybEJEaEVpTjQvZmZuQzJwbVNOOW04M09yMExDSFc2?=
 =?utf-8?B?REo3QXBMS3hkTTFQMmpDbTJhZFpSYXFNOGpQK3pONkpEV1lDZ3pPMmpuS1BR?=
 =?utf-8?B?Y1R6Q3dDL2pLT3hqbisxdjg0QkZMcEhjeU5oOThyeUZ2a2dhRlFpMGxUR2RF?=
 =?utf-8?B?Sm5DdlJtaW16cDBnTWYwem01cEFwcXR1Q3RyTFFBUlhjOGNoYjRUaFpPdFAy?=
 =?utf-8?Q?4JmAnSWssRU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NzQ244SEw2U2thS0pJSTBhSitDVFFhZlNaYnE3QmFxN3BzTGx2R1BYTnZG?=
 =?utf-8?B?UUpDUExWdWVaU3dhM3RqaDVYbGhmSlR6TlhnZmdzSko5d0xHc2FhZEV0OE1R?=
 =?utf-8?B?ZFpydmtPcFRCZVd6Y0FSL3Y1Z1ZoVFJXSXpEeGU0Tm9RUlJFYkZPVnZzcTR5?=
 =?utf-8?B?MFVPTGdSdU02aU1mTmhFUGgzWDBSQ0VLV1FoQ1JUSWx1QnF0S3Y2VDdBenRO?=
 =?utf-8?B?bldrOWRWdXVya1NOQlpwdFV1QlVTMjF0OVgxSXpZL2RSWkZrTG1nTXdmTndj?=
 =?utf-8?B?OHhtcUxRVW02bTFvS1RBdXlkOVNZY2IrY0xwT3FnVXo5UStMQnhnZmNyaGJC?=
 =?utf-8?B?RjB0Z3dtaENxQVZvVnlweFFwNkNEcCtRSStrUTZ4N0MrejlRVHZxV3JZNGVl?=
 =?utf-8?B?Nms0Ynd3M0xDWGM3VnBkVGZYb01PSTdOZlVuKzF6cjJwYU1Sdi9BZCsrQ21w?=
 =?utf-8?B?VnhnbHpHOEpBWVYzem91L1hKTnArTkRyOXVYR0tmNmkxb1lzYUl1OVRVemp1?=
 =?utf-8?B?aVNCY1BJNnpCSEl1V28wa2lheVdBTGRzcWovdGYveGZ0T2xZQVBSMHQzYmhC?=
 =?utf-8?B?ZnlJRmxJZ2lqNnRodVNzTGVJcjVnUmdJV3FPdWFHOHQ2MHE1S0xVSFF2OEZL?=
 =?utf-8?B?MEg4ZU85dWhWcU5FaWlIMHFYNHRqTnN1K1ZZanh6RHE4NnJoSTNWalJQVE1F?=
 =?utf-8?B?SFpsOXlSWU9NY1krWlNKejFuUjVDS1c1OWtKOGthb1pIeXc2RVBpbHFBRDdq?=
 =?utf-8?B?ZUtqWVlLbkpYVkIxMVJFclVFZSs2dVA2cFQxUnNBMnlsOFJXYzdSdUdyUC9O?=
 =?utf-8?B?Wk8rZXNuc3FaUHdZb2I0YjlTT3FJb1JRYXNXK1dEMHdSbUhqU3NiTHZFMVFi?=
 =?utf-8?B?QTVRQXA5aXVUcTBxU2lZVWJESDRteEhoOVpIUzNOY1kxMXNpazdveTlkVGZV?=
 =?utf-8?B?WDM3Mkd3Lzk5aWFMd05jYkN3RXZmZDRFemg0WFRCU24yRHkrSnV1SGY5dHZN?=
 =?utf-8?B?RE5SazZvMktYS0QzNGpQS3VIZWxOU0w0YUN4Q1FYemc0UWVRNlRQU1NLQVY2?=
 =?utf-8?B?NTNBY1ArQml3cXlnakJQOVlRNDhQb1B0VWJ5ZEJDZ2d3bW82Y2d1bWE2Zzlu?=
 =?utf-8?B?cHdBWEUwRjYyQitSNFlCa0NtV1VSVDJ5dDlYUDZ6OXVBc25IejFlSlQxSVhV?=
 =?utf-8?B?cXd4MHBENVZYeEI1SjFaNlA1aWhKN0RHZWdUUm1lc0tkWmRQM0RJZ1lQb1Nk?=
 =?utf-8?B?MlQ2c1hiM2xXcHAyQko0OEJXRlhOQTQ1S1kybDVWZWlpckhUWUx2VXNWb3Zy?=
 =?utf-8?B?VXRnSHlpT0VwK0o4T21OMmh5MEJoMEg4SFgrNUtzdHdyQTB2aVJKdzllcy95?=
 =?utf-8?B?NUphV3Bzd1dodnp3Nml2VGxvU2M1amRab253dkwxVThOcklLdkJZd21GWEgv?=
 =?utf-8?B?RjBGckNBbzR5cXE5RUZ0bFRER01xV1lDMG03eDNxQXBua0VhczBpOW9reXpr?=
 =?utf-8?B?dGJKbGt6THlDMGk0NWpTS0ovM1lBTmo0OGVDNC84eGNXRzUxMCtQSmp2YTZm?=
 =?utf-8?B?SVJHSVdFd05DcWRQNng3Z2MzZWJkbWZrL3R0K0xHTTdNdEtVcFdLck5CaEZE?=
 =?utf-8?B?Q3I5bmFKRXhTQ0JUaExtQmNrVlRtN1NranhQcXdIVjJCWGlVdVNVRzRidHJS?=
 =?utf-8?B?VWNZOXFId1p0QkhKc0lJc0FwLy8zNVk5OTErcFprZTRLS09ZYkhrTVgxaWdq?=
 =?utf-8?B?U1hpVDBpNTlxVkRZRm05YzRpQ0RlLzdZWFBvZXRwWHJyekRqM05ybjFrTSt0?=
 =?utf-8?B?L3hScERsbkMzVTlCZTh3b3lwSmpGaE5rYjhwN2NWQTFCcnNiRkdLaDM2cUM1?=
 =?utf-8?B?cHV6dkhmVFdpZU1zWlljNGtnNlZrTFJKQnZKSVlUR21peWZtTXFybzJFQUlZ?=
 =?utf-8?B?MHNvNGlwZDVvRGJvcTJBbEd1L3YvQTVyOXV0VVd4Q24zdlNKdHhLTmVMQlo0?=
 =?utf-8?B?K2VWTzExYVM4dllVc2tvdXNSbFdsYXM4Z3NrK3drWjB4RDVNL0UrNjZTVGVl?=
 =?utf-8?B?L0VrdFFpTHlrZGFoWXk0SmdIWXFTOWZDZlBrK01ScU0yTC9WOEpzRlFuZjZJ?=
 =?utf-8?Q?BnciwLAg4qhPYVEbgSZZ0QMpR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21c864f-6d09-4c5f-e56f-08dddb2916fb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:52:48.4516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGv1IN4vzKFq7PylaaX43hpbH7UZC3gr+IIl3AGOEeGT0i0A5LXmhKewO7kADJb044Z8YAcNnta4IcZSG1tBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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


On 8/14/2025 3:16 PM, Lazar, Lijo wrote:
> [Public]
>
> I see your point now. Attached should work, I guess. Is the concern more about having to take the lock for every begin?

This is closer,  but the thing is, IMO we shouldn't have to use 2 locks 
and go into nested locking, we can do with just one global lock.

Power_state of each instance, and global workload_profile_active are 
inter-related, they need to be guarded together,

nested could work , but why nested if single lock is enough ? nested 
complicates it.

Regards,

Sathish

>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
> Sent: Thursday, August 14, 2025 2:55 PM
> To: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
>
> [Public]
>
> That is not required I think. The power profile is set by an instance *after* setting itself to power on. Also, it's switched back after changing its power state to off.  If idle worker is run by another instance, it won't be seeing the inst0 as power gated and won't change power profile.
>
> Thanks,
> Lijo
> -----Original Message-----
> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Sent: Thursday, August 14, 2025 2:41 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
>
> Hi Lijo,
>
> On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
>> [Public]
>>
>> We already have a per instance power state that can be tracked. What about something like attached?
> This also has concurrent access of the power state , vcn.inst[i].cur_state is not protected by workload_profile_mutex
>
> every where, it can still change while you are holding workload_profile_mutex and checking it.
>
> Regards,
>
> Sathish
>
>> Thanks,
>> Lijo
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Sundararaju, Sathishkumar
>> Sent: Thursday, August 14, 2025 4:43 AM
>> To: Alex Deucher <alexdeucher@gmail.com>
>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> (v3)
>>
>>
>> On 8/14/2025 3:38 AM, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 5:1 PM Sundararaju, Sathishkumar
>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>> Hi Alex, Hi David,
>>>>>>>>
>>>>>>>> I see David's concern but his suggestion yet wont solve the
>>>>>>>> problem, neither the current form , reason :-
>>>>>>>>
>>>>>>>> The emitted fence count and total submission count are fast
>>>>>>>> transients which frequently become 0 in between video decodes
>>>>>>>> (between jobs) even with the atomics and locks there can be a
>>>>>>>> switch of video power profile, in the current form of patch that
>>>>>>>> window is minimized, but still can happen if stress tested. But
>>>>>>>> power state of any instance becoming zero
>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0
>>>>>> decode completes, delayed idle work starts.
>>>>>> inst0 idle handler can read 0 total fences and 0 total submission
>>>>>> count, even if inst1 is actively decoding, that's between the jobs,
>>>>>>       - as begin_use increaments vcn.total_submission_cnt and
>>>>>> end_use decreaments vcn.total_submission_cnt that can be 0.
>>>>>>       - if outstanding fences are cleared and no new emitted fence,
>>>>>> between jobs , can be 0.
>>>>>>       - both of the above conditions do not mean video decode is
>>>>>> complete on inst1, it is actively decoding.
>>>>> How can there be active decoding without an outstanding fence?  In
>>>>> that case, total_fences (fences from both instances) would be non-0.
>>>> I mean on inst1 the job scheduled is already complete, so 0
>>>> outstanding fences, newer job is yet to be scheduled
>>>>
>>>> and commited to ring (inst1) , this doesn't mean decode has stopped
>>>> on
>>>> inst1 right (I am saying if timing of inst0 idle work coincides with
>>>> this),
>>>>
>>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
>>>> correct my understanding here.
>>> The flow looks like:
>>>
>>> begin_use(inst)
>>> emit_fence(inst)
>>> end_use(inst)
>>>
>>> ...later
>>> fence signals
>>> ...later
>>> work handler
>>>
>>> In begin_use we increment the global and per instance submission.
>>> This protects the power gating and profile until end_use.  In end use
>>> we decrement the submissions because we don't need to protect
>>> anything any more as we have the fence that was submitted via the
>>> ring.  That fence won't signal until the job is complete.
>> Is a next begin_use always guaranteed to be run before current job fence signals ?
>>
>> if not then both total submission and total fence are zero , example
>> delayed job/packet submissions
>>
>> from user space, or next job schedule happens after current job fence signals.
>>
>> if this is never possible then (v3) is perfect.
>>
>> Regards,
>>
>> Sathish
>>
>>> For power gating, we
>>> only care about the submission count and fences for that instance,
>>> for the profile, we care about submission count and fences all instances.
>>> Once the fences have signalled, the outstanding fences will be 0 and
>>> there won't be any active work.
>>>
>>> Alex
>>>
>>>> Regards,
>>>>
>>>> Sathish
>>>>
>>>>> Alex
>>>>>
>>>>>> Whereas if instances are powered off we are sure idle time is past
>>>>>> and it is powered off, no possible way of active video decode,
>>>>>> when all instances are off we can safely assume no active decode
>>>>>> and global lock protects it against new begin_use on any instance.
>>>>>> But the only distant concern is global common locks w.r.t perf,
>>>>>> but we are already having a global workprofile mutex , so there
>>>>>> shouldn't be any drop in perf, with just one single global lock
>>>>>> for all instances.
>>>>>>
>>>>>> Just sending out a patch with this fix, will leave it to you to
>>>>>> decide the right method. If you think outstanding total fences can
>>>>>> never be 0 during decode, then your previous version (v3) itself
>>>>>> is good, there is no real benefit of splitting the handlers as such.
>>>>>>
>>>>>> Regards,
>>>>>> Sathish
>>>>>>> If it is possible, maybe it would be easier to just split the
>>>>>>> profile and powergating into separate handlers.  The profile one
>>>>>>> would be global and the powergating one would be per instance.
>>>>>>> See the attached patches.
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> can be a sure shot indication of break in a video decode, the
>>>>>>>> mistake in my patch was using per instance mutex, I should have
>>>>>>>> used a common global mutex, then that covers the situation David is trying to bring out.
>>>>>>>>
>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
>>>>>>>> flags to track power state could help us totally avoid this situation.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>
>>>>>>>> Sathish
>>>>>>>>
>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>
>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer
>>>>>>>>>>> in case someone adds more before the lock and not reviewed
>>>>>>>>>>> thoroughly)
>>>>>>>>>>>         - up to you to decide.
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> David
>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>>> If there are multiple instances of the VCN running, we may
>>>>>>>>>>>> end up switching the video profile while another instance is
>>>>>>>>>>>> active because we only take into account the current
>>>>>>>>>>>> instance's submissions.  Look at all outstanding fences for
>>>>>>>>>>>> the video profile.
>>>>>>>>>>>>
>>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>>
>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload
>>>>>>>>>>>> profile
>>>>>>>>>>>> handling")
>>>>>>>>>>>> Reviewed-by: Sathishkumar S
>>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>>         2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>             struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>>                     container_of(work, struct
>>>>>>>>>>>> amdgpu_vcn_inst, idle_work.work);
>>>>>>>>>>>>             struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>>             int r = 0;
>>>>>>>>>>>>
>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>>>                     return;
>>>>>>>>>>>>
>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =
>>>>>>>>>>>> + &adev->vcn.inst[i];
>>>>>>>>>>>> +
>>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>>> +     }
>>>>>>>>>>>>
>>>>>>>>>>>>             /* Only set DPG pause for VCN3 or below, VCN4 and
>>>>>>>>>>>> above will be handled by FW */
>>>>>>>>>>>>             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>>>                     struct dpg_pause_state new_state;
>>>>>>>>>>>>
>>>>>>>>>>>>                     if (fence[i] || @@ -436,18 +442,18 @@
>>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct work_struct
>>>>>>>>>>>> *work)
>>>>>>>>>>>>                     else
>>>>>>>>>>>>                             new_state.fw_based =
>>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>>
>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst,
>>>>>>>>>>>> + &new_state);
>>>>>>>>>>>>             }
>>>>>>>>>>>>
>>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>>> -
>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>>                     mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>                     vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>>                     mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>>> !total_fences &&
>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>>                             r =
>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>>> false);
>>>>>>>>>>>>                             if (r) @@ -467,16 +473,10 @@ void
>>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>             int r = 0;
>>>>>>>>>>>>
>>>>>>>>>>>>             atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>>
>>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>>> -      */
>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>>> -
>>>>>>>>>>>>             mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>> move to here:
>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>>> David
>>>>>>>>>> Alex
>>>>>>>>>>
>>>>>>>>>>> David
>>>>>>>>>>>>             if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>>                     r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>>>             }
>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>
>>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>>             mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>             vcn_inst->set_pg_state(vcn_inst,
>>>>>>>>>>>> AMD_PG_STATE_UNGATE);
>>>>>>>>>>>>
>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
>>>>>>>>>>>> amdgpu_ring
>>>>>>>>>>>> *ring)
>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submissio
>>>>>>>>>>>> n
>>>>>>>>>>>> _cnt);
>>>>>>>>>>>>
>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_
>>>>>>>>>>>> c
>>>>>>>>>>>> nt);
>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>>
>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>>>                                   VCN_IDLE_TIMEOUT); diff
>>>>>>>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>>
>>>>>>>>>>>>             uint16_t inst_mask;
>>>>>>>>>>>>             uint8_t num_inst_per_aid;
>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>>>
>>>>>>>>>>>>             /* IP reg dump */
>>>>>>>>>>>>             uint32_t                *ip_dump;
