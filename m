Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFC0CCF9F5
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 15:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720DA10E62A;
	Tue, 20 Jan 2026 15:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YaHQRBk6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7D910E0AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 15:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUw3u072UKAWfMkYuGIorN1WOx76M9x8q87gTdAdptRROZEvplVCD6etTRlFIrOxN6EGCdHxUiPLJn3Cnyu9yZYkW+xJSk6VUxpHf485A/6VVtvChGMni9Qq7He+n7D+RvSYPgsRcN+GnJZl0KrsqRZ/hZIqw2hx/3MO86TbftVcExCFODlnHgYgxhBY+Cd4+mY7mondpTpJaWHGdyMWey73P0izqIxY7jqQX7VGK4A2O54Mbx4Q2oR8yKf1nYSIIqTuYnXhw5x1BeBn0g0yonDyi2tL6IcNOLi/xeK6o6m0XXt4qbirCZlyzpGDFTZ5JpgqB0V9wuYFRAWfAMqaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFV5A2pPlDnOw3uUkH86slg7Yk9n73VcZEsIe+7wnu8=;
 b=Q0wzfcb9E726Q/V9lBQSUGjHqgItABmwBQc2KI/Kqqdw9DQ98ofxUX7kTnZB7j5xxXbrIR3+TUQp9RU+YnZK0WH0earAq1G9IFunUxHykcZ+0mPrnHPvK+NFgog9X+GaVn+j1SKKzrVsTKbGuFPaEy27QphvV21Asla5Jiyj5V8gnj1mqOB87M15Yg1zTPyIRf3ed76p/x0PHdwnBc3egLLKjAuFqJ6L0PyypL16wKzQ7VLtTONSgSsGj+1yTTFoYcVYRpl0Oh+ZIjJssRk/cAEMV78KZpjZEzvjGcwdMqY1/l8rWgoCX/xuAKrZekF0zeJtGa87J2XIyW0yCi7pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFV5A2pPlDnOw3uUkH86slg7Yk9n73VcZEsIe+7wnu8=;
 b=YaHQRBk6oalMuXoxwFOM0EEsSTIrDzweEOQeSW7CmwJ2g108rcCdP9G5Ud6JAp61CQNdu9AhiCHjaLktIPy72Ih/domwxtEETLiwaV4pkG41U+CQA8yZfG6VYdDUki2qOs9CZAu3F2eBvvSFvMI25+8eRoplK30YYEB8RVfrPQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:42:50 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%7]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 15:42:50 +0000
Message-ID: <a42a5b10-b0f2-4833-bac3-c2cc83aa6921@amd.com>
Date: Tue, 20 Jan 2026 21:12:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Avoid excessive dmesg log
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, victor.zhao@amd.com,
 Chong.Li@amd.com
References: <20260116045319.773093-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260116045319.773093-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0031.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::14) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ba73e5-c386-4215-256b-08de583a9157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3BxTFRUKzgrSVBVZ3VwcFB0WHlDZlpFVzQ3Q24wY2Jac09Ic2pVVmpDaFc3?=
 =?utf-8?B?MjBzcFlsT2w2SFVzdGVtcWxpNXNidlRXRnZKOHA2T0hkbHpRbDBPSmZTWGw0?=
 =?utf-8?B?STRUQmFaNXFxaWkySXpqNW5UVjZkRndScUp3bDFFWVRzK3ltZ05TTy9TN2lR?=
 =?utf-8?B?Q2ltS1JYVE5DNkNFaGtacE4yTk03a0IxYXRKcnEvK1J3cVBiL1JLUXZEQ1Fz?=
 =?utf-8?B?VFg2Z05DQ1VES2tVTFZwd2p5VEVkdWR6WGp4VmVRdlQ2cjl0M201L2Y4R3hw?=
 =?utf-8?B?VEg5M3hqZExvdmM3cTlFbXJiai9zSnNQak1jc0ltS0p2bnlDTno0ak9abXZJ?=
 =?utf-8?B?bnpwbGRaYmtiMmxNUHQyaUxFbGhLZ3lKR2tHaVRyZkNXY0Rja0FXZXFKdytZ?=
 =?utf-8?B?MGRuSTU2dVNIY0VwQk90eXQ3NGZCU24zcmZmNFBhbmIxaGlVRVJyUEF0Mmoy?=
 =?utf-8?B?bGVaemFuRHpCTnY0MnJicEdmYU0zNGpXY2tyaE1KdStxd25iNXJma09sUi8z?=
 =?utf-8?B?ODJRY0p4bUZqcXJ6aUUrakNRcG5rRTJjZG9sd3R5ZU9BTkpmVGt3N0FxK2w2?=
 =?utf-8?B?eXYwZ0pVdE12c0FTaUdIczJkcTdkNElvL0pDMkQzc3ZxU3ZZZjUzcXYyTSsx?=
 =?utf-8?B?dXZKOHV0elpOYTBneDgyc0dkaHJENzJIVU9PenlEUW9sbGlzeGowdUdvSGJL?=
 =?utf-8?B?NTROd2xXd0QrcUlpakd3azJIdWVFMFpOdlFqeXFsVG9iOHFDZHZoWDd3N09F?=
 =?utf-8?B?dWViQlg4cWZJbmRLejcwY0JqdHppRmlYY0xDV2I1NnYzVjRVTlpBQWg4dFlS?=
 =?utf-8?B?QVh1bXVxeEk2MU1yV3RlQlo0bDFpSExVWS80U3F1SW9UdG55YUpNK3IrdE54?=
 =?utf-8?B?TjVWT2dSQ0R5Z0c1VWptZFV5T2RmNE5CRDdFRHpKck8vb0FmQ3dhZVJ5SWZz?=
 =?utf-8?B?bTRHTExaR0g5dWdaSnhDVU40Q3JYYWZrOFNGeGNoc0RqTXpjY01pakg0UXd5?=
 =?utf-8?B?ODdaU3ZwS05tTFFDZ21CVExXYlNRM05weHpVNHZILzNlcmdURkY0UXR0SU4y?=
 =?utf-8?B?R1dYbnBYTVBEc0VobmdDZC9wOXRKbXZnQTZ5bzFTODMva1VPdXRGWVp6WmJG?=
 =?utf-8?B?N2lwdkNGUW53NnZCTEJtUkJkQWxDY0lWWlRTQmxFT0VPSzZ6RW4wRHlqblpS?=
 =?utf-8?B?bUU2V2FqNGpJSS9UMEhKdTNJUEFZMEphT0RiaXQ5NE9nYXRjc0ZIY0JJdkxI?=
 =?utf-8?B?SlFPWGkySWFXZUZQclAyMzBYWlRCM3kvMHMvZzB3STZjVG5xRU1tSzltMjNa?=
 =?utf-8?B?OERlbU9TTHFiNENNYUQ3aWxsdmlmaXRHNWV6QTZlYlc3NG5QMXZBbVJ1UFgy?=
 =?utf-8?B?KzdQTHVyTUx4bXd0YXlxM3YrRkNVcHdjNGh4TWFNSUpyeW02NkNTeWxJcTBV?=
 =?utf-8?B?Qm0wa0hvK1pkVVVuTXNEaitDNXRRN1gvRmlUa2VJWUVuVGNlUTFJTEkyd1Az?=
 =?utf-8?B?QXE0TzFlWHRvZ1FEamFvUWZxOGErZXVEaFJDS2k4aXo3TXFIRXJ3RVBkclkw?=
 =?utf-8?B?Vll6ZU1tN1YzVSsrUGdPYmh5aDQ5UGtRVlhBQUR3N0cxVFZ6SGtFRGF5bVpR?=
 =?utf-8?B?TFpwRmhBbWdXY2VmNC9abC9raDEwMnlBbjQrT0dRcHh5a2FmNGkzbWh2bzlN?=
 =?utf-8?B?N3VHcmZXa3krbitRTStmVGdTa0dwS1JkYXFMNk1EVGQ3OURybnhaL3ZnY1Rv?=
 =?utf-8?B?MzdPRmVIWllqYjYzbTVCcjZ5QzB3YXdLY1ppT1cxN1pORFFUdThZTThRWGla?=
 =?utf-8?B?U0RaRlpVNnlWaUlsTWhPVzV1aWdHQTh1VndSbkltWXQ2N2JmdTNCbzYyVUQ5?=
 =?utf-8?B?NjdpZGxuRnR2VW5ac2lYYU82Q3pvejEydjFtTzRhWHVPcDYraXUrdlNPUFA5?=
 =?utf-8?B?Yi9KZGdCd3BUSUFSRkJQUnNyZVUvZkJ1eS81d0RwYlRLRUNTT1VXYzVNdmRk?=
 =?utf-8?B?SVR4c1J4ODdmS2d6Z2dIYTNDUEd0NW1wOElRVnlPeXl0OUpBOTk0MDBpU2Y2?=
 =?utf-8?B?NGZBYllCbkFGVVVxK0JQUTdUVW5pdG1xS29Jbm9rSnJROXBxcnBZS3VOSE5N?=
 =?utf-8?Q?SK6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWhaTzhMR3Y3MXpyZEdtRXNpWkw4MXhrYWhEVVh0OVUyK1RtQ2xtMVlwUHpF?=
 =?utf-8?B?NTJqb1ZFSjJpbWExdFdmZ0J1WWRNOFNKcjNxVlRLajlCWWxldlFMVHRYc0tz?=
 =?utf-8?B?WjA4Q1hSeDJ5SStxaXhVNHJwa0RVeS9qWElTekVQKzd6OGc2b09WeWZ6aWo1?=
 =?utf-8?B?WHNzSmtiQ2VJTU5mZXVUR3FDVlJSbjRySFN6SElkc2JVYzZ2MnpDeVluTGV5?=
 =?utf-8?B?K3ZEQUhhdWhVLzFUdmRMT0ZlZXBEOXJySVlzV25OdVM5N0NSU2lYVytEVGkw?=
 =?utf-8?B?TnJlSGhqM3BKZ0VSajhldVQyb2pWbkNRdW8wZVVkZEE2cjZrWUtHZFVhU0Zw?=
 =?utf-8?B?MThhZDJxZjkwWVZKLzRaTXRGUnJWY1FUTUo0MU5ZM0VDQkdZcDhwNGQ4WHc4?=
 =?utf-8?B?b0JTZTA4bER4NHVEY0ZSb2lLYkxWYmp2ajhuRjVBcVNUdFNsYmFvUjk1QmZq?=
 =?utf-8?B?bFZ2VW1CVjZsS0YwRDl5aWdwdzMwbEJERFdqZFhKOGRyemtmM2dic01UYi8y?=
 =?utf-8?B?eXZUNzk1cG1tLzh0Z3E5R3VVd2MvdEhXK3FWdkdmVkhCVlF0Y29lWFhLN0Rn?=
 =?utf-8?B?WlVTSHBlWlRBdHJYa1FXMUhoYnBONjJOMi95bXBkZWlPV29odGtHRjhkR3gv?=
 =?utf-8?B?UlBub1RwcVA2WWFpQnlwWm51V2ZuOVg0MlFQb29IMDZQcmcxbSszV1NUM2ZK?=
 =?utf-8?B?N1NiU3kvQm9oL2JkQ3gybkNWclVqY0w1SitWL2F0OFU0TjJQS0dsWURtRWFi?=
 =?utf-8?B?RTd2R3NLUUpDZVlGTWd4dkk5by9DV2l2dVZFTjBYak9mS1R3SU1ibzFXU0pU?=
 =?utf-8?B?ZjVjbzRldlpMcEJyaktlWFE5U1JrWnR1ZFdyTXBKcXlwczlaN25xNEJxQTUz?=
 =?utf-8?B?ZnZTTDhWTnppWDVYZHdBYW1tdmR2Y1pSaTkvTTdGMHdLcEpGRDVxSHN6UmhK?=
 =?utf-8?B?UlhlYldZTnVpZXN4aXgyYTdrY3J0blUzd0kzNXE5NnYyZ25yYTM5U3YxMDRG?=
 =?utf-8?B?N0FQRGQyNkpDN0Y1TWNVc25RNmF0REZ4b0NWTnA0cWNnRGZiZ2RNK1o0Ritx?=
 =?utf-8?B?SjFHbHFHcDQ5V2lxRDlWWjRTS1NXMkQ0YU1Qd3pkcndTTFN3Qmh4LzRHM1Zu?=
 =?utf-8?B?YWdyZUVsYXpVUE9tanRzTE9ERSsvaisrWFhrNUVmb01hVngvRGtXaWpaTDBu?=
 =?utf-8?B?dmxQd21uUHU4dXB4L2NwemplQUdQWTZIa05aQmdaYUpaSThTbGhJWGpLK1hZ?=
 =?utf-8?B?NjY0a1NEdkl6Q1hMV3QyM0RSbFhHazhyamJYZXpZY0d2a015N0tjTjk2cWt5?=
 =?utf-8?B?MURyNStiVlY2REd5dUxFdWFGclhGZ3RmeWVrRkl2NDUwQ1ZXblc3K3Nvc202?=
 =?utf-8?B?VHczUlFScUU3a3RuMXNZcXJremdlL0FkWFJGN083N1VCTCthRzRrOWc4T3lo?=
 =?utf-8?B?Z0ljby9FcGpaYnZ5cW5nd0VKaVZSUVZ5TWVpVzMzeTd5TW5sVmlIODNVYk41?=
 =?utf-8?B?TEpYSEJEZE5HS25kTDZVSU9McTFmaStOQzhvUS9EVmQySDAzSzZKdGVBd3U5?=
 =?utf-8?B?U2ZOc25NaDdocVl1NWNTazJuL0M1MmZ3NmkrQlpsNW43Y2gyTnE2aVdnb2NS?=
 =?utf-8?B?MExUMjFGTEFNdWFjZzdpYkJ4LzVhWnVPS0JzZXFNRjVpZFpUS3RiOGgxU1hE?=
 =?utf-8?B?ZEg2R2dodnFVcDdPcVJmeUhlVlVacUYvSk5QRmtWNkpRRFMvaWFKdHBzVG0v?=
 =?utf-8?B?M09zRWRteWxqTUMvb3dyQi84cVRxdGNoOHpQa1dZT2ZLWVRKbWYrTmhwTXU5?=
 =?utf-8?B?L0NjQXpkb3d2bEQ3blh5WUdwOW83SlUyMDZBWEpWT3NiTXVKd0ZtVGloQlZC?=
 =?utf-8?B?V1FVUXg1eEdzWTBka3FuUmVEU1VPK29xdHFIL1ZZTVBaWWYxWFFiSVUwK3h3?=
 =?utf-8?B?TzdjZGR0RU1IdG1nd1FnTGVvTGtPckZTaHRIUzZSVmRiN3ZXS2l2ZzJXbnRu?=
 =?utf-8?B?TVI4QUlCSWtSWE5TdVluV2tGRENaSFBKa2R5U2wvcGZrOUozYjVTbWUwQVdv?=
 =?utf-8?B?VEpZanZ3MWxMOE5JOUlCT05MbCtRYmNTMVpLY3p6ZDJ3V2ZYeHJmcWRjUEMz?=
 =?utf-8?B?MSt1SC9SNHlhMnBlSVRMTlI0NURYc2dvcWpZQzZhcDhkcGl5NmFFSXBqSUZQ?=
 =?utf-8?B?ZDA3YjR5b0kydXVEbHl2VGNMMERNQzNuYVdsQis4YXJOSkhYZEMxcExMZWhz?=
 =?utf-8?B?YnF5ODd4U050aUwyWDVLTW8yWThqM3ZXZ05wREhWcXF5Tm4yd1dDWjhDa2pT?=
 =?utf-8?B?MzRnT1RnekZ4VXo2eCtnRXkzNzlqWlVLVXpHYWZuYW5OVGN3Q3RMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ba73e5-c386-4215-256b-08de583a9157
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:42:50.6859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +loUU8SmnsHh08sSF6f0rz/qIG5I+1wNhUfRx5QFEilWXsn2UR+YuHYrWGViUWJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

<ping>

Will reword the description as "KIQ access is not guaranteed to work 
reliably under all reset situations."

Thanks,
Lijo

On 16-Jan-26 10:23 AM, Lijo Lazar wrote:
> KIQ access won't work under reset. Avoid flooding dmesg with HDP flush
> failure messages.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 6abe5103a78d..2bc305b9aa26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1298,7 +1298,8 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
>   failed_unlock:
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   failed_kiq_hdp_flush:
> -	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
> +	if (!amdgpu_in_reset(adev))
> +		dev_err(adev->dev, "failed to flush HDP via KIQ\n");
>   	return r < 0 ? r : -EIO;
>   }
>   

