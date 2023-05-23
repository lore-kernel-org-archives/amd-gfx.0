Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF6FC77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 12:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDDB10E092;
	Tue, 23 May 2023 12:55:29 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A1810E421
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 10:06:16 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34N6E97o018884; Tue, 23 May 2023 10:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7gFnYmfb+RAo2Ie95ANYl8VgLTpo9h5UGedHL3a6z24=;
 b=NDzccj20ve4vtEmYdHVTh1Awcm5l1Aqep8OynHZnlRdj7EBnNPcgq4EFez7+4ya5yAyz
 xDZtawRzzqG6ZymeBQs3s836G8etOTduHpj/J9SimxkE9+uqHATaEV9w/yAXZvXun8nY
 jFyrYsgL9qgQJ4ftmxBPY2J0++GP87IHrC9eLETufFjuHzUfSdVncCunkO71autv7ZVK
 oE6FcX0HRnFbhc2M40qPTGpEE+/V8AfA41TzJYUu+idQcQc5ILv2ipP5Zym31XE8gHcG
 bTnRHCXE+mwpVSBP6vaRWEmREeviSRei22VuRDB6SzTrmXJbcTAMFpqHbQkKT7dS6sFS TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qmqp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 10:06:13 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34N9HtFV015726; Tue, 23 May 2023 10:06:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk6j42rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 10:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS68e+1hcNmLfIp+GEwsf6DeC6INmu1O7T4GSBMuSbQn4ZfCgNCYaMwLYlINiRHV8XWyBnzDydbcQSlaDq6rV1I1qAOwVprG5HCvaQoZDUj8ZIjL2pGxMLDqwlIID0OfIY7+BIBkMmMPnmJ05498Enm9B2P+W314nTQSz9yTsaS51Olo48rdqNkzfK29cYfQadvnglALBvUkp0oRw0Jv3vfBw8KHIAiv2B/VIhDqzffR84YgCouZBg6DLqGsGyp/svyiVPpPoxZZeoLsfZYlKQ9SehaurN2oLawm83SZvx7Ove/74iO6voPzHGtlqHjzjNukgqIR79G+q5NeqeVtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gFnYmfb+RAo2Ie95ANYl8VgLTpo9h5UGedHL3a6z24=;
 b=J9HNTv7ccJvCeUDePjUawS9fmBjNp5rAmSZBbbpsWtErFlwjzGkvAYYg6mgtKB6KV3pIgFUXE5Y70jsVa25+/pzCyJ3rWO7oizNm/aQ7g1gYFo+ZnLeIfE79ET4DpY+J/CO+OJPuFx6ga9laRDQxPIAHZ2HKKquwX6eftR1tZHB+fxXMQSvJp3CGKBtNIXWrFehf06+z6LY8PjenQDN4uH+zv7StLcgEEdfrRmopTWtkp4PzacDjrMBYOi08Qfus1umprdmaCCunGoaq6+3wV8Y+LQ39k1z4gvswi8YuQY+Av81UrURICN14ggZ9dcsO2QR872HXbgVea5THcaX2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gFnYmfb+RAo2Ie95ANYl8VgLTpo9h5UGedHL3a6z24=;
 b=sJbytysyFMkTngQMc28G2YaDiAwOBGJtR/a2OSQyjmnn8MqKTtPaC2XRnJWOTIpSt9vOJq4YzMCH0TVLeS5iBVVYHN9BWUGkyU9el6NST5aMVkERDDlZhB07iZTUgqlPhuQpmctMSS3d39R4INbKRwk01ISKlaLAlIiHJQfKfIM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:06:10 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:06:10 +0000
Message-ID: <a781b35b-a091-00b8-e846-d4ebe7b4a321@oracle.com>
Date: Tue, 23 May 2023 15:35:58 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 01/18] drm/amd/display: improve the message printed when
 loading DC
Content-Language: en-US
To: Tom Chung <chiahsuan.chung@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
 <20230517113723.1757259-2-chiahsuan.chung@amd.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230517113723.1757259-2-chiahsuan.chung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BY5PR10MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 324ef5e9-ee13-4a1b-c796-08db5b75551d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ez05R11Ydk9QN9gsb4vcfm3SjY0e9Lf7Fh90i1ajFFNeZM1U+WYoIIVmXgwA0GCmnH3taKkGLVIbmIYya8Sp90R2S+QeBzR3tHpVXLPEU+EAx5EkTHds6TMKBUrq9ecii3MtbOWqoMeOdAHOseCrbVjFDK6/NO3CYnHZ3eoFhOrIVqJGYBZco4M2yT6Ml1/Lucrg43PvZk3E6x4XaoNMKyXcxBSVGjZ6veWgokpya4ZgesEBrDTWffwmvnX4wCsh46RqB/xp86QNe+JpZXQhM6DkjqHnpIm5pvsKvDL8lB7e9+TWKBocv03PN1LJjmKNuDBKK23S/WWfCyZAIkMdzl1tU6xwajo4CEvqD4H8Fepg2DNhnmlzr1tbUmS1a5PW5O4ReO4Nzv/5tNXWbrk3jEfYkOc3zETc0sSMkZad+t5X0dwvkCmBvAU/JXljWuWFTIWgQfkfamMrJ2XWmWd0EVt9dF3V4P2NOOzDoVH6uuZa/4q/+h7+UEN1oLcGF5lA45rlFNz/gkT89MXswSWrWO708syavrjFtkS9S6w3imNxAhyc8NnR27htqNHk4czTtSNOQgEMy/OpHWk7PPGsuwwqqwHDzdTnlKwjducvmKN0N/ifOpJXV704a2GSAh7y72Z0H9jqxQV6+C/+aL9a9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6290.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6506007)(6512007)(26005)(7416002)(186003)(53546011)(38100700002)(2616005)(36756003)(83380400001)(2906002)(6486002)(41300700001)(316002)(54906003)(6666004)(478600001)(31686004)(66556008)(66476007)(66946007)(31696002)(4326008)(86362001)(8676002)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R25YU3p2Z3ErOTh2cmJoWi9JVVVTMmNKVUNuNFNZaFo2NmxDWlpMdkJiVGdo?=
 =?utf-8?B?cWVGaWhKM05YdnhaNW9TMEJNSmRuSm1XV3h0LzVtOG42emVNUUhBMXZMdzYx?=
 =?utf-8?B?OFg1c0xxcXZvQVJMYzljRk9BNVMxZXpHVkJWek9EQ3dFdlpTbzhYY2tSS3Bn?=
 =?utf-8?B?RG5seXRDbmRjV3QzZDlmcG1uMEE0SjJneDNGRlptNFlGd1c3aEpjb2g4cXVp?=
 =?utf-8?B?c083cnNPWWpHRzNIbWdUd3Eya1YwTTEwa1BmN2g0SHd5VHRNMnoyZ0w3a0Na?=
 =?utf-8?B?cmtPbk5QTXUyMWF6cGdjQ1VjaHVrSkU2UmJ4eXpGRjZOTm50ckVCVCtCS1F3?=
 =?utf-8?B?RnNFUk9aSzVrcXBFb0tmYWxRelpQekZiRWJ3cnM4TUw0ekZUemEya1dNeUFs?=
 =?utf-8?B?T25lcHpjYmdXRjl4WTRtYnFmbDM0aTRBRnNoa0FuMy9VcUl6NmJxOURyLzBk?=
 =?utf-8?B?b0FuM1M4UnpEU0prVjBhOG5CclhXeWlMRyttbk5aT09lUUY5dFYvS2V2QUdK?=
 =?utf-8?B?Y3JsblF1dkZaZlVHWGpsbWZYNStKcHgrNE91Tm55NWFkenFaNnArd2ZWb0Jp?=
 =?utf-8?B?dUlhczkydHl5ZXFvK2RsYTlVK0pIYVZQSW5lOE5JayttcTcyMkIzaVNicmFC?=
 =?utf-8?B?SUVLUjZHNm0zSXd2V3MxaVhEYVFhU25IMWxGbFpEVUZUNGd0T1FJY293SURj?=
 =?utf-8?B?VW96ZnVuaU9ndlVyZ3IrNU9UZFBaZE16Z0ZsL2JFZEFWNWFnNWp5blF3Zkpi?=
 =?utf-8?B?WitUMnYwQVl0czJPUkU5R0NZR2pzanhZYVppOFBMcXZFTExGYnAwODB6MExK?=
 =?utf-8?B?QmVDTlI2c3ROMnQ2dzNvMHpkVEpzZERPb2lsUU1wQXZUZHlHTmxHM2ZvMDdN?=
 =?utf-8?B?NTFlSzZERUJvdW5sTXR1eEpoT3k5eU0vL1dvbU0wZkFYM3BZMmY2UGlXRHpy?=
 =?utf-8?B?d3BoRnVUVTRGczVwL1l1YW9ZbDRnUGNxNTJDb29CeVZWY050OXJnZ1FEN1BS?=
 =?utf-8?B?Nm43TUlseUppMHFjWWpXTlRWSi9YZDlESmRKUnd0MkZhQ0svbGZPYkxZeDh1?=
 =?utf-8?B?YjhPM0RFZnhmclVrMkxPcjJTZWY5N3NwaTNLY2NNYStISzRrVGc5b3N6NDZa?=
 =?utf-8?B?WlVBNitZL05NMUZBUkFGL1lPTkF3WGZ0VHRIZUF3NTlkWDFabjdQeFk2Tmoz?=
 =?utf-8?B?ZzZkakx6VmJHMHpUN1MwWTdVQ3ROc1U2c0dzQk0xUndQamVVcnhxQkRqSlhw?=
 =?utf-8?B?R2pwbDhNSmV1cWlhamFtVW5XQmxkVXZHRjNvR3crS0tkZkwyUmhyeFV5Z2xm?=
 =?utf-8?B?TXhLNFNVNkxHODg5dlZPbGNvOWRiSjVvZGxGczJwcTJBcGhUUGFhb0Y3U1Zs?=
 =?utf-8?B?YzJ1K3V1QWRXVE1paWk2ZllvcEltMlM2N3NiMWtldnVtMm1ramZYZTd3MG5z?=
 =?utf-8?B?KzE2OWdrWGcvM3cxbTFRczQzRllSS0x3Zml3b2JxVk82eHVoZHRjcWduMXA0?=
 =?utf-8?B?WEkvemZObWowTkZsdy95alNEMmZVbU1xdUt4Qzl0RUxGRU1hcDdoWjBhTUVI?=
 =?utf-8?B?LzhBOG9qUmVoYXR6Y2JWTENtc0F2TVMvckdQdk5MRmZKRW8wZWRtQWo2WFAy?=
 =?utf-8?B?OUFOZzhVR3ZRQXprV2hmSUp6RGtVMThoTjBoZFdCa0VaZ2tDVkVIc3FKakhY?=
 =?utf-8?B?QVFNOWlsRkNyOXhIWDNtaFB5eDZ3SytCR3pXVGZzZmZmYUorc3FFMkgvWkk0?=
 =?utf-8?B?RzhCRE4razduWnF2dmIrdWNSRUNIZi93NG5nUkZDKzRHeVlrazBwUmw0YVdp?=
 =?utf-8?B?SXVqRXR0dEpycWhjUHN5K0tadGN1dHh6d1lrL2ZlNzZXbTQ2OVBQOGpGcC9Q?=
 =?utf-8?B?VW9teU5FL1c3TURqSVR5Mmk2WlQ4QVlUR0pHU05TNVNLdDdNMmpCcEFRckNq?=
 =?utf-8?B?U2N5TVQyZ3BxZVdPcFF3TkFzZStzenovcC9WNGUxSDNqVmtGRGowbVdVdktr?=
 =?utf-8?B?VDNNeFBhZVZ5NnFUalRlZzZLRDIvT0Zlc1BkWlVNVzJwd25ocHh5cnkwTjdB?=
 =?utf-8?B?emt1VXZ5cFdhcjlmdFZuais1NnFNd2RpMzNvVUYvRlF2a0pSaDhTeXhpQUl0?=
 =?utf-8?B?RW5LczJHdFF5Y1N3Qk1YQVhuVEovR00xSGl3TC9HNEdnNzRQS1dja2tIdS9y?=
 =?utf-8?Q?xM6XP+uorGfCmuV5SghiUxk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xjkJ+4eyvoGIM9zlwJGX6/6qIsfEW2VXIxwU8/GH/Ra8PUFPsGCW78D+i+VxvcVY1YgesyP2dDA/GvnA0wVtxk26ADtc/7CEu5eg3Bv36ytoKD81YsECibTjruMg9ayzKKbYpe2Qqi17FkD1nF+W786FqdNa6bxCfySMpTAZkLewb/Ju8EyCyLVvumDmE4GkjM2GxO/t4BmKHTxkF+f9BRzFESPBfJXpY8JHJL7gpGhswt+QecWocGkr/3tYhhrwBGpcq2+Wwax6Hbgh/yT8XjgkaNbTT5RuHBICZuVieF4e7kplnJw72qGVoMY9AByUPXRG9dK2LinKpZ2E1UXRHmHW8MIkwguvlo07uNfdX9qPxzxWyKDXwyX/sHZnp/sQRZKpFzqdjmfK+triVOknumVnjhEZ/KNqK7lPMfdehocExM0vBiyN5djSAAQgvW9g9co1zEa7jfSbRsaXfFO3/7xn8v9twev3K6oOoVmt2nzoQNnCvcjz6VfYlwqlVd/QsuPZ5RwJT2w6pOS7OVAxYrUHDWGTXkBp00LYOLpLn2InYhYvmx5drFaaD+7GOBxqnKndrfv/RPfTFbXHr7CB41ePiTKCpKzqai6kE35sP088iaXrQX6BxeInJLiHIuQEVRLyh3Ckz2EF30tunfX9a6GVPDpEmwIFKsfVNxOl4qJoGzMVX5rO81SJ827wz5rUoBQ9KfhUKxYUQZmAHCYVEYawTPhTpOpf2mCHxSIk7nu0yOdcNqsG6mWmrAZ6hDz7IsZ4DQt5iSLoY0STQd/qyP+Oezeyek70P9kmKnl7z9HyMWPvxqD5uIBdEqDekZPgrJTNkj8MCWQsaPcQxqfx5V39D8XUI/MeJH4u+WGDmkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324ef5e9-ee13-4a1b-c796-08db5b75551d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:06:10.3460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoIL5C0Lw55elThTPgRE7OvbL6mClv1xFKLFi9kh2LieFp051ClEYQWzi7DxundmTWWY3Tq22E5HV2RO8KMyB1do6XBpOvm3x1mFksMaYpizgZIvuYFv+YydupE60rO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: tGruYv4RnrNiy7pLsn1nDFmtz3vFkgsQ
X-Proofpoint-ORIG-GUID: tGruYv4RnrNiy7pLsn1nDFmtz3vFkgsQ
X-Mailman-Approved-At: Tue, 23 May 2023 12:55:28 +0000
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
Cc: stylon.wang@amd.com, Dan Carpenter <error27@gmail.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, wayne.lin@amd.com,
 Harry Wentland <harry.wentland@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 17/05/23 5:07 pm, Tom Chung wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> [Why&How]
> Change how DC version and hardware version is printed when driver is
> loaded.
> 
> - Remove exclamation
> - Add DC version and hardware version to both success and failure cases
> - Add version in between appropriate filler words to make a complete
>    statement.
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Acked-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 14b296e1d0f6..45b778631430 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1666,10 +1666,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	adev->dm.dc = dc_create(&init_data);
>   
>   	if (adev->dm.dc) {

	// Check for NULL
> -		DRM_INFO("Display Core initialized with v%s! %s\n", DC_VER,
> +		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
>   			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
>   	} else {
	// adev->dm.dc is NULL here

> -		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
> +		DRM_INFO("Display Core v%s failed to initialize on %s\n", DC_VER,
> +			 dce_version_to_string(adev->dm.dc->ctx->dce_version));						       ^^^^NULL deref bug here.

I found this using static analysis with smatch.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1673 
amdgpu_dm_init() error: we previously assumed 'adev->dm.dc' could be 
null (see line 1669)

If you fix this could you please consider adding:

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
														
					
>   		goto error;
>   	}
>   
