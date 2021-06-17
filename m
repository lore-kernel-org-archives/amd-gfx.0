Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14713C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EFE60BBB
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EFE60BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2D86E1ED;
	Thu, 17 Jun 2021 19:04:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDCC6E1ED;
 Thu, 17 Jun 2021 19:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2EqVqqX0IbeTKjBFhgMSw39JtDjXMBm2DVawWxb9B6tsNoi7pLhogpVGd9Z7WcgJ8vHPdenbwmsaXyyZnWJrd5ESUWY6Vml9AHKf8li0S8X2sfDb6Oo0RQxtJRBiqkTKzukfCxKAIJo4ihQ45GaOWGKqFdsRYPwYtUy99C11pP9Bx8MFaHzVRtK7CLtlYxfMNEiWoIKP1IKpD0yEpelOzWM61MJTLMtXSwoerXXkRgxzxO1ZidvxTIoCvjhDmOhFZel56lUXdbUKqlC2Y0VO1wOt4dVgcS0kIE5rt849q8IxsJ7VEU4XCzFHYAc59GYQjxcDw/ICgR5uxWQBunrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8Kb/4XtNIVDB88Egw+qJJFrE4Fk73/8moR8CjTK5G8=;
 b=lCceHpmlGAAXSDDRDdDTtnE2jihZeCvPhV50bh6HPbSgT39Qy8GzXWJy6DNMm/DfJuxTW6Ma/zUbJO48a4G5kULOaMThs8PRXI3Mx7eewtHeDGPMjfHOO7q8e9IssS4atbAwzVKTMcvfMtIRVmRR6srJS1Y6vppyzNkMHnsxWbD5a1wNXayaJsApvprFzsR8IrW7snWKcxuHfxm6zBaWGqhTjLB4m2pMLR+5jrGp9dyD0VUsJ6VXrdc3bCyjuirNJn4m803aDTPpe+han/49qTZ+Tg4wS58O4Zpfw2EHGk2IBn2jf1ZfN2Uq5NUnxUFs5UNreKNJJfs6c+sANb/CLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8Kb/4XtNIVDB88Egw+qJJFrE4Fk73/8moR8CjTK5G8=;
 b=N5rK+OAKS2WaWms6c/T7nK7716MS0BfbuaRgeRphNeOwjB0fvhnyQUR9+Y5AmUWklWMkZqKM+AGWCv3MQFJo2/uWalIh6dmT1/D8hUq3qk6KlaNcXY4NRGb2txTnILopCFcFHthMOQfIdHrUXXGlLibcl5gjcrsJg4Filxvy2fs=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 19:04:30 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 19:04:30 +0000
Subject: Re: [PATCH -next] drm/amd/display: remove unused variable 'dc'
To: Pu Lehui <pulehui@huawei.com>, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, Anson.Jacob@amd.com,
 Nicholas.Kazlauskas@amd.com, roman.li@amd.com
References: <20210617011632.187690-1-pulehui@huawei.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <7758a4ef-0b8e-8873-fac0-7db7a2f6402b@amd.com>
Date: Thu, 17 Jun 2021 15:04:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210617011632.187690-1-pulehui@huawei.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR0101CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 19:04:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30254615-3f64-4439-588c-08d931c2bbe2
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54100914F4A1BDA3E92294328C0E9@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Mkd7MeD2IIPiBHfpRA8WaSlyh78SJTbLRGVfsJA5Qlb/nZVGy4bU6DpQ+biKCdGuU8Q6Oks/uV54ICQ4KJxZc0GadIDbEBvZfm08P5WWCkctzDy1KM+7Usw2qIkxACoCV1fmSWZVBBVjoRpEYS3gqlP1XZ21f/OpHfCD9gLoGN8UCobQNs+IXDJwtX55RpLviHKapgUhUdj09xgpOrXlNGSgOG2laQymKKhNY5kJqlxIL6IVUH5fbHA2TbMdE427pKsFG6RBi49rzLXBXzB0vKF/2WrXKjYeOWaGRJHLWadpbLhFX2E5VJBan+qyeZbPLBjzwXr9SuBd4LKc1VkuImbOxwVrrEuxKYy1+1UyEHnbY/VjIC1FtcysxAh1ESmfjNFHhJotu8iz+xgUbVU+UkDyGfsltcosdMP0sWY0UKKvG0C78X7BHGfvJXxFiW4OXiflO/iLhmgCNMoWHbxepXbMPUhSSVyWCxrX/8VD7VeJyqSELNlD7UdLeUrh9DRPJyZ0WjSA/HUoImElhus1O8Vg+ACFeeE93n816+AfqtGedMb6CHMN9CxxN4WMvjvTJ3dHk/Ldwx+soK4x8jE6Xa4pKM6tbeijmInfEVRJ4lrGftEhx3H1hdxCeyvr+09Q9+Zx/JYA2XTK1q8bl6BjCgpjW7uzZWCf4jtsGvhZiBsvsiKmUNtSE3M1sTYiHUdpRNxc93ObsZzNV+2woPdIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(956004)(2906002)(6636002)(478600001)(316002)(86362001)(83380400001)(44832011)(36756003)(186003)(5660300002)(2616005)(6666004)(8936002)(8676002)(4326008)(26005)(16576012)(16526019)(31686004)(31696002)(66946007)(66476007)(66556008)(38100700002)(6486002)(53546011)(921005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykt1c3NaaXFncEswQ3hNWEtSTkxYQnNCZ1Y1bWM5YTFjY0NicFZhUHlNQUQz?=
 =?utf-8?B?U2gxMzZ5YkNGT012aTJ3NDc5YVB0RjRXTVJiVkZEVjI2bU1BbVhndG9ydGVE?=
 =?utf-8?B?UUZBZElYTGRtUkk2YzlwVmZkTUMxTDZVNXdXYWFhakVaRWJPOVRwak5aZTFl?=
 =?utf-8?B?SlpDd25oMnlKcWJod1BTLzZHeG56MmNJOTdhU0lZTmhhbXVRV3pxVDhhOGpp?=
 =?utf-8?B?YitjMHhFVFJPTzlyS2RJaGcyUUNRcy9LSGN5c1FDOGx3bmE0ZTkxdDQrVGls?=
 =?utf-8?B?S1lkUTN1Z1dBb0E1S3ByMUtoSzJTblZSemt0ZGhqbjdMTFVIRHlkcmg5Y1Rm?=
 =?utf-8?B?MlVKZE8wVVlic2JxTVhyWDFTWmRtRy83VStsSnI3YmlOTXBob3BaMEVZb0g0?=
 =?utf-8?B?cStXRG8vTlFrdUwwUGFoWkhldDB6dnpsOUVxLy9oZUhFQjFtbUR2eTgram9R?=
 =?utf-8?B?VFlXZnFmSjA2NEJKVUxON3FCaWV1eERyd0w4S3pZRVpHUHp0VGd1M0gxUFA3?=
 =?utf-8?B?SENIZlFvME1oZWFTczNwWitEUllXbHltZXJIRG5tcXVidDlMOVplMmpTWmtE?=
 =?utf-8?B?S2ZxdE9BRjVPamdLVW13OEo4YjhxWG1oMHhhOEdlYUpvL0VWdS9BRFBZVklT?=
 =?utf-8?B?bnEvVkdhK3AzWGtsa05pMElqYmVtU3RVNHJ5L0VVcXpvWU9MUVJpL1B5WUEx?=
 =?utf-8?B?eGNoWCt5R0J4YU12N0tMWGVZVTc5RnhSVThYcStkVE9GY2M2SzVqY3FhQ2F2?=
 =?utf-8?B?bndoN2w5UzNYMnh5WlBGVmpVQUZ4VGZQN0Y2VkxESFFVSW1rcHpobnpReVlH?=
 =?utf-8?B?SHJORUlGUDJMWTZhaWtwVEVodTkvQnRYWFZNNTlxTWRkaGRFMXVGcWdiWVFS?=
 =?utf-8?B?bFZuSGhwcU1qTE1sT3VpWXI2Uit2d3prV0gyQVRjS0ZmSGVVSURQTmNieFlR?=
 =?utf-8?B?OHcrTUVoUnA5NFZ5a1k2MjRZNWtJVG1LRjBtaGZSTUQwNlM5NzdjNzJCT3g0?=
 =?utf-8?B?Z1g5ZGpic1hSNmVQaWhTK0xmd05zUGJBMitQZmJ1Nm51b3BFVnZYM0pSUTlL?=
 =?utf-8?B?emJ3cGo3OG9Ta0ZpRVhLYW4vaDU1Sno1TCticGNwNXlZZ1h3UENDY0lBMm9L?=
 =?utf-8?B?dEdmK2l5b0JjSUZuY2tRSHg5Y0ZBWVUxQS9PbzREY0d6b2ZYVGdlVWJkZi9R?=
 =?utf-8?B?WE1Rd2FGdytkS2NNYXNueTZZbnhESHhSYjY5VzkzS1haanVzU2d1V1BkSjly?=
 =?utf-8?B?bVlhbFBjRTV4L0ZkYTZsV3Q2VGM1a05CY2tLd2pEbFVDalZjS2JlRFYwSjlR?=
 =?utf-8?B?WktLMGsxQ2F2SHZJL0NEQUozLzg5S2xUMW5KWTZKRU00emNlVHFhMDE2RmJs?=
 =?utf-8?B?bWs0c1ovSStiMytlWVdvcStsRno4Wm9FQy8zU1c1UnlSS3Y5RitvbkR4bmNt?=
 =?utf-8?B?bnUyRWFZbnVqNWNNc1lPOVE3aFQvNUpRQ2JYeXhmK1ZUS0pRYlBqc1drTTZv?=
 =?utf-8?B?VGsrVU1vOEtuYlRXdjNlUXErdzFNM1NIcUdRcGEvb2RBV3dGYXRLa28rYUxw?=
 =?utf-8?B?SklvdVU0Yzh6YUlJbThiM3Vnb0xwcFdpUkNvN01XbGdyalRnTVJUTmNOTmVF?=
 =?utf-8?B?RVl1N1B4MWw2Y0RkNDhvTDkzRkJPbVc5Yi9JcUNVZDVQS0txck1VdEEzY1Y1?=
 =?utf-8?B?M3gzZkdVNVp0elFteXlUdC9vWVdZUXB3VnBlQUNiSldQQmhDcWU5RjN3Y2Jn?=
 =?utf-8?Q?mccwaVnSN57b/GAELGtfja2+4JBLZnTYuBgUwdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30254615-3f64-4439-588c-08d931c2bbe2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:04:29.9964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVPQ/p0UVb1AeqgcLHVAITRypeKDYUntKHCCF4bfAAukaYF9t9liGJDPUXhFzH4mAqaRPAp34uyxUUdFufhhDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: zhangjinhao2@huawei.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA2LTE2IDk6MTYgcC5tLiwgUHUgTGVodWkgd3JvdGU6Cj4gR0NDIHJlcG9ydHMg
dGhlIGZvbGxvd2luZyB3YXJuaW5nIHdpdGggVz0xOgo+IAo+IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wc3IuYzo3MDoxMzoKPiB3YXJu
aW5nOgo+ICB2YXJpYWJsZSDigJhkY+KAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQt
c2V0LXZhcmlhYmxlXQo+ICAgICA3MCB8ICBzdHJ1Y3QgZGMgKmRjID0gTlVMTDsKPiAgICAgICAg
fCAgICAgICAgICAgICBefgo+IAo+IFRoaXMgdmFyaWFibGUgaXMgbm90IHVzZWQgaW4gZnVuY3Rp
b24sIHRoaXMgY29tbWl0IHJlbW92ZSBpdCB0bwo+IGZpeCB0aGUgd2FybmluZy4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBQdSBMZWh1aSA8cHVsZWh1aUBodWF3ZWkuY29tPgoKUmV2aWV3ZWQtYnk6IEhh
cnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Bzci5jIHwgMiAt
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHNyLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wc3IuYwo+IGluZGV4
IGY3Yzc3YWUwZDk2NS4uNzBhNTU0ZjFlNzI1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Bzci5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHNyLmMKPiBAQCAtNjcsMTQg
KzY3LDEyIEBAIGJvb2wgYW1kZ3B1X2RtX2xpbmtfc2V0dXBfcHNyKHN0cnVjdCBkY19zdHJlYW1f
c3RhdGUgKnN0cmVhbSkKPiAgCXN0cnVjdCBkY19saW5rICpsaW5rID0gTlVMTDsKPiAgCXN0cnVj
dCBwc3JfY29uZmlnIHBzcl9jb25maWcgPSB7MH07Cj4gIAlzdHJ1Y3QgcHNyX2NvbnRleHQgcHNy
X2NvbnRleHQgPSB7MH07Cj4gLQlzdHJ1Y3QgZGMgKmRjID0gTlVMTDsKPiAgCWJvb2wgcmV0ID0g
ZmFsc2U7Cj4gIAo+ICAJaWYgKHN0cmVhbSA9PSBOVUxMKQo+ICAJCXJldHVybiBmYWxzZTsKPiAg
Cj4gIAlsaW5rID0gc3RyZWFtLT5saW5rOwo+IC0JZGMgPSBsaW5rLT5jdHgtPmRjOwo+ICAKPiAg
CXBzcl9jb25maWcucHNyX3ZlcnNpb24gPSBsaW5rLT5kcGNkX2NhcHMucHNyX2NhcHMucHNyX3Zl
cnNpb247Cj4gIAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
