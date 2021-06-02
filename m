Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74598C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2DD61369
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2DD61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27F86E08A;
	Wed,  2 Jun 2021 14:46:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52586E08A;
 Wed,  2 Jun 2021 14:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhrbHEusELjc5eua7DuWVGyKeLKwAl++ypCpXada9OquYZUUH/cCh+nqDGU/u9R8X3Z75OoqLTaNOf1hfgrmP7Q3TylIk5FQfMjkVWlmZI1RomLtoXjMGpCuGsiMwlibAeqPn9rZg22T1FJJX/Dr/TdT50ycqQXp0SMLTXvnD/iWGz4dMrCDAzYvGKfnIAa6bO+LhSiK/0rE9LWLBynRGwD8LJ8chkKmD8Xw9oTScuwQRU+5f32lRlvhOyI9bVS8O3+5BcYl0Ot56br6UISzv0vKTnCRF3uOWy6SBHbIq/ren4JHVq+L9H05SNrNlfcv5vjcrkN66+3+EZgLzSf0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkVjyZycQAzy3DcttIDxhi0b4z3JKNqMY3HJLE8BMgc=;
 b=e7DBVQepsONIIIn6jt/NfUabRQBOWrcqppB+qSIogZCx8AaZPaqTWMcnfh/ayoj44gtXYzkyD65BmsIYJngun74IcuDAUjiUfSoODvaxtfVxHbEIN3w+fZSyL+XeqLbZA+xPSeg1Uh6lcMMyXMmkZmYwICqJ9mTt2D447ICeWq9U2FQ9Io0J9zoMCg9zLUUUFqoI9njY/lI4XFK7LvJBO7CZe9mig1EbMfXpYj+7uI3RmucI9F+uoh6FX88o3D8OueaI7yGmlnrrXfMjAwJU4rDw9TAWbJ1Tp6jnJpx1kzWOi+F9Zlyja7Rb4LMkPZyld2V693Yw7zv738cMdIyLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkVjyZycQAzy3DcttIDxhi0b4z3JKNqMY3HJLE8BMgc=;
 b=ZaRmiYZQwFWUk1jdyUov6aKtspVii4mfVKcDQ0ANUCmM74yrmY3bCT3OvEZy8zIfDSUMCm3U6opCNTDFK266FcBPpv063rMVjn/U77pn5TOJpaukFlx0wqtktswciVrJRJjL8VJpx+EEdJ3KZC/4X1fkWMxsiCpWU8kMusyrvOQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 2 Jun
 2021 14:46:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:46:40 +0000
Subject: Re: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove
 superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
To: Lee Jones <lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-17-lee.jones@linaro.org>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <38291a94-4f21-d725-282f-5faabdc31cef@amd.com>
Date: Wed, 2 Jun 2021 10:46:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210602143300.2330146-17-lee.jones@linaro.org>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR0101CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0168.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27 via Frontend
 Transport; Wed, 2 Jun 2021 14:46:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c265e05a-379b-4a61-5262-08d925d53b1e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB542617FB2002D074037542108C3D9@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 743lbOXrFOmXwlvNb72s165N1zyDA9hj6r+8xlumuP4nkLiaTrXT94TUNvTKfrLnNNPyqP7AcPaaffpP7i6s/1JvyWeViXIoMjHCtM/8OUjC1EpC7vi2zAQo39gvFBLEFkOLS3/zC2qwnwzJaRKdGgj0df64wLdJcerR+dRKvrWJFAIVTk935j/raOBV7Hlq5PXMDkzvbA9C2rByerb80C62gwmJxTI6RucYLxJ1t8ph/Xv6BJZcDCQEDI93W1PgNXKfpEAH0FnFZZPfJaWt3t7CLz75tLOMryIEhgc+AniVDnvlRis7umnXVdEZlSaPMlPlbXkHYVkKyd98JMXRl4mK2GHad8mwvugRGOwAamtRAJ201471MkgvU7Jser+cMzZqoMsixpzreAAn5qj1QaEkA/9YuQovlwwNFiaBNz2JHGNNi+nBGv+Yx11TijuSe20CVY2ckD2WeJUWXrfqAnnCTqZLVJ4P9ADM5vC09JXiL1krjVm2casp4rkke8dFZ2zv2S8OfcEjVsiFsEqaq0XHfV4QbYeCHl3Nvhuh1BVS6T3xmd62NT4lQcGia5exdsWiL1rhmXCUXy8GjqZFee7EIZD4jb5RNLtiG91RQbHLY33zxLsb47m1Il1MYWKZun8f/k3yNM9pvXT3uc8AcuvNr0pnAWzKegrDbLeZ6/eIn/bq+1XNKHO3t70W5Pxh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(186003)(6916009)(16526019)(31686004)(4326008)(86362001)(53546011)(26005)(6486002)(66574015)(316002)(2616005)(36756003)(8676002)(956004)(8936002)(16576012)(54906003)(83380400001)(478600001)(31696002)(5660300002)(38100700002)(66946007)(66476007)(2906002)(66556008)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T0pCNWQvUUkybktYWDUrUTdFc3lSSS9KVUR3RDFMSFNWcUdZbkowNXVCaFpt?=
 =?utf-8?B?d2sxT0ttV3I2NitSTHZjNlNoVnJGRzNMbFcrajdBdmlxNnhqOXlObXF4c3JO?=
 =?utf-8?B?Z0V0aFhpdm1GL2lTbmdpTnV4emFBYzIrYWFYUWZOV05qdnhrRG5YR2kzU2F5?=
 =?utf-8?B?a0pKNGR4L05uSDRvL2RFQVNESWRiV2F0S1BvQVRYdWxNZS9YZ3RoQ1lVQTU1?=
 =?utf-8?B?dkl6TmQ5YmhtcUpJUEdXUVpyRDVEM1ZpL1N0dy9ZN2JmS2F6WDVhdDE0dzBG?=
 =?utf-8?B?WUNyVUdjNnk5blRhVkhVMU5KaUNvTnQwRDJjS0EzbjBTVEVNMkd2ZkR6a3Jn?=
 =?utf-8?B?TTcyczVZVmN4R0dHUHFnTysxazhQR3Jkai9UL0ZaYmZVV2hqRi8xY0xVNjNq?=
 =?utf-8?B?TU9sb3NRMVZzYzA4S0FVTWMrV1FiZ1hVNW9XaVJIclpjSTJyY1lhVm8yRUF1?=
 =?utf-8?B?dXhvL2E0WjB1cFIvUFBlZkpKZTFHdmxmZDVFT3ZmSVNrSFRMNFRBdXJTVHZD?=
 =?utf-8?B?eWliWk02dnFDN3k2UjdpaWlURU9YLzVZR0dGWWdoUlFlaE5JNkJxb051MTlP?=
 =?utf-8?B?ekdkSG1VMFpqSklxWnVBYUV5Mnl5bkpHVXVJcThLVmpWcE5TcGQ3VjRFdDZD?=
 =?utf-8?B?MVd2VUlyMGx1anl5Si8zRlVwNFFvNmd0QzdDcXJRaUVJR3A3Wmx1V2x2djdx?=
 =?utf-8?B?YkZQbEc1eU9kL1JqT2Q1TUVhdi96KzNhTmsxYllmOEkwUjVrZytUV0hpMGhC?=
 =?utf-8?B?aVFuejJEY1FhT0czQzA0MWRVSUM4MzNST2hoMit0U1YvTUc2c1kzUzZSemhp?=
 =?utf-8?B?UXYxbHRFcFhMNGNhR1Y0cm0yVWJodUJiamo2STZTeHpxd0ZmMzNZay9sS3VE?=
 =?utf-8?B?cUVNR3AzbW1JeHJTNDlwSFRzSXVIUmZPQU5oQVZmTEVIWDR3a0FsZ1IzYmly?=
 =?utf-8?B?cUI2ZWhSdjJWVGZWMnJZZ2tOdW1nRFBCSWxKZVpqcXd3bkdRU1JTWVoxbWpn?=
 =?utf-8?B?TjhHZzB4V2JNbzhOdWVxYW54QmtSYXU2S1dCeFFaRkx6eENNNXVKd3dJMExX?=
 =?utf-8?B?Q3g5cTIrZXNKV1hha1Z1U3BkOXF6cFBpdzBUZjFzUVpYVEZBK2FUWHRhcjVh?=
 =?utf-8?B?L2tRWWszK24xSGJTekt5R0dYbWg5cWFTYmdxZnFEVmt5K0VtWFFGekhwYXdR?=
 =?utf-8?B?ZmNoTzFMU1FER2oxb1RHMm1lRVVlTU1vQjl6QlJMOVV3OVRRTG1CbGVvN2Fn?=
 =?utf-8?B?Z09iSjUzTHNDQjEzSjVwVjhJcXNqcW1XYnRKYXJkaTRqQ3U2L1RraTJTYnow?=
 =?utf-8?B?cmlMOVc0aGJMOUt1ZHY3MWtlZkVod1grWjJoSTVka29LWTNmQ3BVSTU5Ui9a?=
 =?utf-8?B?amlqSmIwZkpQRVF1K0NORThzY3dMWWpNZ25OaEdqTks3TEhROExDb21rcXk2?=
 =?utf-8?B?cTVJVVM1NEJPWGNiUHRqZG9VTVloT29wenhCYmFBSDhuRE9XZ1o0OHZmNERK?=
 =?utf-8?B?NUllOWdKMklkbzJhU2grdHoweVd6V3ZHbWU3aXRtVG1GamlpMGZHTnRJcGVL?=
 =?utf-8?B?dXRTWS9mQjlHSzBEdUVuUzNkWUo5Y1RjYXFSOGc1NVJhOGE4OC8rRFNORXpZ?=
 =?utf-8?B?cFkwWEI2TktyM3JlSGVDMGtxbUFHZUc0eUF0M3g1S1YzbjFhN2oxaUlGd28x?=
 =?utf-8?B?Z2lRQTB0T3JvWDN5V0Z1YlZiMCtQS1JmazRuenduVzVSMklFQlROVXNNZW5G?=
 =?utf-8?Q?6vdo9prhU9PfJjWdLAu6OzooeowoiwZ/c+htn0Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c265e05a-379b-4a61-5262-08d925d53b1e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:46:40.1184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YKqC2H7GacR8yeJi5BFLOwbdSjoOBNnipE6qIgKrvWc1MZRz7Y1eLus4LOggVV5PtWjLjmSeLREMQbZdRQqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0wMiAxMDozMiBhLm0uLCBMZWUgSm9uZXMgd3JvdGU6Cj4gRml4ZXMgdGhlIGZv
bGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4gCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNwLmM6Mzc0OjIyOiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmG1vZF9oZGNwX2hkY3AxX2dldF9s
aW5rX2VuY3J5cHRpb25fc3RhdHVz4oCZCj4gIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6
Mjg6Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNl
L2RjZV82XzBfZC5oOjU2ODo0Mzogd2FybmluZzogaW5pdGlhbGl6ZWQgZmllbGQgb3ZlcndyaXR0
ZW4gWy1Xb3ZlcnJpZGUtaW5pdF0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE1NzoxNDogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIOKAmG1tQ1JUQzBfRENGRV9NRU1fTElHSFRfU0xFRVBfQ05UTOKAmQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmg6
MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTUknigJkKPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE4
MzozOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYWEZNX0NPTU1PTl9SRUdfTElTVF9E
Q0U2MOKAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYw
L2RjZTYwX3Jlc291cmNlLmM6MTg3OjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJh0
cmFuc2Zvcm1fcmVnc+KAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRl
L2FzaWNfcmVnL2RjZS9kY2VfNl8wX2QuaDo1Njg6NDM6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0
aW9uIGZvciDigJh4Zm1fcmVnc1swXS5EQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZKQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291
cmNlLmM6MTU3OjE0OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYbW1DUlRDMF9EQ0ZF
X01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFuc2Zvcm0uaDoxNzA6Mjogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIOKAmFNSSeKAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTgzOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybyDigJhYRk1fQ09NTU9OX1JFR19MSVNUX0RDRTYw4oCZCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzoxODc6Mzog
bm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmHRyYW5zZm9ybV9yZWdz4oCZCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfZC5o
OjY0NTo0Mzogd2FybmluZzogaW5pdGlhbGl6ZWQgZmllbGQgb3ZlcndyaXR0ZW4gWy1Xb3ZlcnJp
ZGUtaW5pdF0KPiAKPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+
Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogTWF1cm8gUm9zc2kg
PGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpUaGFua3MgZm9yIHRoZSBmaXguCgpS
ZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpIYXJy
eQoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNm
b3JtLmggfCAzICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y2UvZGNlX3RyYW5zZm9ybS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfdHJhbnNmb3JtLmgKPiBpbmRleCBjYmNlMTk0ZWM3YjgyLi5lOThiNWQ0MTQxNzM5IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9y
bS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNm
b3JtLmgKPiBAQCAtMTY2LDggKzE2Niw3IEBACj4gIAlTUkkoU0NMX0ZfU0hBUlBfQ09OVFJPTCwg
U0NMLCBpZCkKPiAgCj4gICNkZWZpbmUgWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MChpZCkgXAo+
IC0JWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MF9CQVNFKGlkKSwgXAo+IC0JU1JJKERDRkVfTUVN
X0xJR0hUX1NMRUVQX0NOVEwsIENSVEMsIGlkKQo+ICsJWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2
MF9CQVNFKGlkKQo+ICAjZW5kaWYKPiAgCj4gICNkZWZpbmUgWEZNX1NGKHJlZ19uYW1lLCBmaWVs
ZF9uYW1lLCBwb3N0X2ZpeClcCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
