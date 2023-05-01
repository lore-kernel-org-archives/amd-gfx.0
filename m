Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599EDC77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 23:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46EB89131;
	Mon,  1 May 2023 23:23:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF45C10E118
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 23:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK0+5wI8uV1tqtsfeA4OK64tMsPDYYsyqxZaAMMer4ggGifwlc/fSdBp2K+5YQ1uv0+mUB3hq2cNyKtbAYErLWVlm/Z1WHF10nQ8gQIqcK/jhpa06jBKOWwg/V2qIsP04AHALridZt8UKoqVpr5pLaDBTOcsD0lHL8HA2gAuDfpjjWmEWuLJr9B6v45RcEcefRes/i8m/KBHy8r1nS5002R+P8vSLBhO/Crzt4UFE4aV3dYKoVg5EXGbR4YXhT3eVHO6SeDRgkw0gCqr3ndIk0ahq1/nVqSY0AV8jAvjGJD3wGDOgcFp70xwWYZcfnnvxW2A4vgsxYTiN0T9Wt8lpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30yE8uQ1EE6kTaKQ4+nw2yNetBrKoQJSbSgmi+Mclks=;
 b=Y+MKSHdgZUgdUrJbxlMrZxXpSBR3IO7tFhZH5pJBLUYCUS5VqdOSBLS7iXNf0Ol5jP2cUpcFZt7V5vYKT+0dspVpLTUrOKUosZrDas40deaUNhXQuUYEvjq2vKnMmUipgCR6xrKc+VU8XR/YYEz1it0J5Ssig2L8q8p7FPwB4c6IVrIZXcXPXzbCs0MyugowDRsckFajD+vKkY4/CwlVEmVK8sqBtebojIwAlc2cWIQ6nDXm/I3T8D3kBuDMXexAo7knbM63YxybdVbqAUCn7K7knAIS332WEM2G2h4Dg7CCe+tNPqKF/oZEuAQ1RpUHUjP8Nc3zsKTmmzgJp4vCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30yE8uQ1EE6kTaKQ4+nw2yNetBrKoQJSbSgmi+Mclks=;
 b=Tza/RL2x5YdodO1QtPLkbdwjN9rGhsMChER/xXAABBz6MsN0vohVgHX+XOlgK4CkfFIVRyBlOGSSeJi/x8t2RsC0J+B73kCacWhEAKXNGlpDzce6KEjkQLco6VA8t+Gv406O6bpAcTMT8l7yTBGYD3bgJpeenUQq8fld16yOWhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 1 May
 2023 23:23:17 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::c868:bf54:e11a:f1b8]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::c868:bf54:e11a:f1b8%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 23:23:17 +0000
Content-Type: multipart/mixed; boundary="------------piURD8E0wD0Ltcl0u04nmrmm"
Message-ID: <11592d8c-63c7-a928-549e-3a96a0a3c91c@amd.com>
Date: Mon, 1 May 2023 19:23:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Thong Thai <thong.thai@amd.com>
Subject: drm/amdgpu: update soc15 and nv max encoding height
X-ClientProxiedBy: YT3PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::17) To CH0PR12MB5089.namprd12.prod.outlook.com
 (2603:10b6:610:bc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0618a445-3880-4a1e-38d7-08db4a9b0b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqXsA0p/drvbehcoNeOR5mzqCWuItqrLDNEd8Y2zpvOlffj4T+3tiEsqDeumSfVHgeD6yYsu6JugnzH9DdE3FMiHjEosvhvEEauwq5xzmYvreL72qzejE1hFUYiohcFu/vMtnNrEIVHy0wRCSICKlYQUuQgQg+jBJ9RKRB0bj8DMv3fVqx7TROY+CukePNdk5dLLr217aVTIyZdC/kxopcl6G8rxZmXMqYTiBt3LcZ0j0NPzq7heRhWK0Ew1CXSHAxXyR2rM+uF4eHDjhU1OsZpfjq6+IqiA4yKZYKvuPsji9neMVm676/2F1CR2nP4B8Bm7Xd0By8msYWdbG32GUeMsYhAyMSzmgDBUvyhc6fa/fRDctAHzEzUWqeMxkOx5GoNV2r8LvnwAuLsJWYp5LpylbBXZI1R6sM4LMM9kHHS4Xxu25UkPnOPrd9379yycPNTc261dux2yAjwrYw2cckMxmw/rG3VCT5e2+D7Yp3g+ezOkoQ0TfyrGXCJ4+BnTaXkNLTzJCDyti2luaoqnMDSwg65gbuz0DCFor56iQwyNHAvSvtCUCjVlQpuWLuI1RhlB39hIOQF+ldyVJFd4WUnfngbiaLItjw1/h4Q6nlSI2Osv/oV/GRzN/hMLmeRQZy4gunsMNoCvY8psUYBW0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5089.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(86362001)(8676002)(38100700002)(6916009)(316002)(66946007)(8936002)(41300700001)(66476007)(66556008)(44832011)(31696002)(5660300002)(26005)(2906002)(15650500001)(235185007)(6506007)(6512007)(186003)(6486002)(33964004)(83380400001)(36756003)(31686004)(2616005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmszaE55MzJZc1o4UnNOUlh1WkZGWWMybWVFZ0J5RmdBemZZQjViVWF3SkFj?=
 =?utf-8?B?aVVTS0VEUzRQcERRTHVRSkVyR2syaWphU2tEMDNHYnRZa09zVCtKbzU4RWpK?=
 =?utf-8?B?QWM4dm5WSUtiUG1IVXZyMVdLSVBocjRUUjlaeW94d1NtVk92V3FaVDBhUjhu?=
 =?utf-8?B?Qm1NdGNNcE5hUko1N3BkNW1XUDh3cWZuUit6YzduU1BmVy9nNGg4TDRJRVZS?=
 =?utf-8?B?UzdISlIxajZLU20yM2dUMzZPbjVQanJlL1JxdkhEcThCd2RPODg1eThGOXIr?=
 =?utf-8?B?WGxjTU1RN2V3Sk8rZk50MEpVMlVEVHl2K1dvK0ljZFgydVUyRW1yOVArUlBI?=
 =?utf-8?B?R24wVGluZU1ZYnoxblprdWlWOHJtM2xpWVd4ai9pSFIxbDcyWnFFelVjR2ZC?=
 =?utf-8?B?K1lrYzBKbUFmSjF1V0ZlcEl6VXJUdVUrOWhYbGE4OTZmOWdBazhVaWxJdUVk?=
 =?utf-8?B?c2FWQk9PQ1NUT3VuSXArRWxibkUzVlNTbWpZTDkrdDBTUjU0RE0xWVdHZmMz?=
 =?utf-8?B?cUEzek1SZjdFWUpvNDRycDNGNER2MGx6Q1ZUWGtDZ3RNUDVoRWtIU2Q3RU8r?=
 =?utf-8?B?RENBWW1teFBVeW0yOWszelpXWndkYkdXS1ZtQzdKd3Jka05JVmlRSlhuM2J4?=
 =?utf-8?B?T3l3anExbUhTdGJ0dzNsdkFvRjVMYWZTRXJQZ0g1Zm5lTjM3TnltOThkMm1y?=
 =?utf-8?B?ZWJNZVBLYVZvaHVlUHJZT1MwMnBmMlJTUk1RemV2U2xia3I4cGZTeWZ0Rkh1?=
 =?utf-8?B?NnNZZHBSeUl1dmpYOWlWaE1MZmZ6TUIrckRTc01xU05kM3BBVG5ybXJ2NTM4?=
 =?utf-8?B?U2Q4TElobTJQbXRFYi9DbDZrTG96a25VTElIRjNOcEVIdlp6MFIxd2ZIcFNY?=
 =?utf-8?B?b21sc2dpckErR1RNWjdtYWNXNXVVSjZsYlptYi9QU09pc0pSaTRZcjgzejY5?=
 =?utf-8?B?UVg3Q0IwNFo0N2RLTzB6aDFyakhxYlp2NDBHRXZEdkJjOURqTEVDWHE0Q0hr?=
 =?utf-8?B?aE4raGkxUk1EM0JKc1FRdnh0Umh5QUNsbEZSWE1BOFpwSVBQMWRsSE9FeU5r?=
 =?utf-8?B?UjhDTWVRZ3JKNG1CN2ZCMVNUdHBlTXpEdCt6b3pKUW50djQyamo2TWFLYzVD?=
 =?utf-8?B?RDUyM3BWT2Z6MVQxaGxSYWpoVVhkVmpRcXYzZFRpakJ3K0F2NDhEOHRHeTB5?=
 =?utf-8?B?UXBYeXlGVk5xRURrQWh6Y1BIS2M3Z3ovT2xRRG1xWEhMQUtXTVZnWktXS1Fl?=
 =?utf-8?B?dE9Ha1lsRDFKTzc5SzVzMWZXc2ZpVmdSTFR3VmFpTlZ4b1BKNHJQUm1UZjk1?=
 =?utf-8?B?cW0vYnJOS2N1UjJ6cXZqZnNFbmNOWUQ3RzUvOFMvQnU4Z0ZYRHNldmRRZTJD?=
 =?utf-8?B?ZTRTYUdQRmphaFo1b3JCOXV0NktZM2hXTzNmN3F5SDRIVWVIUmpld1N6S0ZE?=
 =?utf-8?B?cDVwWThwL2dQcVNRbjY4bVpqM1FvcGtvVnJ2bUFTWVVtYTNpRkZ1ZVoxSUJq?=
 =?utf-8?B?RG01R05lVDFVdDhSY2lBVEthVnVsVFlIUnFPeG1KeXA1eWUwM09NSng4RE5p?=
 =?utf-8?B?MmdWVWt3eEwyQ0RQWjRQYTdjd3JTSVBUUXRPRWprMHB3R3Y3OFJ0UDlZUkhC?=
 =?utf-8?B?YmZPazlSU0NVdFJ1L3dycjBoM0NjVjJkQlp3WUhreENxQzJFUWtJc0l1UC9G?=
 =?utf-8?B?cGtzVHV2dUpEVXhPY3B5eWNEa2l6TWM4VzV3YmdXUXhicFkxSFVRdERmU1li?=
 =?utf-8?B?Y2c4T3lWVWZGRUVSOWlHdWpmSEVDUDdWSk5EdlRlZnlscHlQNEsyWHgycTlI?=
 =?utf-8?B?dTJGMGFJTFpvclRQMGtCbWpJbDh3MUZHVkFSUjNKL0RNYm15cWtYMXRIamR6?=
 =?utf-8?B?LzhqN1RSMXdZRU5NWHNVSGpqaTNKU3lEM045b2R1UzhPcndPajFSemRIZjZN?=
 =?utf-8?B?QWRvN1lHc3U0RlpkM0oyT2h4d2s0UVg5dWdTcGFyaHV6WWFKMEdnM3UyazdI?=
 =?utf-8?B?c2FMWDI2dnJxN0dOc1djQ3l2YXgrN0NLYnpzUGlrdW5vd1dWNGJHMytiL1Fr?=
 =?utf-8?B?dzBhWGs3YkhBYm5HTThMOWxqSXR1eUtFbC9JZC9QNnpxRlo4SmZReUhXcW52?=
 =?utf-8?Q?0QPi2IR6nTfPBQmLw0OB0uit/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0618a445-3880-4a1e-38d7-08db4a9b0b46
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 23:23:17.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giLzKv2D85dZY/GkaXxFny/2tdSJxuzjyez4D7N35TCF4PYmJdiGo6ZTBJaSTEHlvrYxmzBFhbKtvqpHMOCpdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
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

--------------piURD8E0wD0Ltcl0u04nmrmm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

     drm/amdgpu: update soc15 and nv max encoding height

     Update the values reported for Vega, VCN1/2: H.264 and HEVC encoding
     maximum supported height to match the values from the hardware spec.

     Signed-off-by: Thong Thai <thong.thai@amd.com>
     Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

The patch is attached for review.

Thanks,

Thong Thai

--------------piURD8E0wD0Ltcl0u04nmrmm
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdgpu-update-soc15-and-nv-max-encoding-height.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-update-soc15-and-nv-max-encoding-height.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSBkY2JlZTJmMzA4MjYwY2I5YTk1MTczODdmZmM1MTI2ZmFlNTllOTFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9uZyBUaGFpIDx0aG9uZy50aGFpQGFtZC5jb20+CkRhdGU6
IE1vbiwgMSBNYXkgMjAyMyAxMTo1ODo0MiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IHVwZGF0ZSBzb2MxNSBhbmQgbnYgbWF4IGVuY29kaW5nIGhlaWdodAoKVXBkYXRlIHRoZSB2
YWx1ZXMgcmVwb3J0ZWQgZm9yIFZlZ2EsIFZDTjEvMjogSC4yNjQgYW5kIEhFVkMgZW5jb2RpbmcK
bWF4aW11bSBzdXBwb3J0ZWQgaGVpZ2h0IHRvIG1hdGNoIHRoZSB2YWx1ZXMgZnJvbSB0aGUgaGFy
ZHdhcmUgc3BlYy4KClNpZ25lZC1vZmYtYnk6IFRob25nIFRoYWkgPHRob25nLnRoYWlAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IFJ1aWppbmcgRG9uZyA8cnVpamluZy5kb25nQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyAgICB8IDQgKystLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKaW5kZXggN2Q0
MzdiODIxNTllLi4xOWZmZWM3OGIwOTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYwpAQCAtNjks
OCArNjksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZF9pcF9mdW5jcyBudl9jb21tb25faXBf
ZnVuY3M7CiAvKiBOYXZpICovCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV92aWRlb19jb2Rl
Y19pbmZvIG52X3ZpZGVvX2NvZGVjc19lbmNvZGVfYXJyYXlbXSA9CiB7Ci0Je2NvZGVjX2luZm9f
YnVpbGQoQU1ER1BVX0lORk9fVklERU9fQ0FQU19DT0RFQ19JRFhfTVBFRzRfQVZDLCA0MDk2LCAy
MzA0LCAwKX0sCi0Je2NvZGVjX2luZm9fYnVpbGQoQU1ER1BVX0lORk9fVklERU9fQ0FQU19DT0RF
Q19JRFhfSEVWQywgNDA5NiwgMjMwNCwgMCl9LAorCXtjb2RlY19pbmZvX2J1aWxkKEFNREdQVV9J
TkZPX1ZJREVPX0NBUFNfQ09ERUNfSURYX01QRUc0X0FWQywgNDA5NiwgMjE2MCwgMCl9LAorCXtj
b2RlY19pbmZvX2J1aWxkKEFNREdQVV9JTkZPX1ZJREVPX0NBUFNfQ09ERUNfSURYX0hFVkMsIDQw
OTYsIDIxNzYsIDApfSwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3ZpZGVvX2Nv
ZGVjcyBudl92aWRlb19jb2RlY3NfZW5jb2RlID0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
CmluZGV4IDMyMjE1MjJlNzFlOC4uNzYxYjI4N2NjNDRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMKQEAgLTkwLDggKzkwLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVu
Y3Mgc29jMTVfY29tbW9uX2lwX2Z1bmNzOwogLyogVmVnYSwgUmF2ZW4sIEFyY3R1cnVzICovCiBz
dGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV92aWRlb19jb2RlY19pbmZvIHZlZ2FfdmlkZW9fY29k
ZWNzX2VuY29kZV9hcnJheVtdID0KIHsKLQl7Y29kZWNfaW5mb19idWlsZChBTURHUFVfSU5GT19W
SURFT19DQVBTX0NPREVDX0lEWF9NUEVHNF9BVkMsIDQwOTYsIDIzMDQsIDApfSwKLQl7Y29kZWNf
aW5mb19idWlsZChBTURHUFVfSU5GT19WSURFT19DQVBTX0NPREVDX0lEWF9IRVZDLCA0MDk2LCAy
MzA0LCAwKX0sCisJe2NvZGVjX2luZm9fYnVpbGQoQU1ER1BVX0lORk9fVklERU9fQ0FQU19DT0RF
Q19JRFhfTVBFRzRfQVZDLCA0MDk2LCAyMTYwLCAwKX0sCisJe2NvZGVjX2luZm9fYnVpbGQoQU1E
R1BVX0lORk9fVklERU9fQ0FQU19DT0RFQ19JRFhfSEVWQywgNDA5NiwgMjE3NiwgMCl9LAogfTsK
IAogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfdmlkZW9fY29kZWNzIHZlZ2FfdmlkZW9fY29k
ZWNzX2VuY29kZSA9Ci0tIAoyLjQwLjEKCg==

--------------piURD8E0wD0Ltcl0u04nmrmm--
