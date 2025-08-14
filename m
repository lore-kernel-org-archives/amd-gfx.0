Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21EDCA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 16:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B17910E0D3;
	Thu, 14 Aug 2025 16:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiEGI6gZ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C058610E0D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 16:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6ZrjC37AvChTxgRAv2Mp1KuK/HcCB6ec+zK5LrdUB6QXXVK0qwT9+R08c31FyWyCf4VEMHY+ZE1zc1Ci2twgCOa6qkpjSouV2sYB+GH9SZugBxg/ui1xyU3PUwYTg1ZVZYUyyq5RAU/cxwc1VNq/+l1uS5j33RAGbtTqdHSyidb+1FYvQNczGEQx/9bM69/dtg6FZfiX/LNmIhOA9jBSzlMgROLXYbOmpUhyfSiEINtoh03BYNfQq/Zr5ga2P7dkuI95LhHbkIv410Dew79Fir2SSiMaVWZOSBPHN767RNzH2xZTAyX2Ijvjnk0Ybe5IcUTTfCzs/fn8MCZkiqoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHHfWnriPpJ+Yc6QzoB48Y18lmG80k3ZmfqMP0XVL2A=;
 b=IlxuQt1K4rUyaso+s5ZXnzCYCRVObP+0EP4IldotRnG8KWLVT/65G2knRm6lVcrAZw0iCb40Jr4xpTBfDvRred9NomcCEuRX7fVYXEG/eROwCS7FvYXE8WlCSv9Z+jVbjPwtAIlJ3xZh0NTDrJceKP4iJ/B9wx+BlLM9ydiGyNrKTaLYkNWgvU/nzdBNefs9dlLRRqAn3WMVIDcMxKXVIgnPEO7X22NcnfUzRvooLSHvm6dRINBZIvwIAlhJT9LWVlDiPPv957teVsnhu/HKbBoKCjf7kRsYw3dQbmMCpmvjV3DM9LUHdKVv6cN9I9HcpUl8Acopw8BnbMHDUfVjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHHfWnriPpJ+Yc6QzoB48Y18lmG80k3ZmfqMP0XVL2A=;
 b=GiEGI6gZFBSRv3pAaJ0zt2ETs7GAoKxK0VFpGo/h+oTEyH7pf6kuU1p5UjsswbbXNZfcEdi6nTE7z+KMnt6lsrLIgBI7wajE9pI9T5xEVK418urgbf20SfJ4hpnMCjMXp4hVw/W2XpJtHq+kwXeB7DCXlCdqq21nEjeQ1uWjgSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 16:44:19 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:44:18 +0000
Message-ID: <04e0a9f2-d8ea-4383-8fb6-b7422d6f9ff6@amd.com>
Date: Thu, 14 Aug 2025 12:44:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
 <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
 <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
 <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
 <7a8991f7-1eb7-4307-ac72-1281a50bf4d5@amd.com>
 <CADnq5_NutFtDzq3xwcfLr6dHtWaEKDwV5-kXrDpNBCM2DjWb-Q@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_NutFtDzq3xwcfLr6dHtWaEKDwV5-kXrDpNBCM2DjWb-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0020.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b13a56e-bf92-4ab5-c209-08dddb51d00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU5KeEJMQjZYMCs5Z1RSL0x0UlFGdGY4K2NiYktTTTlYNnAvY2NQTzJnbG56?=
 =?utf-8?B?VngzSDRsbVZKS0FUMXdWb0xJQlZFTFNYMnVoNEhIWjIxSXQzVFlsNXJNdEM0?=
 =?utf-8?B?VGZGbGFYZm9lWjJtSlBST3hxNGpUS3VOL0djUnpRT29wYmIwWjE5L2JDWjNq?=
 =?utf-8?B?STZrYmJuR29NWEY0N3o3aGdqaGNjVngyak9PdG9mQnN5cVdkWm9BT1RZclEy?=
 =?utf-8?B?eVNRWHVBMXNUSDNuRnFHbkkzWFAvQXp6cVZiU2xHYldQZ1FXMlpJV21nUEJR?=
 =?utf-8?B?VmxhUkVyTDRGdHJoaFRsVG9YeEZTNkNBNjJZbHZXR0Z4YURmbnIrMXpYQU9K?=
 =?utf-8?B?Z2lEc3ZSdlBkcmx0eWpoZ3gxT2c4VnBBb2xjUzFnR1IzWkphTEJoTUhvWThF?=
 =?utf-8?B?ZGdyY2NTSEdCYWdVVWc5L21iZHNoR0dWOWZqSWtIaExZaXRYL0xQcGNLQ1dv?=
 =?utf-8?B?ZEIvWStCL1htbzdWVHArN1dPSkVCdHkvZ3h1S01NWlNyc1V4elBUc0JraUlR?=
 =?utf-8?B?UXZWTFJJNnR3OExGUzZBanNQLzVPL2xFdkxUUXlreWs0U09uQ3ZqN2hLdHV5?=
 =?utf-8?B?NkFXN3FEUWNaQlZiOG5aVDh6KysxaFVad1BFWkppU1dMWndjcmlab21ZWnBJ?=
 =?utf-8?B?cnpNTkVIRUxHUGx2ODVIQk0xa0RpUTdoRTdCL0lwUm10N0NFN1VnVjVreDJV?=
 =?utf-8?B?YTVIOWJPYXBsRWtUS01mc3NmbUs1R0cxMXFaU212Tlc3Tk1YNXBKUE92UDUw?=
 =?utf-8?B?c3ZHRGFxV3djYXlUcVVIMVdpVGFOMU9TQmlreFJzbk5aMDlyU1FLbmZuVW9V?=
 =?utf-8?B?QXY3Mkp2a1phaG53bCtvYzZCOW9jWlcyRmFKdFNrZ2hVT3lKQlorZkpsbU5B?=
 =?utf-8?B?SFdoNjhSOEZ6alI5S2lvUERKaFZWanVZLzMvNmsvTnBoZEN4Wk1GUWdEL2Nh?=
 =?utf-8?B?empxNHBlcTNxcDBZcUNjOUZrT2ZQRkFHUm9KaE1nK2Urb2ppVHRuY0dIaEdU?=
 =?utf-8?B?NEYySzVYVGh5SmtQNDFBY1JCTUVKMGxKNUdPdlBPVlZTMis4UGxsbzBpSUJI?=
 =?utf-8?B?WEk2REZBUEIyTkd1UnBhdnpkZTUyWFJuN2EwVU0zU2VtU3ByS3VWT3hnSWVM?=
 =?utf-8?B?aE00Mkl3QU5HWDhXNU5aOCtPbi9jOXV0WkxCSXZqZFQyWHVxb1hNVEZ5MElT?=
 =?utf-8?B?bjIzZ2FnVnNGbDdlYjYrK0Ixb0E2T1ZZRnZnYkMwQU5Rc1ozdndiS0grSTBu?=
 =?utf-8?B?bWRzZnVodFBsTkN2YVA2M1F6ZUd1d29VdlNLcmwxWm1EZHJEYURMUkc3MUNX?=
 =?utf-8?B?SHAxRzA3SE9sTFEyaW40UDBDNzFjRHBuQWdUd0p0b2hqNFhmT3IrTlM2SDcy?=
 =?utf-8?B?ZlpxaEExTTVCWW1UbjF1R1lURDZub1NYOU9oQXZpYXJvam9oMnlPenhqY2xH?=
 =?utf-8?B?RnRtMUV5RGZCa3BqdWNyeGF2RW9nYmxEM0pFbHNpdGthNzJuZC96ZFFqRE42?=
 =?utf-8?B?OUQvR0xCbG1lQnhhZU9Lc25OdEVjZHNHZmR6N29YNEVPcGUzU21RZytiT1B1?=
 =?utf-8?B?SUtESER2Nkw2N2JCK0ozOEpkNlBOaGtMNHB5NFkzb2U5TXZiY2lLOGdJN2Nv?=
 =?utf-8?B?dEpDT3FjeUxpR3M2UDk1VjhrOFBoQzY3YnpYUGN3MGR3eVVZMkdwMXlnSVBY?=
 =?utf-8?B?OGQrMmtaM2ZVeDZwc2RlUEY0MGRrcEl0V0JqdTRpNGphWEllRDZJcytCQmli?=
 =?utf-8?B?dVVISGllZ1VQVFhCTEhEdW9DRGhzMERCRUo5Rnh4V09nUUNWM2xFUzZGUTBp?=
 =?utf-8?B?N2RLVTdFT3BYc2ovVWxqQjBsdUtqS1luanNaRTUydko0eVB6Q2doQ25sSEVQ?=
 =?utf-8?B?cm1aQlF4eVdsb2NXZXNpVUI5azhnUUlseEdxN1hLeXZKc2lPZUQrSHBOdVl1?=
 =?utf-8?Q?Lo6tzrbPyso=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkwzU3laSjl0cUI2eEExVjFMOE15YWh1TXM0SzFBdWtySW9NbjgweFJiWGJy?=
 =?utf-8?B?MkM5ZldxekNMZWdlZWQ0NTJtaFphUWtMemUvTm50UGdjamE4YnhsTGZDSnBi?=
 =?utf-8?B?ZmZTSzJEU3Q2dlhyc3RHU0JDUnpVbVdsYW1TZjNKcVRhMmw1M2hFcE45K0lF?=
 =?utf-8?B?dkFnT1NMSWk0NmYxaW1pOWc0MUNZR1ppVXFrUldSM1JYVUVCc1ByZlZTVjc0?=
 =?utf-8?B?TkpqNXk0VGFtZDNlSTQxWFFYR1BpZE9jOEkxMVNSbld6bFhwbHlHQ1pwREt0?=
 =?utf-8?B?c1pXbmZHdFI3R2MvS1RwTW5lbVl4ZDAwejNjVG5pTlpwQ1JtbDJ1ZG1hT2c5?=
 =?utf-8?B?VkV3V0wraWNPU3hqSlBzQjF3YmVWS1JER0ZxZU4vSWNKT3NmTENFWjhCSThT?=
 =?utf-8?B?Y2hWS1ZpMDZVbWp1MVEwTkNPZ04zUS9CZWdXeHBqSnJNNkRaZ01MNDVTd3JB?=
 =?utf-8?B?YWl0NHd4dXZNWUkxdzZpWklmZnJCbmoyNnEwOEhLQ2I3QTVOQ29scUVrc2Jo?=
 =?utf-8?B?VVYxQk05M1h6VG9RUm11ck1oL1ZxMVFwZkUyVGo1SXVwa1VtcnNkOXIzTGJn?=
 =?utf-8?B?WHllMmV4Q1RDTlJNQms4Y29ZR2ltWmxzWFFtZnVUdmJENlRqY0YwYTBiL1R5?=
 =?utf-8?B?SjA0YWRKYWI1d3VHcVFWc3BCandJMzcwdTU2OWlqQWtVTkpNenR1TnFHeElI?=
 =?utf-8?B?WjNpYmluYjB2TzJMRHY4eUJDbXZGN1R4Q2RyaTRoQ2k4MlZaclpSZmRBYlBI?=
 =?utf-8?B?R0FwTTNLV2E0TUN5Q0lDMlhDL2x2ODBGVG1TYkQrNVExV0hMbjFmbkZGWE15?=
 =?utf-8?B?c3hCdjJEZlpkanF2T1AzQVYwVlM5RlBHMjhLTjRQa1pVU05mUVI5eEtXc2lP?=
 =?utf-8?B?anZBLytBL29OdW9UQnkwajVDVERpeWp4T1kweERJYld0UXZaQzlIakhiblky?=
 =?utf-8?B?ODBnN0ZEdWx1YnJzMHg4QW1IYnZFb1VBZHM0L05iUlg0ckRoUlZsL1cyT3B0?=
 =?utf-8?B?aHFZaEFpdVR2RGVjcEZ1YWFKL3JPR283c0pHWm1nOWs4ZTk3RlR6RnFDejNP?=
 =?utf-8?B?ZExmTFgzWWlWN2NXdDRYT25NRlR1dVhVN0d3T1JFeFJOeEwyYWZhc1VmMHNF?=
 =?utf-8?B?THFyNW1uckd0YzI0UzJwT3FmSW5WdjArdnFSTDlrTStGL1FYUkhLa2tOYU1i?=
 =?utf-8?B?V2VBTjNDZ3cxaHpOVDlPS1J4OW5LSVNReEorY0tsNnJsQ3VpSm9ibmRUdGJG?=
 =?utf-8?B?ZVVjVnNWSktLQm1jRWhuMU56M0xNYnFCS3NCTmRqNUswcytqYTNYbWVhNXdj?=
 =?utf-8?B?S1pwQW5NdndHNjJWL1RaU1ZNekFLVGdweWl2WVBOWEFmL1pvZ09zNW5PaFJk?=
 =?utf-8?B?b2NRVGdGd3lNS0hxWFNEWUpHUkxQaGZTT0F6c1ZVK1h3UUJFOXRBREpmUy95?=
 =?utf-8?B?RHp2N252UkQwd2Evck5DOG13Um1QRGovZXM1djNHNGNKK3JOdGEyand1Ri9n?=
 =?utf-8?B?ang5ejdzcFM0aDFzcmJMQTBsZnJYblk3ZGZoYTB4cWN1b0kyUU9pTXF0d2FR?=
 =?utf-8?B?aWZ2dUhkcnd6QW9LdnRNSC9ZUkladVIvN3lDOVFHNFp4REJ0VXJBcC84QXla?=
 =?utf-8?B?S0JldFJKUzFGSUdBazE3SkFTVFcwdm4rdEJ6TWJKSll3a0h6dnhZRk5ZT09Z?=
 =?utf-8?B?czh3VkhHRVdlcEtKcXNpcEJTZEc5YlNkMkhpbTk4ZDNQbTlTemJHeDkxZ3Rx?=
 =?utf-8?B?VGRqb1JjTXU4UC9zUm5uTS93NE9NRWhWbVRqWi85VDRHbTFSeE1TM1pMT3NZ?=
 =?utf-8?B?S1A3ZjRmTzRkM2g2eXByeFVMbFB2eE82VzBPbUFhN29kbTlmNjF6N0o5ZWdT?=
 =?utf-8?B?SCtFMFVpa1NlY283Yis3bHdhWFV3SXI0YWlOZk05ZjZvWlM5a3hHOFUydGpM?=
 =?utf-8?B?T2srbzVnWHFYV0EyS0RyeEhNMVhTS1J5cmJJcUE4V05IekZ4ckprL2MwTEdF?=
 =?utf-8?B?UGhsVWc5UlU0aHU1MDk0UkQybVg0aVUxcWVzaWQ2RitBd3ZVSnljM09vUTBU?=
 =?utf-8?B?bkNxS2FJSzF3V3dUZ2FZcU4zQnF0YUNNejZYd05TUy9lazE2UVNGR2xwQWNm?=
 =?utf-8?Q?V+rgI4ZLONptGhRZEKP7Ek8Yg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b13a56e-bf92-4ab5-c209-08dddb51d00b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:44:18.7914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ujz74MBT6ZXwVYfIzam2JiX0hf8XRaNRRKI0bmJhjCOswZbWPDYAwG300CAKBBUP2UOG7HqczK5TjL9nvnO31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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


On 2025-08-14 12:01, Alex Deucher wrote:
> On Thu, Aug 14, 2025 at 11:35 AM David Wu <davidwu2@amd.com> wrote:
>> On 2025-08-14 08:56, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 7:06 PM Wu, David <davidwu2@amd.com> wrote:
>>>> On 8/13/2025 6:11 PM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 5:47 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
>>>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>>>> Hi Alex, Hi David,
>>>>>>>>>>
>>>>>>>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>>>>>>>> neither the current form , reason :-
>>>>>>>>>>
>>>>>>>>>> The emitted fence count and total submission count are fast transients
>>>>>>>>>> which frequently become 0 in between video decodes (between jobs) even
>>>>>>>>>> with the atomics and locks there can be a switch of video power profile,
>>>>>>>>>> in the current form of patch that window is minimized, but still can
>>>>>>>>>> happen if stress tested. But power state of any instance becoming zero
>>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>>>>>>>> completes, delayed idle work starts.
>>>>>>>> inst0 idle handler can read 0 total fences and 0 total submission count,
>>>>>>>> even if inst1 is actively decoding,
>>>>>>>> that's between the jobs,
>>>>>>>>       - as begin_use increaments vcn.total_submission_cnt and end_use
>>>>>>>> decreaments vcn.total_submission_cnt that can be 0.
>>>>>>>>       - if outstanding fences are cleared and no new emitted fence, between
>>>>>>>> jobs , can be 0.
>>>>>>>>       - both of the above conditions do not mean video decode is complete on
>>>>>>>> inst1, it is actively decoding.
>>>>>>> How can there be active decoding without an outstanding fence?  In
>>>>>>> that case, total_fences (fences from both instances) would be non-0.
>>>>>> I think it should be non-0.
>>>>>> I do see a hiccup possible - i.e the power switching from ON to OFF then
>>>>>> ON in the
>>>>>> middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
>>>>>> it on.
>>>>> How would that happen? As long as there submission cnt is non-0 and
>>>>> there are outstanding fences on any instance, the video profile will
>>>>> stay active.
>>>> there could be no jobs but it doesn't timeout yet and new jobs will come in
>>>> any ms - note all fences are done at this time. The idle handler sees no
>>>> fences
>>>> and no jobs so it turns off the power - but just ms later a new job is
>>>> submitted
>>>> from the same decode session which could be mpv player as it does not
>>>> need to
>>>> submit jobs without delays. This will turn on the power.
>>> I'm not following.  Every submission will start with begin_use().
>> yes - it does - it can power on vcn but this happens in the middle of a
>> decode session which has 10s timeout to call its own idle handler - in fact
>> the other instance's idle handler will power off vcn because it does not
>> know it needs
>> to wait until the decoding session times out.
> I don't follow.  If there are no outstanding fences, there is no
> reason to not power down the VCN instance and disable the video
> profile. If there are still outstanding fences, then the VCN instance
> those fences are associated with will stay on and the video profile
> will stay enabled.  If the engine hangs and eventually gets reset, the
> fence will be signalled and then there will be no outstanding fences
> so the idle handler will eventually disable the power profile.  The
> idle handler will keep getting rescheduled as long as there is still
> oustanding work.
inst0 and inst1:
inst0 sends jobA, then ends jobA and no more job submitted in 500ms and
job queue is empty - at this point  inst1's idle handler sees no 
outstanding fences/jobs
then power off.  However inst0 starts to submit job after 500ms - inst0' 
idle handler
has not started/scheduled to run but inst1's has finished already which
does not know inst0 has not timed out or called its own idle handler. 
This violates the
logic for idle handler's timeout condition. (i.e 10s timeout designed 
but timed out in 500ms)
all this means it powered down too early for inst0.
> Alex
>
>
>>> Alex
>>>
>>>> David
>>>>> Alex
>>>>>
>>>>>> We should avoid this glitch. This requires the idle handler sets/clears
>>>>>> a flag for
>>>>>> done for this instance as Sathish's original patch. When all instances
>>>>>> set/clear the
>>>>>> flag then we can safely power off.
>>>>>> David
>>>>>>> Alex
>>>>>>>
>>>>>>>> Whereas if instances are powered off we are sure idle time is past and
>>>>>>>> it is powered off, no possible way of
>>>>>>>> active video decode, when all instances are off we can safely assume no
>>>>>>>> active decode and global lock protects
>>>>>>>> it against new begin_use on any instance. But the only distant concern
>>>>>>>> is global common locks w.r.t perf, but we
>>>>>>>> are already having a global workprofile mutex , so there shouldn't be
>>>>>>>> any drop in perf, with just one single
>>>>>>>> global lock for all instances.
>>>>>>>>
>>>>>>>> Just sending out a patch with this fix, will leave it to you to decide
>>>>>>>> the right method. If you think outstanding total fences
>>>>>>>> can never be 0 during decode, then your previous version (v3) itself is
>>>>>>>> good, there is no real benefit of splitting the handlers as such.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Sathish
>>>>>>>>> If it is possible, maybe it would be easier to just split the profile
>>>>>>>>> and powergating into separate handlers.  The profile one would be
>>>>>>>>> global and the powergating one would be per instance.  See the
>>>>>>>>> attached patches.
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>>> can be a sure shot indication of break in a video decode, the mistake in
>>>>>>>>>> my patch was using per instance mutex, I should have used a common
>>>>>>>>>> global mutex, then that covers the situation David is trying to bring out.
>>>>>>>>>>
>>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>>>>>>>>>> track power state could help us totally avoid this situation.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>>
>>>>>>>>>> Sathish
>>>>>>>>>>
>>>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>>>
>>>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>>>>>>>>>> someone
>>>>>>>>>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>>>>>>>>>         - up to you to decide.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> David
>>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>>>>> If there are multiple instances of the VCN running,
>>>>>>>>>>>>>> we may end up switching the video profile while another
>>>>>>>>>>>>>> instance is active because we only take into account
>>>>>>>>>>>>>> the current instance's submissions.  Look at all
>>>>>>>>>>>>>> outstanding fences for the video profile.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>>>>>>>> handling")
>>>>>>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>>>>         2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>>>             struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>>>>                     container_of(work, struct amdgpu_vcn_inst,
>>>>>>>>>>>>>> idle_work.work);
>>>>>>>>>>>>>>             struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>>>>             int r = 0;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>>>>>                     return;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>>>>> +     }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>             /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>>>>>>>>>> be handled by FW */
>>>>>>>>>>>>>>             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>>>>>                     struct dpg_pause_state new_state;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>                     if (fence[i] ||
>>>>>>>>>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>>>                     else
>>>>>>>>>>>>>>                             new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>>>>             }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>>>>                     mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>>                     vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>>>>                     mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>>>>> !total_fences &&
>>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>>>>                             r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>>>>> false);
>>>>>>>>>>>>>>                             if (r)
>>>>>>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>>>>>             int r = 0;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>             atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>>>>> -      */
>>>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>             mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>> move to here:
>>>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>>>>> David
>>>>>>>>>>>> Alex
>>>>>>>>>>>>
>>>>>>>>>>>>> David
>>>>>>>>>>>>>>             if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>>                     r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>>>>>             }
>>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>>>>             mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>>             vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>>>>>>>>>> *ring)
>>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>>>>>                                   VCN_IDLE_TIMEOUT);
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>             uint16_t inst_mask;
>>>>>>>>>>>>>>             uint8_t num_inst_per_aid;
>>>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>             /* IP reg dump */
>>>>>>>>>>>>>>             uint32_t                *ip_dump;
