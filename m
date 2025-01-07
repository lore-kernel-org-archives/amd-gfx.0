Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E38E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 14:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D8610E30C;
	Tue,  7 Jan 2025 14:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12dIsU80";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6776110E30C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 14:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scnQvWgCzn53iOSKhnjq+l+s+UMzuZSO1SCmu+uuZ+LRMZfsumVdJhhQ3OKP12xJrxypkeDpkXnhPaPt2crV0OtreTzJyYSU/E6A/xhF+jCedDSu+BUTy5ol6mWXcfalkSu/ZxSukXubScI8XGABHLx6K4GHgQZHCsRDSmCDe79SAoU9UV2si+O8kckZRxKCqGMHmKxgJUZdH9esLrAKRgjI4HAzAr2zQvbb1V22A3vhl8AZuwg2hRPVqaT+Ul8O2UG6ngoanYnpAtoV8ZUmD5kNlunzWLHzC/3vEw1pevsy4cskCw7zmEC0dLfaRfNPXg9pYgpfsSJO8hXQJIFk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWAPs1vFWvWTI0gD7LZuibNoNx4JjhSGpku0GGkUykY=;
 b=IdqnIFS1FyRX9QMYOzC2en77CPHQceEjOSD+RjO4+14YJ1HNxBVqbJI4GnywJI+TfziU/RcJdyTPrqIqwe8jYHNxM3mlSrUuBF124NhUBewzO1fYbkzCCbRVk/TlfbvFI3gU74UW5mw5LUYIBNd3Eq4s9EbXIjqWl9NouF1vpiLqNnUKgr5MmM7XjoQm75ypmIaXZdLsm2MJk+GU0wnorYSRS01W1xY0YUkxCT0kiFvlhgq3OZgnPifmB1byDMsyVi0UqB89r0/dEJeOVfXj3rtrTpQKQ+cNlFSyV3nkqojFvxq963vll77lwQyJT1NSiO4eCnt2kk797EwJYEoK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWAPs1vFWvWTI0gD7LZuibNoNx4JjhSGpku0GGkUykY=;
 b=12dIsU802UUlmD4hzv6SfX/tuzENg69KcNqQlFJ8MLUK+kSzRumdYTG1+vZMDAi7RSYSQne6KePYTdXRx/WpOq6lVJ+2YuVOEWIxXZZNLcg+n24oYC3pdI8zEJBtPsTfN3LURl6098m8hkjXL6spYhwWjlnvEjYWiLzigomX3KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:03:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 14:03:39 +0000
Message-ID: <48140c5c-bb03-2c47-020f-48132c61d61a@amd.com>
Date: Tue, 7 Jan 2025 09:03:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com>
 <PH0PR12MB5417148144D18CD9CDB70A3E8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB5417148144D18CD9CDB70A3E8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a317a3e-ac45-4dc7-d436-08dd2f241651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFXTXpkR1Y4ODFwQmYwNVNHb0VQR1VMUXlyNHUrbUMvRmFSamVSTlJ3V0pz?=
 =?utf-8?B?Vlh2Q3g0ZlI1KzRYc2NMcFZReUdtbzRKVTFLMzg1RGZqVDJXMVNxSTNZd2ZZ?=
 =?utf-8?B?ZTZwYk9oc0tWZVppcGdiQWs1T01sTDZ3aTY2QjQ4NGZrSitILzhvQnoyUEVD?=
 =?utf-8?B?VjNaWWhubnh4Ym92UDlvY1FLbkhEZDJUbE9kaWZOaFI5RzJJVGd0T3BoSEtG?=
 =?utf-8?B?KzRsaUpLb1ovR3Jwb0dlRkhsSklZTGRlOG53QjNlZnBrU1krVmVlZ3kyYlFD?=
 =?utf-8?B?YWN1SER4bzdBYUoxdHdmOE94L1JyQ2pSbVBiZHZKM0lJY25zREoyZEtIMFNz?=
 =?utf-8?B?V0xmMDZTMUZuSk5lRXh6Qms2bzhLYVZGdG84aWxMbktlWW1RVXpHb2ZORzZu?=
 =?utf-8?B?ZzZkTitMTzZTc0RJNktuVlNEL1I5VmwwU200enMvdW1memM5ZHRQZjJrdWYr?=
 =?utf-8?B?NTJBL1RIZHdRYzY0RXVvRFdrcFd3TkZnUEpIUkFxS1BZbVg3clJwQXNmMXkw?=
 =?utf-8?B?ZFRCK1hjcG1BWitTRU8wUGloODFESUFLU0JPRXUzOEJtaWpkM2V0czlBMzVo?=
 =?utf-8?B?Y014aEMxK1BPOUNVR3Z3a1VUUG9JZ1JONGJENkR0KzgySzRuUGFOVUZJcDFD?=
 =?utf-8?B?S0JWVjBaMThRQWMvWXorRk1LZStMSEs3TEh4UE53S0dyL0VWeEJ3WEhxUEJq?=
 =?utf-8?B?cERpRWpEZHB3V1dQbXhLREhjdExzano1dUVpSktKb0NYNVhmNzBtQnZta1hE?=
 =?utf-8?B?bDJLVDZ2RCtNUXFMUzEzdnl6QlRGWXBTKzFpLzdMc2hNRzdLYzhuR2JFQ1gw?=
 =?utf-8?B?cC9CU3pERTFDTG5KTExCU3VnL2czQlpuNjIwSXQwQW1wb0VWeUdxWHcwQmFi?=
 =?utf-8?B?S05adEoxa0s1dXFybk1TWVVXY095YmJCMTd1alFNT3hSTkpuWmtzTkVZWUZx?=
 =?utf-8?B?aU9oRXExOUNZVXZVWWZkS1JLNllsb0VpMVIvdEZZcklDWnluYSs5UGhCcjIy?=
 =?utf-8?B?Ny9EbjZTTTl0UGwwbjRDNy9NeVZZanNFWW0zM0pjRUk1c2duU2xIaFlhNVl0?=
 =?utf-8?B?NDBEbHpWc1Z3eHZpZnpmMDBzVlBpeXMrZG80VHdDTU4rN0tibnFvYmU4SGRU?=
 =?utf-8?B?N1NSbVZXMng2Q2VSOEtGTHErTlpPZ2FKNGVWL0NFQU50K3R4Z0RCY3pRNkhV?=
 =?utf-8?B?T0dsSEJhd1lJMnlCSDVzOUt0c0NXVnhTUHFjMmRBc3NxK1NhUjhuVGJlTU5Z?=
 =?utf-8?B?K0hJRFMwZjU1bVc3Rk93eFBsYlh6Uzk3cTZadG9HbzRjb3laaTVZV01SR1VB?=
 =?utf-8?B?WUF1MGZhN0E0UEcvekJ1dk1IQ05MMzFEbnM3NzFZT3ZZMGFMUVRJN0JqTVYx?=
 =?utf-8?B?eWdMMGhUcTlQQkQ1YnFNZVZ5NE03RWRPbkgzemlvb0JzenRzcVVxK0grOENO?=
 =?utf-8?B?cURoOUZ0QUI1ek50aW1QSnRBbkxiWFd6Rkl6cEp2MFRjSll6REl1M0h5RWRp?=
 =?utf-8?B?VDBYbUg0Z1dLKzVLS0ZLcmkyRitqT2xlNlNUWEZOa3F1SzlWVlJJQTN3SGFI?=
 =?utf-8?B?eWlxSkNYTkFBTUFNblpsSCtwL3k2TnZXUk1CaFRvTzNHWFlWclhCS2ZTZjVo?=
 =?utf-8?B?VERCNU5BdVBzdVlLR2d3ckVvNGpDRE92ZW55aU1DQ3dvSUplUW1WUEp3V01m?=
 =?utf-8?B?QzhqMXIwanpOMkh2VVJFMEQ4Z1lZMkZnYjJyZ2V3d2V1ZURudmErdmk2UkNs?=
 =?utf-8?B?U3FxL3hiSnJpLy9xeW40aXZGMFF3dklHb3drLzJDVlh5djlPeEhIN20weXVD?=
 =?utf-8?B?MytPSVNyK244Z1ljS3ZvcCt5ZnBJbkFRM0EyS1Q4aTFLN0gycUREREt0UUd3?=
 =?utf-8?Q?fHCHzIUMpmhIV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0g0akVvVUl0TmVNMHVQaGRzc1Fia0tIMVRTQWtKblRTVlNWSXRSb1Eza2ZJ?=
 =?utf-8?B?N0FQWHYvVHQzZjdtQ0dSSWxpQWQ2Y1VIZFF3R0dtTG9vbzNHKyt0MDRNdENa?=
 =?utf-8?B?YWJOZFN6SFdUMFRhZWRNNnRHemdtZjdVZHhJS1FUVHNPcVRyMTZKWXVoUzdY?=
 =?utf-8?B?L1JET0l6QUIyRTN6cGhBZWM0eDNsV0F4SnllaCt3ai9pT25ydzFFWXZyNnJn?=
 =?utf-8?B?elQxdUJaS1JSV0RyUEI3b290UnN1RDNodTE4L1FxTzczY0FNQVJVM0UwbTV3?=
 =?utf-8?B?N3M4U3dacFQ2dGY3dU4wWmhDSXYxaURLbUd1dUQ0VWRNUE9DS0Iwd2hDdjdZ?=
 =?utf-8?B?d0FkUmU0dVJUVVpXQ3pjdzJ1S0REWC9BVnUzVExwdUwxM2Z0aVAwbk5GUzVp?=
 =?utf-8?B?QXlvY0g5VDA2Zzk0SFI4Y3lSd1NraVN2eFNTTXNtbFlodDdKaXZFL3lzNjZo?=
 =?utf-8?B?RDU1VTY2dmJ5ZWF5T2FiWVZuR3VGTW8zTC93cXp3eHZ4S0RpT3VhTDlvYW5a?=
 =?utf-8?B?UEJEekxxSXZjS29nWjB4ZmlEQ2dlcm00T3NZUENpMExxMDV2MWJkVWxpNFBF?=
 =?utf-8?B?d2hOV2JEKzd2QlVaNDg3VVpGRUdaME9zRXB4UkRrVmJhWWpvSUxXOW5rRDdu?=
 =?utf-8?B?cEtzb1ZnSWUxejFWck1zakhMUmR5ZkZnYlJKd2pyeUhRZVZoNmFYdTloeXBu?=
 =?utf-8?B?ZGlpWmNTR1pEMlZUL3VBNS9qdkVla3lIaWE4b2VFUmFkdy9KK0dYYlRsM3F4?=
 =?utf-8?B?UXlXVlc1VTNIbVhNOEVvSUZUSjE2ZVMzejRjeE0vcmhmT0FKbUhuOHRGQnEx?=
 =?utf-8?B?L1YzVzRiRGpFMlM2cDNOZ0I0eWhMcXg3MktYbUkwTmZDaGJ6REovbnpJeVpu?=
 =?utf-8?B?ZVZjdGxQbTRqdEJUb25mdGhOS3FmNlRwOWIwcVhBSmd4ZFhqblZOczQ1WG1Z?=
 =?utf-8?B?VDJWYXFkS3VpcGhOR3llangyMzhjMVBsL3lPMVdEYmtoWUpOQno4VU1VNFJo?=
 =?utf-8?B?V1ZGZ2dDUzF6cHE0REsyOTdOY21jM2FQdCs1L29WQ3ZQOHFnK2lWbitKdjdG?=
 =?utf-8?B?cnlNbVZmYlNzL2tJWm1hZzVkdm40Q2JMeXhTNG4vYS9BODI0b1oxRXVjVWpR?=
 =?utf-8?B?MEdnbkRESnE0dkNCT3VsMXMvVjZIcjNCbnpTU25jN1BSci9qTmM1TlBpN05l?=
 =?utf-8?B?dFNiVnU3SnRaZkxyOEMxT0RoSDNFVSsrNzl3R0J0MGw2c3pZQ3VzK1VmY1B3?=
 =?utf-8?B?ZzhDNWdINlFJSmZ0VDIyc0dNQnk3aDN3K2MvRWFmWHdiOGVwTFJobEJCSkJS?=
 =?utf-8?B?azJhYld3NlVPWmNoTXVIbktDdHdVUkRHVmtBTUovK3BERXdQM25NNC8yZDFa?=
 =?utf-8?B?MnNyOXpTWnBDaGhodUszYk03WVhQb2dqZU9VeWFWZjRGa1MxbWl0Y3dKNk1O?=
 =?utf-8?B?amRZcmZMWFY4Mk1PZHdQSEEwUXg5WXRrYlhrYVJnRENkTUhWMkhTcERORW5v?=
 =?utf-8?B?VHlWUlMzdzMrc0R4NlJ1WjM1c2JtaG1DUUJHNGxHRHRvdEFkQUk0S0czMHVN?=
 =?utf-8?B?UVYrWTNIY1ZzV0FzbjJWUkNiS3ltV29XaS95SWpFUUNYdlRaRHdLSlRzQ0lR?=
 =?utf-8?B?MlNGN3hZbUg2NUJ2VTdVQjRRMHVUdU11OTdyZXE1RVlVY1ZQR2hRTzk1RDBK?=
 =?utf-8?B?aFB3RGZwdXF5OVhFVGhzTDZYME9lSzh6dFNCblU4M29RTlhPcWpBM24rMk1u?=
 =?utf-8?B?a2ltanJVTnlLK0tqeTl2OER5bUlxSUh0Mldod1pvWW1mdjE4dllRbys2Y0w3?=
 =?utf-8?B?S3lnU2o1MVdSOWQrRXdHNEQzUldJNHBkUjVTOUt3Zjd3WjlKeVpiQzFUVnBp?=
 =?utf-8?B?K25RdStWbS9nRHlKWk5PZzQyOVI5OHE0YUtNMmhiM3hLMktQWXUrU1lKS0JZ?=
 =?utf-8?B?M25icEhwelVVR2pWZUNXM3R2QnBjR1Zma3ExQ1V0bHBMLzNwUm5wdWs0RUd5?=
 =?utf-8?B?ekF4cE0zR1dLYmlvOWJKa3R3TWcySVVibjBvb3h3Z1lqd1Rua1l4bC9RSDNa?=
 =?utf-8?B?Y2NGM2thK243Z2xMUVlMaEtyTmNTWUNTbzVLWWJEWC9JbDc5UUdjb3B2L0NM?=
 =?utf-8?Q?O1xieMk5u9BKD32uJuCwFoCpz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a317a3e-ac45-4dc7-d436-08dd2f241651
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:03:39.7641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbMtuks8d67u0TpYgC2BN6D3VZLN9E8cGi7ssggCW6GKrDYmKzen7Tqu0xhfemyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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
    <div class="moz-cite-prefix">On 2025-01-06 21:31, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5417148144D18CD9CDB70A3E8F112@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
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
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
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
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Tuesday, January 7, 2025 7:51 AM<br>
                    <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix partial
                    migrate issue<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 2025-01-02 19:06, Emily Deng
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>For partial migrate from ram to vram, the migrate-&gt;cpages is not<o:p></o:p></pre>
              <pre>equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed<o:p></o:p></pre>
              <pre>migrate pages which could be copied or not.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>And only need to set those pages could be migrated to migrate-&gt;dst[i], or<o:p></o:p></pre>
              <pre>the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
              <pre>---<o:p></o:p></pre>
              <pre> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----<o:p></o:p></pre>
              <pre> 1 file changed, 4 insertions(+), 4 deletions(-)<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
              <pre>index 4b275937d05e..5c96c2d425e3 100644<o:p></o:p></pre>
              <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
              <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
              <pre>@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;struct migrate_vma *migrate, struct dma_fence **mfence,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;dma_addr_t *scratch, uint64_t ttm_res_offset)<o:p></o:p></pre>
              <pre> {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<o:p></o:p></pre>
            </blockquote>
            <p>As partial migration size is based on prange granularity,
              by default 2MB, maybe always migrate-&gt;cpages equal to
              migrate-&gt;npages, that's why we didn't trigger this bug.
              Wondering how do you catch this bug? This bug will leak
              svm_bo too, as svm_migrate_get_vram_page reference counter
              is incorrect.<o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre><o:p>&nbsp;</o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<o:p></o:p></pre>
              <pre>@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<o:p></o:p></pre>
              <pre> <o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
              <pre> <o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage)) {<o:p></o:p></pre>
              <pre>@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
            </blockquote>
            <p>This should move forward, to handle the corner case to
              migrate 1 page to the last page of VRAM res cursor.<o:p></o:p></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Sorry,
                don’t understand what is the corner case? And the place
                you put has not much different with mine, as it doesn’t
                have any jump or continue in the code between your</span></p>
          </div>
        </div>
      </div>
    </blockquote>
    migrate-&gt;dst[i] should set before this if condition (not after
    if) to setup sdma copy migrate-&gt;src to migrate-&gt;dst, if
    condition is true for the case migrating to the last page of VRAM
    res cusor, as the VRAM physical address is not contiguous.<br>
    <br>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1
      &amp;&amp; i &lt; npages - 1) {</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB5417148144D18CD9CDB70A3E8F112@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
            <p style="margin-left:11.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">code
                place and mine. But it has “if (r) goto
                out_free_vram_pages;” to handle the error case. For
                error case, I think the
              </span>migrate-&gt;dst[i] also need to be set to null.<span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
            <p>Please check this change, to add mpages accounting to
              break the loop earlier. <o:p>
              </o:p></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Good
                suggestion, I will add mpages in change.<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                Deng<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                Wishes<o:p></o:p></span></p>
          </div>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p style="margin-bottom:12.0pt">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages =
            migrate-&gt;cpages;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mpages = 0;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *src;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *dst;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i, j;<br>
            @@ -295,14 +296,9 @@ svm_migrate_copy_to_vram(struct
            kfd_node *node, struct svm_range *prange,<br>
            &nbsp;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages &lt;&lt; PAGE_SHIFT,
            &amp;cursor);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages; i++) {<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages &amp;&amp; mpages &lt;
            migrate-&gt;cpages; i++) {<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<br>
            &nbsp;<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt;
            PAGE_SHIFT);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
            svm_migrate_addr_to_pfn(adev, dst[i]);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
            migrate-&gt;dst[i]);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
            migrate_pfn(migrate-&gt;dst[i]);<br>
            -<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage =
            migrate_pfn_to_page(migrate-&gt;src[i]);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp;
            !is_zone_device_page(spage)) {<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] = dma_map_page(dev, spage, 0,
            PAGE_SIZE,<br>
            @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node
            *node, struct svm_range *prange,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
            out_free_vram_pages;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor,
            (j + 1) &lt;&lt; PAGE_SHIFT);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
            @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct
            kfd_node *node, struct svm_range *prange,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to
            0x%llx, pfn 0x%lx\n&quot;,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt;
            PAGE_SHIFT, page_to_pfn(spage));<br>
            &nbsp;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt;
            PAGE_SHIFT);<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
            svm_migrate_addr_to_pfn(adev, dst[i]);<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
            migrate-&gt;dst[i]);<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
            migrate_pfn(migrate-&gt;dst[i]);<br>
            +<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt;
            PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            svm_migrate_copy_memory_gart(adev, src + i - j,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst
            + i - j, j + 1,<br>
            @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node
            *node, struct svm_range *prange,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            mfence);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1)
            * PAGE_SIZE);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
            (END)<br>
            @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node
            *node, struct svm_range *prange,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
            out_free_vram_pages;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor,
            (j + 1) &lt;&lt; PAGE_SHIFT);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
            @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct
            kfd_node *node, struct svm_range *prange,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to
            0x%llx, pfn 0x%lx\n&quot;,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt;
            PAGE_SHIFT, page_to_pfn(spage));<br>
            &nbsp;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt;
            PAGE_SHIFT);<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
            svm_migrate_addr_to_pfn(adev, dst[i]);<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
            migrate-&gt;dst[i]);<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
            migrate_pfn(migrate-&gt;dst[i]);<br>
            +<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt;
            PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            svm_migrate_copy_memory_gart(adev, src + i - j,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst
            + i - j, j + 1,<br>
            @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node
            *node, struct svm_range *prange,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            mfence);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1)
            * PAGE_SIZE);<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,<o:p></o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>
