Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E1EC27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 10:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E98E10E1B0;
	Wed, 12 Jun 2024 10:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnSqpkGE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D36510E1B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 10:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDsELv6YhoDINuUWmQpv3mYnMpU4ukpB9mahqbt17iJG90wjsI+fG8rLWhfKpHDSv/ZjJhuxmzZJDrwVyQlcJMjOxNCM/PYA5uq96JfR50AqOfIlRkM3n65rybbXMyT56AmT6AHaC4cReOznbIRpgC6pxfR8gmGxbICtGntIfulepVwt9Xw77XlbdmfULH5DsaVJXhSZlIGRw1xvVlCd3LKEd6/4yE7lSYt9HJAwyHRegfHie4gpEagb6pUvwj6+JmbjjqxXnDzl/bzTDZ9ngl2GRPqcNL6H/q00wVfd7YjXNwUAUZB6y4yUSZX3gYJsJwmxPPzTezXkv5W5+PwQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pptxSsdhGvlm+eIvWSrR5M+3xaRk1WM8L/HbeyXAEzM=;
 b=We/yBUB4cGqQ1JjefFfxMzcBC1uI2/c9SFK89V60Jt3GDp3SHDfAFzCwDpNcRDAbGiY3wKPJQ0AvySBDoZj56wTBwFbLbO8CuTNLfsD76yGx0xgNMhfjGY8uzw+JmD/SPO2xdHn1xp9ZbjY8bI0DCkFVIJQ6VPgwMh5+MvmKhOLrNeqmEwYb548G1YWEOolBCDhHgGB2wwy36X8b/gh1XMG8HeyGKriyux1uGxwH6RuseMW+C/8D9cDK9nwrzVc9/8QAP8zNXhrBJozAjjhBsRY3zZv+Kwz/h1aiiiBPXGY8oOUw1yLvtS+fRTKsyHCe0S4czbfNc3Wo/oiPkO2E1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pptxSsdhGvlm+eIvWSrR5M+3xaRk1WM8L/HbeyXAEzM=;
 b=wnSqpkGEx+isJJbpg/8Yti/ickDSsVkZn9N/n2ok04L2OUVCl6oN12G+eE584kDXu45dsBRyFJoNNXu6R7O+hDLBaDIQ/s7bEE6mtKdA8utYbVe/iF2lr1hg/7A/w31DisMiISTHjoe+8fV8awAW7QX45upOPSgE18mb1BcEp+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 12 Jun
 2024 10:23:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 10:23:26 +0000
Message-ID: <7d408b4d-0a5a-49c3-98c7-27658de1e000@amd.com>
Date: Wed, 12 Jun 2024 12:23:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use local xcc to flush tlb
To: "Ma, Qing (Mark)" <Qing.Ma@amd.com>,
 "Yao, Yiqing(James)" <YiQing.Yao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
References: <20240612093641.3682677-1-YiQing.Yao@amd.com>
 <BL1PR12MB5876C672D00C550E43E00045EEC02@BL1PR12MB5876.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB5876C672D00C550E43E00045EEC02@BL1PR12MB5876.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 056aaec3-e004-4b09-11d0-08dc8ac9b23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|376006|366008;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUhzYm9pelZDZHprOFhuR0NnYmZxb0NnWG5CQm93aGZ2Zlcyc3B1a0wrT0E5?=
 =?utf-8?B?bDdyTS9jMjdwRUxvMmkvV3R0djFDdXprZTVNWEp4SlN4Vng1NmgzaGJiOG8v?=
 =?utf-8?B?cGxlVWlybUZseGVjMDFxcnFpM1UxaEkrNlJyYjlOYVlKV3o2MVlBUnlDZDc1?=
 =?utf-8?B?bXdvNnUxS1lyQWtQY2FWeWI0bE5mRlV4TFd2MVF0WWRHYXhpRkJzbjVWZ0ZO?=
 =?utf-8?B?endBWXFGbzBtU3FaeUZsTk92dU1wV3R4eUllYTNUSzNNOHIzTmkxQmZ1dDJr?=
 =?utf-8?B?K0RFMFNQMGs0NXUzM2E1R3JSYVF3MGNGTEJKMlppc29Dc3ZYYXdqMnNBM2Ro?=
 =?utf-8?B?dDVFTzdzaEJOK3g5Q05qcmdkcXRFMlJUQVJaZWhwRldiSkxMNWlhN0VJbTZQ?=
 =?utf-8?B?YTZ2SFFFeVlWekpoT2pPblpIRC9ab096Z2NOeDFyd1dCMXJLKyswd2hRNmw5?=
 =?utf-8?B?alRHc0huM3RiYi9TQjJ6eXhlM1g1TzQwSi9RbUR5aGd3QnEyR21CaHRtRjVK?=
 =?utf-8?B?M0diVGo3RTFGYk1HajJKTDVsUHJkY1F5M0UwdUYwTnZIWVUwdWhLMGw5RVF5?=
 =?utf-8?B?cU0yc05KZFk2Qk90SzZCbTh0bnZ0MlZYaVJ6aUtYaENPRGlRemNHdW1GODBL?=
 =?utf-8?B?OFU5eGxsWnZMaTYyajIyVktNSHlJTDJtc3JCN2Y2Z2k2WnUxTkd5eXlURmFm?=
 =?utf-8?B?SlgrTHRHU0trUEsraHRNM1ZzbUpPb3IwazVTdlhxc1YremdnVC9FQXNOdmpX?=
 =?utf-8?B?dXdwdE1HVUZwNFBOYURoSWswU2xTYW13blY1bjJEa2FxQ2xsZlkyME5IR1Jh?=
 =?utf-8?B?aVduYldVWUExSVNCSXgvNzhHZjMyK2hqWGx6OVJ2QUl0Nmt4YVdWSE83bjQ3?=
 =?utf-8?B?UVN0bFB4TnEya0phOTNEdHBaR2ViYjY1OGhhMVhSR2k2alBrZnBGeUxDWjZS?=
 =?utf-8?B?Z200WEkzR3cwY3FaSFhJalMvKzJRWVV5aU1Gb3FIdmhzN3pJWDFiTkEyYnF0?=
 =?utf-8?B?Y0VlMlp1Rk5pYldBSVFCRFVQak9vZFlEUmRsc2FXWW01OWdYRWRFSlNYbDZF?=
 =?utf-8?B?eGVUNnNQdmVhWW5wVXg0alU0c1o1SUN2Vk1VVVpQdGoyYS8xRGVzbmo0YjB5?=
 =?utf-8?B?d05WWERLejd2d0pLSGxXNHJZYlNNd2ladTVxU1FaWWlzekg4YTM4N09jYmFH?=
 =?utf-8?B?OUVIWEFWaG52K09laFJSeURlUXFpMGtjd200WW1YVm5pelJqMEFUTDVwcU1L?=
 =?utf-8?B?bkUrbUFIZlpYL2FjZU5XY2llK3BXZjlINEppWXphZTl6ODhZSHAzRkhsRkV6?=
 =?utf-8?B?UWlUY2lHTUFFOGg2aE1NeFJUeElwT2toSlI1T3p5ZGNocjNFQkdxWTNZY0tC?=
 =?utf-8?B?SEt3bEgrYVBTZkNZTkVpS1AwRW93Slh4WTlsdUlQcDNnUUl4SjRPUUhPR0Ix?=
 =?utf-8?B?RTRZOWFqeHZORXNNUktZd2ZLRkUzVWNlYm5IdDRsbkdvZGsvazJKRGNvZWNR?=
 =?utf-8?B?aEdKVkNtNTZkaUFudlhvWmVrYTQ3L2wwcFF0RkVvSzhvNzVhNkM4dFk1TkFC?=
 =?utf-8?B?M2luc3JQWlRTWjFlYVA2Y3VaNHYyTUh3K1pXUDcveDlCY2xONk9XTnpYaUFG?=
 =?utf-8?B?dlpkWVJvVzVjSXhsTTRtR1pGbGZtcjZqU0VIWW11RUFjdlRCOVVXWUJURzVK?=
 =?utf-8?B?aks3Qitac1R0eTV5V3ZSN2tjZStIbHp0SUlHN0xmQmJ6M3RmUlFuNjd1WFVu?=
 =?utf-8?Q?tFBfDC0HFWHxfNz/oQdYiYFkbrc2wpC2xE+5T4x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(1800799016)(376006)(366008); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTFMOU42QjluZlJUNEJ3L0krcnNmcW80OGozWXlqR25TZk1NYUZEY2Y5REth?=
 =?utf-8?B?cjhrMW8rZDlOOUIvc2hISVdxUDc4Y3h5cXhKekdRbFM1VHBwOHlPZHcyaHFk?=
 =?utf-8?B?TTh3ckljaDhVa2JUMGhyaEZtZTVYMVMxTFRRMnQ5cm5mMEpOSXNXV29tSXJs?=
 =?utf-8?B?aWpHemFPUzZLcFVOOExXZ250SllHSGE2aHRTUDFRTDJlRUp3TUdHUWJ0VWJN?=
 =?utf-8?B?UjdrYTMvUUIrL1FEOTBha0M2Tm1WeDJaakpnWURLRE1TQUNUT3dlbDJVT2dm?=
 =?utf-8?B?eGYxNUd4K3ppU0hRY0Y0eU5uay9DQzlLajVVNkRmY3NPUTlIRDhjTG5WRDgv?=
 =?utf-8?B?Y3JHbUg3VGdnRzliYWtPYlV3a3NHVnErSGYyZVpuYy9paGVIdWR5SWxEK1Zw?=
 =?utf-8?B?WFVCSUg0Mk43YkJPeXljQlVVZ1VlZUNsM2VDMmhnRDc0M3hQYkh5aWhwTldS?=
 =?utf-8?B?clZ6SWR0SDBkNCtYTDlLdjRYZGxCSXpVOEljeGtlSGtDdlEvVGNXWWJCRTU1?=
 =?utf-8?B?K0VhTXZxUHJsaVFIaHo0SmZic3I0WEEzMWF2dGpieGlnZWJIaEhmS2gzMVdG?=
 =?utf-8?B?bDFaYy9YaWZmNFhkM28raTBvMFcrOGxuY1RaekI2NDRROXNMVnNBSjdGdzFo?=
 =?utf-8?B?UkUxSXBhZ2EyQ2F0dkpNaGVjNy8zTDZIeHZWZ0JJWk9HS0htWHAxNHE3TmVO?=
 =?utf-8?B?UnBScnE0SFM2ejc4TEd6eDNaUFVqOEJWTnlJSHVUZHVGNWhtbmQ4VUlvV1c4?=
 =?utf-8?B?K2JZRkFlMGhyMVh5NEVJNWgzSnVodWc1ZjU2RkMyYXIvdXNNNjR3dExKNGxo?=
 =?utf-8?B?eUlyUGdSeG5HN0NVbGFtc3VIRXNiSVVPaERkMnArZkQ3VXZheEFzUnYybmlj?=
 =?utf-8?B?STNySHhvNnVUNHNTK0llNnpzZFJZVDl1RHJ3Uk1lck9GMGlRV3RUQnd0S1pk?=
 =?utf-8?B?cDVHbEdjMU11R1dkRlZpSEkvSVdOUEovbG5kQUora3NkWG1mNmczYnc4MFM5?=
 =?utf-8?B?Ums1eENXWHdXTDFUTnpKZnRSTy84bFFlL0FiNEhIb1NFNlA5N050KytWMDUy?=
 =?utf-8?B?dDZuSStVcjYyamJPbEIyTXJHaDhGLzh4UEI1WDYzR0tCOXNaY1RkUG9VTkpr?=
 =?utf-8?B?dGw5MmxySWVFNHUwa3BYM3E5TzUwNXhSTDRwL242V2FCZ2dOanpsSVZhUWZB?=
 =?utf-8?B?L2tJYjdZc1lGSjMxYjR5R1J1aGpvSWxjcWxEcVJPRzlITGhEU2w4L08yZjFK?=
 =?utf-8?B?S3JEdU5taGRxZUJTSzgzcDZlZzRGemdIekNHcFkvRnBpUng3cXBkeThibmtr?=
 =?utf-8?B?Y0FkcTNiOHFNK0lBR3Q4NkFldzF5V0hVWS84Nkt6S3AvcC9mcWdTZ1VLajI1?=
 =?utf-8?B?Z2tob2JxUUNLcUszM2xMcFA0ckJhSk1YUk4xM00wU05NbWlib0ZTakRrSk1T?=
 =?utf-8?B?RndYdkVuVlJWTlpLNE9mSko3VENwWWJrQlNjRDJwdHVJcGNENEpQMFA2L1A3?=
 =?utf-8?B?Y3hRSXZ0K0hVUkZrSDB4QnVrV0srYUNRLzQ1NUZiMGpvUHk1K2tidy8vdEZl?=
 =?utf-8?B?cDNIcW5GSW50bnJCVkc1Zk1hSy84cWREOUhHQXlOeXgvcUZmYUxpbVJyZFpr?=
 =?utf-8?B?MnFZSkFRakhISUp5VVdPb2tGNVlOdHRrUlNmWXF1Ryt0MFhjUEVWTXBYcVIy?=
 =?utf-8?B?RXQxNHpvWFBydVZJUW5xRURudWsxMFJpTzV6cmkxTnZrbE1XNWtZRytwd29J?=
 =?utf-8?B?VG9RYXpnZzE3SUZnbkJTOHVtSTg1TEp1ektkWjU5NmIyOVRRSWRLdVhwRVVq?=
 =?utf-8?B?UUJYSm1razFRcGVSQ3IrTXZFK1Jia1dzRmliTU9ZVmlQQU1jZkZXRW41WFV2?=
 =?utf-8?B?by9xOTloa2dSZjhMYm5QeEZYNnBNZlR2R2FkVENjcHBCMng0MWRRQ1JXSWlN?=
 =?utf-8?B?Q0xweWYzZURIWHRyM01aclQ1RnFtVU02RFdBSDVUcklZcStEV08vUjlZSVVI?=
 =?utf-8?B?ZDBDcjlNSzZtQlg4b1VsZFlkWk0xMG0wWC9FVFNTMmkzRGJsd0hnYmxpRlho?=
 =?utf-8?B?MzV6Y1lSZE8rRTZIZDNEeUFZckhFZjgyR3ZGYk9mcGVic2duanFhTkxLRi9L?=
 =?utf-8?Q?fa9BbBTwl4ZC3ODw7ee2suTQ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056aaec3-e004-4b09-11d0-08dc8ac9b23a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 10:23:26.4222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRUqhAB/H2p4PNt6XiXqUFBmy69HEaxZ/xWChcyzxy9lzJSdsXq58JnfJjQnx4Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Well there is still no explanation why this patch is needed in the first 
place?

When the higher bits are ignored by the KIQ then it should already work.

Regards,
Christian.

Am 12.06.24 um 11:57 schrieb Ma, Qing (Mark):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> @Deucher, Alexander @Koenig, Christian
> Can you help to review this patch? This patch is in the critical path of MI308 release in 6/20
> Related doc is amended in the attached email.
> Thanks
>
> -----Original Message-----
> From: Yao, Yiqing(James) <YiQing.Yao@amd.com>
> Sent: Wednesday, June 12, 2024 5:37 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>; Yao, Yiqing(James) <YiQing.Yao@amd.com>
> Subject: [PATCH v2] drm/amdgpu: use local xcc to flush tlb
>
> When flushing gpu tlb using kiq for gfxhub, kiq ring is always local by selecting kiq instance. Test shows mmreg write data packet's higher bits then 16 have no effect when flush using kiq on gfxhub.
>
> Also some variant have policy blocking higher offset when req/ack is set with extra bits and can cause flush to timeout.
>
> So keep the lower 16 bits only.
>
> Remove redundant code.
>
> Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 350f6b6676f1..f3fe318e0c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,16 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>           */
>          if (adev->gfx.kiq[inst].ring.sched.ready &&
>              (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -               uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -               uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +               /*
> +                * Select lower 16 bits to write in local xcc when flushing
> +                * using kiq to write gfx as higher bits are always ignored
> +                */
> +               if (vmhub < AMDGPU_MMHUB0(0))
> +               {
> +                       req = req & 0xffff;
> +                       ack = ack & 0xffff;
> +               }
>
>                  amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>                                                   1 << vmid, inst);
> --
> 2.34.1
>

