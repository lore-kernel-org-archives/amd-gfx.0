Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E04C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 10:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C261E6134F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 10:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C261E6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EE66EB6D;
	Wed, 12 May 2021 10:21:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEF36EB6A;
 Wed, 12 May 2021 10:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVpux50tocCVsqUy62YLymme2IpMI8tley5rxbsUc70CAWBeq6SpaX292gffcz+tD7MIb+Gpmx5djkZVtzPEbyI1Y0GtuoIup2im0A9MuB+vhRLvlspoO+L7DOPV5tqqYIIzpGoFjk8ekWanUKGOKWu3HbzzK24udGjiL0Y4dbHJRv7KEP6MDX+c12Txz2Uj856XeUdoD/+rBYKgUhEaZao6bsYNcItw0grgFn9+8bhINSp3co7vvHILzXrfe5InQlHvAGieLcsUEcNyWJvf4pu5aJCBUa9Hgss7ycSsZSqImS6hTRidk1B2u5C/Ev5zTw3zciVHd4/6A7ejzKrjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ81k1dGfwvt/BH83iWoUd8+mIkypbPvj2OGyk0RtAA=;
 b=HjjryX0VgUoEs7PYG2lM4X0Gk7XmFx3DrvIIKkuIi+3YK0W5fc53bokCBVmZKaz5CROolKCzh9YLfUB0YpfsTD5q/2ZG1j4fQOp8T3Y7FISYXRVSXyTnexai4TdcOLlOoxnGz9rT63C2VcGe4/vohnQKUZugRdHTd8djwF2fOpUEl2PZhNFWBLfaE7Bhch1ZQ1jvBU9o0smFRQuFhW/y9jJsMBg3PXuGzXiYx+jZU8ipmJLPMjdd5OVnB8KmwiYs/iluxUrIXlBiGR5aStWH0pP7TPZEAsbte7UUSyBsHkAdZpadBU30e4GUwCy720tztfHuEo7GzeS5FuG2EbzUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ81k1dGfwvt/BH83iWoUd8+mIkypbPvj2OGyk0RtAA=;
 b=rWlcfuOQ9gNztDicJkK8saDTSwR2zJRDBczaIRdZOm2m3jyaam+6uRxqDILxvXAx9/W9W+FIBMcMLK+VN777ZENyXs4kuGbzi0BG6nnFtSlyNAHgaT33Bb8Ga7rSUv/N4f8acZoFGU1Ks+pKvU+P1ow9tNnVgkK/lmRKtqNgHcw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 10:21:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 10:21:02 +0000
Subject: Re: [5.12 regression] ttm->pages NULL dereference with radeon driver
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, arvin.kebob@gmail.com, mail@dennisfoster.us
References: <s5ho8dmh98p.wl-tiwai@suse.de>
 <aa54b1d7-1d3c-4c77-37db-d6c93b8c794c@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <72fd6a34-89d6-f46c-36ba-5b006dd47019@amd.com>
Date: Wed, 12 May 2021 12:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <aa54b1d7-1d3c-4c77-37db-d6c93b8c794c@gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:bc39:4e06:ac5e:2e31]
X-ClientProxiedBy: PR0P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:bc39:4e06:ac5e:2e31]
 (2a02:908:1252:fb60:bc39:4e06:ac5e:2e31) by
 PR0P264CA0191.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 10:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d08f38-30c4-48cb-ec7c-08d9152fa4d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41922F7E819458E87F4C5D8183529@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LmsKaq67Eb02hdvK4qMHkG2D/0uR3eAyecdjZ7T1z5bsEvjWs3fb+91sFl9jHQM+ZpPyN7XANm3lF1m82GeCojcuY4p8NRmAAWv88vzHQe6p/v7CTx05cZvhl26kahrxM29W4G/vUvcX92uUqt3CNFUBRvsB/D7Og3/9y3VHPgybwcEK23KMEPsSJlLIsFS+TZeq5jBuE41M0M63wqT2HcGjRKOWrMNdwsTjJQ9TNJrjPAarY0HCVLOznrp1G/Kwf+39UEghWT2WwTS6vakzPDIvrDU7uD2R7CY7bFcTZ4mqImmq3qM8A53KRuUpRBDqiD6/gycFw6RvCPwPqdahCgLN4/NTA0EGLzfPaDkfB6Sfv4bKbvUkvToe1AKDDG7KzENRXGtGZxAnI9k6yWtNHFwnUnbzOuotD0WDUyReNtn7xdlTiM0/onp+/UiemtYzq65d5ebMG5oI55AwFnXuPpj2WljK2rnSrSOO/jE4aRyKaIcXSIJ1Z8Sw4VPtwUIcjZgDXR/rEd7ITT44fQ5HsSoodmTAs5g2ikhZZ5W08gs4EfwSu3YyF0Znhxk3IRfuwChvBjr4ftwvMZF7Rcx2aYr9Y26DZokE0uZJobA3ezG1YsYNPOkbqXh1/yuV/wXE4RZxxW2GndIy+U39i+NlMKas8X1yAyb+CMY+L23zwNY6UwGw0plOxqukylCXbCRa7JkantH3jB1enCHPAGwNB8M3emTjrcZzNl4n6NbJmEdx2RYN4pPQM8uhBx3AXykQ5+w7RJz90xpGT69rtKRHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(8936002)(52116002)(66946007)(83380400001)(110136005)(45080400002)(5660300002)(66574015)(31686004)(8676002)(16526019)(186003)(2616005)(316002)(4326008)(36756003)(6486002)(478600001)(86362001)(38100700002)(2906002)(966005)(66556008)(31696002)(6666004)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFdnb0JhYmVMN1JzL3krM1lTcUYyUC9EVHF2ODVtbDNJQ0ZHK0szMTBoYmJP?=
 =?utf-8?B?dklXQktrakRzZTJmMjI3c0lXREx4bm12amlURVpBZ1YyQTJGdTNEMzdoK05B?=
 =?utf-8?B?SkNiM1BPRVl1ZVpudU5LOE5IWEFlYnB3dHdqZlpyK3BlUXpubzhFRnN0VmZ6?=
 =?utf-8?B?MWYxbUhWTWIrTzZjWjhYRjJCa3JKYTFoc0NIVW9GVjkwY05NQ2FDRW9VOFV2?=
 =?utf-8?B?WVdMQTVlQnZpbHMxTGJQWG9YM1NmSlBSdXpSVGlaNzFLN2VkVlJvY1FmNzJN?=
 =?utf-8?B?SXpwc2V6OXFrM3hscWJyWTJyb2czR2I5U0VaWS96bFNMWms5QnBydmk2MzdU?=
 =?utf-8?B?eURMZnJxNkJJSERkS096SWRqb2FVbnZhMjV5ZWRqMzFacUpiNGJhMllPZkVk?=
 =?utf-8?B?a0QxMUdtMjhWQzloZlg1SmkrdXVSVEtPTkhJRDJGRURkNEZRNVZYd000ZjFJ?=
 =?utf-8?B?aHJMblVnUm1MdjJ3V25aVDgvbUxaSG4rOFphVjlGZlg2QmFiNVNhaHVrbGNI?=
 =?utf-8?B?LzhGeXkvY3dpd0N3djVyd25aNGJXSTZuSTA5aGozeG5PQUREUkQvSFdzVks5?=
 =?utf-8?B?NnlwNERhVXZPZVhuTUhtaGRVZ21sL1dNRE04bnhNREV0OVB1VHJFTmJ1M2F4?=
 =?utf-8?B?V2lHdDhhQUp4aDBwMno3bjRvZTRpaTV0Vm5yTDJ5T3N1alIxd3ZObVpiTDRo?=
 =?utf-8?B?RlptRzJseHhBdmI5ODhtWmJXcjdMOWdiaGxwakRGTDdSVGVPK25kS0VHcXZW?=
 =?utf-8?B?Y3QrZVhtbHMrVTd6VzQ3clpCRW00NitUSW5JZk5aZDN5Wk1pc0c4Snphd1BE?=
 =?utf-8?B?N3FUVmpSWHVSZy96bnNOZ0FKNHJCay9LZStVNkZqN3pkbFp3UHB6Q3R1ZDZq?=
 =?utf-8?B?cnJhYWk2MERRK2N1blpPZ1kwNHhDeTkvZnJDYjJIaS84NHZNcWNtblFnWVRi?=
 =?utf-8?B?V3NLbUxERVNMWFh0Z1dXYVJNY2JWK3EzY1NkNVVhQ096NlhIT1dTclRabEo1?=
 =?utf-8?B?Yk9iR1FXZFRWYWlCMHdHSENyMThlZDNzSDBpYzY2TzV1dldVc1U5U3EvZ1RE?=
 =?utf-8?B?UkhGc3dEMTZ4YmtlRm9BNTMvb3RoUWtMRCtxL2RjWExlL1NYWEJxSW9RYkNW?=
 =?utf-8?B?MXFnSDFWTThLTjlRbGcvSExGNitkaGJ3Z3NzQU5oWG05UzdBL1c5Sy90MFZ6?=
 =?utf-8?B?NDhTTStVZ24yOGd5cHpSa3RVRmN0bEZmdnQ1d0dWTjcxZkIrMVJVUm9odVVR?=
 =?utf-8?B?SEhUTGpuL2F0ZUpHTm16WmtqdlkwYkF2WnZ6NkhRRE5HR01pdWtIaTVBREZR?=
 =?utf-8?B?RXg5RWwvRGQyWURTNTR1L25IaXA3MDYwbHVpaCtnRkxlcFd1QVUvTFU0aDc4?=
 =?utf-8?B?L2tEcmdsVW1zRHR5WTFoS0V6ak9TRGxsc0tPUkZiZ1NXRUxXd2YrVEE2NkFV?=
 =?utf-8?B?UXhtL0w4b2RqUUZWbG51MXZYS3N5K0V4VEp2dkRmUnI3a2w3bmJwZ0JIcXBI?=
 =?utf-8?B?bXhkQmZCd2daMm8xWDRYZ3hFSnhJUStadk5PN0tMbzI5cWhMWG03MzlibklP?=
 =?utf-8?B?YnFlZ2dtUVlFc2dDWW1HYVNQa0g2T0pwV282NDhqbkZ0MXFYRS9wREtkbnNk?=
 =?utf-8?B?cFZUdlgzbXlhanJLWkp0RHByc2UybDFMR05SNmh4c3ZtRk9CWVgyY0w2SERE?=
 =?utf-8?B?YWt6ZW9MZ2UySnZPcWhSZWx2emFob2lZcDhPV1gyOWsyUEtNUzZLVnFlQUM4?=
 =?utf-8?B?RlBmZUtXV3BPV29VQmdyL1Azay9ab096VHR2WVlJVXp5RmxrQW5xN255UnR6?=
 =?utf-8?B?NUNVem5tNHdzdFA5dExvdGo2WTdJTm9vM1hCT0NMWTI4ejMyUllQZ1FZamFm?=
 =?utf-8?Q?tuIf6ntiT2qdk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d08f38-30c4-48cb-ec7c-08d9152fa4d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 10:21:02.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSo9wngroewNXFH6JSieHRO88WMeinqayE/mpFuSlPH/MFQwH3qj+9OvLMKNHF+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgZ3V5cywKCmFkZGluZyBhIGZldyBwZW9wbGUgd2hvIHJhbiBpbnRvIHRoZSBwcm9ibGVtIGFz
IHdlbGwgYW5kIG9wZW5lZCBhIGtlcm5lbCAKYnVnLgoKQW0gMDcuMDUuMjEgdW0gMTc6MTEgc2No
cmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEhpIFRha2FzaGksCj4KPiBBbSAwNy4wNS4yMSB1bSAx
NzowOCBzY2hyaWViIFRha2FzaGkgSXdhaToKPj4gSGksCj4+Cj4+IHdlJ3ZlIHJlY2VpdmVkIGEg
cmVncmVzc2lvbiByZXBvcnQgc2hvd2luZyBOVUxMIGRlcmVmZXJlbmNlIE9vcHMgd2l0aAo+PiBy
YWRlb24gZHJpdmVyIG9uIDUuMTIga2VybmVsOgo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZidWd6aWxsYS5vcGVuc3Vz
ZS5vcmclMkZzaG93X2J1Zy5jZ2klM0ZpZCUzRDExODU1MTYmYW1wO2RhdGE9MDQlN0MwMSU3Q2No
cmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDNjQ0NDdlOWU5NzYwNGFhZjExNzAwOGQ5MTE2YTc0
MmElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTU5OTcx
MTgxMTg3MTc4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3Nk
YXRhPTFMSk1MeHV1TWprZmduSXQlMkI1WjVuMTlyaSUyQk1UTE1RdkVFQiUyRiUyRmQ2U1ZrZyUz
RCZhbXA7cmVzZXJ2ZWQ9MAo+Pgo+PiBJdCB0dXJuZWQgb3V0IHRoYXQgdGhlIHJlY2VudCBUVE0g
Y2xlYW51cCAvIHJlZmFjdG9yaW5nIHZpYSBjb21taXQKPj4gMDU3NWZmM2QzM2NkICgiZHJtL3Jh
ZGVvbjogc3RvcCB1c2luZyBwYWdlcyB3aXRoCj4+IGRybV9wcmltZV9zZ190b19wYWdlX2FkZHJf
YXJyYXlzIHYyIikgaXMgdGhlIGN1bHByaXQuwqAgT24gNS4xMiBrZXJuZWwsCj4+IHR0bS0+cGFn
ZXMgaXMgbm8gbG9uZ2VyIGFsbG9jYXRlZCAvIHNldCB1cCwgd2hpbGUgdGhlIHJhZGVvbiBkcml2
ZXIKPj4gc3RpbGwgaGFzIGEgZmV3IHBsYWNlcyBhc3N1bWluZyB0aGUgdmFsaWQgdHRtLT5wYWdl
cywgYW5kIGZvciB0aGUKPj4gcmVwb3J0ZXIgKHJ1bm5pbmcgdGhlIG1vZGVzZXR0aWcgZHJpdmVy
KSwgcmFkZW9uX2dhcnRfYmluZCgpIGhpdHMgdGhlCj4+IHByb2JsZW0uCj4+Cj4+IEEgaGFja2lz
aCBwYXRjaCBiZWxvdyB3YXMgY29uZmlybWVkIHRvIHdvcmssIGF0IGxlYXN0LCBidXQgb2J2aW91
c2x5Cj4+IHdlIG5lZWQgYSBwcm9wZXIgZml4Lgo+Pgo+PiBDb3VsZCB5b3UgdGFrZSBhIGxvb2sg
YXQgaXQ/Cj4KPiBJZiB0aGF0J3MgYWxsIHRoZW4gdGhhdCBsb29rcyB0cml2aWFsIHRvIG1lLgo+
Cj4gR29pbmcgdG8gcHJvdmlkZSBhIHBhdGNoIG9uIE1vbmRheS4KClNvcnJ5LCB3YXMgYSBidXN5
IHN0YXJ0IGludG8gdGhlIHdlZWsuIEkndmUganVzdCBzZW5kIGEgcGF0Y2ggd2hpY2ggCnNob3Vs
ZCBhZGRyZXNzIHRoZSBpc3N1ZSB0byB5b3UgYW5kIHRoZSBtYWlsaW5nIGxpc3QuCgpQbGVhc2Ug
dGVzdCBzaW5jZSBJIGNhbid0IHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBsb2NhbGx5LgoKVGhhbmtz
LApDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzIGZvciB0aGUgbm90aWNlLAo+IENocmlzdGlhbi4KPgo+
Pgo+Pgo+PiB0aGFua3MsCj4+Cj4+IFRha2FzaGkKPj4KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fZ2FydC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2dhcnQuYwo+PiBAQCAtMjUzLDcgKzI1Myw3IEBAIHZvaWQgcmFkZW9uX2dhcnRfdW5iaW5k
KHN0cnVjdCByYWRlb25fZGUKPj4gwqDCoMKgwqDCoCB0ID0gb2Zmc2V0IC8gUkFERU9OX0dQVV9Q
QUdFX1NJWkU7Cj4+IMKgwqDCoMKgwqAgcCA9IHQgLyAoUEFHRV9TSVpFIC8gUkFERU9OX0dQVV9Q
QUdFX1NJWkUpOwo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBwYWdlczsgaSsrLCBwKysp
IHsKPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyZGV2LT5nYXJ0LnBhZ2VzW3BdKSB7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoMSAvKnJkZXYtPmdhcnQucGFnZXNbcF0qLykgewo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZGV2LT5nYXJ0LnBhZ2VzW3BdID0gTlVMTDsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZm9yIChqID0gMDsgaiA8IChQQUdFX1NJWkUgLyBSQURFT05fR1BV
X1BBR0VfU0laRSk7IAo+PiBqKyssIHQrKykgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJkZXYtPmdhcnQucGFnZXNfZW50cnlbdF0gPSByZGV2LT5kdW1teV9wYWdlLmVu
dHJ5Owo+PiBAQCAtMzAxLDcgKzMwMSw3IEBAIGludCByYWRlb25fZ2FydF9iaW5kKHN0cnVjdCBy
YWRlb25fZGV2aWMKPj4gwqDCoMKgwqDCoCBwID0gdCAvIChQQUdFX1NJWkUgLyBSQURFT05fR1BV
X1BBR0VfU0laRSk7Cj4+IMKgIMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHBhZ2VzOyBpKyss
IHArKykgewo+PiAtwqDCoMKgwqDCoMKgwqAgcmRldi0+Z2FydC5wYWdlc1twXSA9IHBhZ2VsaXN0
W2ldOwo+PiArwqDCoMKgwqDCoMKgwqAgLyogcmRldi0+Z2FydC5wYWdlc1twXSA9IHBhZ2VsaXN0
W2ldOyAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZV9iYXNlID0gZG1hX2FkZHJbaV07Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGogPSAwOyBqIDwgKFBBR0VfU0laRSAvIFJBREVPTl9H
UFVfUEFHRV9TSVpFKTsgaisrLCAKPj4gdCsrKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBhZ2VfZW50cnkgPSByYWRlb25fZ2FydF9nZXRfcGFnZV9lbnRyeShwYWdlX2Jhc2UsIGZs
YWdzKTsKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPj4gQEAgLTM2MCw2ICszNjAs
OCBAQCBzdGF0aWMgaW50IHJhZGVvbl90dG1fdHRfcGluX3VzZXJwdHIoc3RyCj4+IMKgIMKgwqDC
oMKgwqAgaWYgKGN1cnJlbnQtPm1tICE9IGd0dC0+dXNlcm1tKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FUEVSTTsKPj4gK8KgwqDCoCBpZiAoIXR0bS0+cGFnZXMpCj4+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVQRVJNOwo+PiDCoCDCoMKgwqDCoMKgIGlmIChndHQtPnVzZXJmbGFn
cyAmIFJBREVPTl9HRU1fVVNFUlBUUl9BTk9OT05MWSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogY2hlY2sgdGhhdCB3ZSBvbmx5IHBpbiBkb3duIGFub255bW91cyBtZW1vcnkKPj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlz
dHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0
YT0wNCU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0M2NDQ0N2U5ZTk3NjA0YWFm
MTE3MDA4ZDkxMTZhNzQyYSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2Mzc1NTk5NzExODExODcxNzglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMTAwMCZhbXA7c2RhdGE9UmR6R3AxRkx4QktFJTJCeVBjbHJVQmZRb21SVTBwUVQlMkY3OEV3
Y2olMkZCWjczZyUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
