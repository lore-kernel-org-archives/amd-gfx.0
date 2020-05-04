Return-Path: <SRS0=L96E=6S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE33C3A5A9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2020 19:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E2E20721
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2020 19:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hggCp+0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E2E20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AE26E0C5;
	Mon,  4 May 2020 19:53:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1376E0C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2020 19:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZysNXekfLBL2kVSo7DImkx8ggQLzAlv/rK0M73kXs6vRkB3jlA5u05NzXlq/C2oKAxd6yuIXzV7vfD/0TI7booPqlqZlreVdZHZM9fv8lVtYMBMjk4zYJ8ZzXGIHT6/R9ot9H00nX893I95Uhmdxj1Q4yHpXjxkYw5AJPZ+9Ti9sNdVSznEb4Cxv+mvZPm5SKd1gNPZbIM10XRqHMV++K1DyImXMM9qkELB6APk/qPHgywO+g5zT27awpVI43C9QZXkHLKzwlH+VuiDuuQB59xaYNxxd6/miePRKisH4ypoDpy0Fzf6r6clydKzrkqR2vnd6FimwG9/bKANFzgAtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTJVdiH2DdI5nhZhavXppKIt/TbdtXQ9FDGISovDP8I=;
 b=cjIemQSBAYU2SRD7JeibjnajC6ZrwSKEklV8tm4f1owCj9LlPbvFsGIaWBebyTySQv/s3o97e+1rk+gq1/ExI/7ls0GzVjOFVOudDHRFL/4NKMP1rsVN9cR5kQEvvmxxdxSmBbosyDUFIPIU+KfNi0pCdoUta+q86o5hz/0/6TJiewyNLF0HYT3pFTjxMgsseWqSuefyrpmdXCT5ZLJZtjf2W80sa2WDILzprTF3kgTdZTrtR8oQi1L7mjH3/++y3Qp8Yoyvy2KUzHyhoMdKVRAqcMd1wsQPd3ZfQ36r4+ov4ReSrrPy9+cSL5AVskCiJj/53Otg9u7VJFUz/4jgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTJVdiH2DdI5nhZhavXppKIt/TbdtXQ9FDGISovDP8I=;
 b=hggCp+0ETxBDhnm+gonNh+H+pycpnoEKma/lv70i8fML64IPJ/8U7fOpkKtiPXJHFldYDc/pWAZ2Fgsw/5xUeQQDzgBjNL99tmSWW+GgnVPM3rYjcUxr6TPE2K6nfwPDvFBZJy69JiN8W9OAUJPurSDBE2R8AddGTziuHkV/vqI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 19:53:27 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%7]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 19:53:27 +0000
Subject: Re: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "S, Shirish" <Shirish.S@amd.com>
References: <20200429175857.17051-1-Jerry.Zuo@amd.com>
 <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
 <BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60@BN6PR1201MB2466.namprd12.prod.outlook.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <9d8cf9b0-46c8-676f-1d2b-414c21541697@amd.com>
Date: Mon, 4 May 2020 15:53:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60@BN6PR1201MB2466.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:400::19)
 To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:9240:c66::3] (2607:fea8:9240:c66::3) by
 BN3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:400::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.16 via Frontend Transport; Mon, 4 May 2020 19:53:25 +0000
X-Originating-IP: [2607:fea8:9240:c66::3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f689d086-d6cb-41ac-c139-08d7f064cfb7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4476:|MW3PR12MB4476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4476F1115B9C5A520539AB2E8CA60@MW3PR12MB4476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AtU3BIHNnty3pUDLIiBi8OKm+lvn0yZ/VwhhirPp3bwKWRSaUHG7MTKKQkER/laJWNybs8JCloQPp38trVuHz3YXJVxblUBAbETRAVGrqiYW/6aDx/8UpWKKpK/6R6DeBgLDq5G1h7WJCNYO2BnV8BlBF3JLcHiDLCnnZUyGr6NsJqPbXsJ4W4Lm7jNL6dxU9+tb9cGg9d04SGc6SmsKfX8+p3NRBk6st31k16SdQJ6ZGK82q6SODHBU5WFYejvyZ2f8pbo9ChXCuueUT9udsZrxkZEGlYdW5+07yU5NUR+BbY/qCVhMnmX5NbyvOh3ZH5dBDs6oT69nGz3znfTSP8ZxXX+0jhv4DIWegd29IUmbkjCc126c+UHqOqkTJdNXV8WrKzWI7IBqpoipWzwjegkydKMxGuLP6l79FHSBJYEHJhcYhEK/jZBOzd5UEDC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(186003)(16526019)(6636002)(8936002)(31686004)(5660300002)(6486002)(31696002)(8676002)(52116002)(2906002)(53546011)(316002)(36756003)(66946007)(66476007)(66556008)(4326008)(478600001)(110136005)(54906003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7NUsCEOe5GErmVyWhc+nOPiz67pP8iIoBjM26Q4vyUT8azjMaI4BapUeugegSbECf48M+xNgxBP3kswjForycLlkwakXtbWkVSYLhP14QQl/qTnwlEWooYLdX/yIb/sZBfk3B0ZqEtUfoldMUVMKWVawpcOExuFOwzyKm4IatD0hbPfj92K4qiLaYhMa9WoW93eXO6e1zD2lWL6QZKZqcah7fGkxI11Cw0FmNsugzrtFjWSHC9dMnSMQQh4KcHWA3CbzkrFV0vQDknNgGO9wexx6Ce5yH5RoKIEoOYRWZnu32aI2W+1JrPj6LxQ6MpD1+o75yGpogoN5HiuLSDZnGOxuk7J0fZWY3LwpQyvgePHZ82ztUUGL9t3kW1KTYKScSJNRy9Njt//3QkIqSi2zXVlZvJcIgHRynH+sZdKNUg45Pw/igtLmF3fY4ZghC0edDptiUVrtorOdBAyH/ByF0H2/HD5tESh9uogDNAbFOHBDHY60X+o4N8W7YCDNEVEEiSxASSuC0JEsNbRy//87tQb05ehF3fMy87jG9i9YnciP1e2nXd6fnaKNnmg8sq5G0J8f4gM11LIhdYrgBm0nu8qTUOAsSWXgsvdF8IQANjHN5IM5RNY1rACTVcSNMxQXkbP5IblY3GZt0Xz7sRWAKUV2/wNAp05muqzpjknZcG/oX+bavObYKIdlbPWowEQ2OvpdogluoS84i7MdLoPVfCDBCzEAMlvlX8gqbXQCMFgVTwng27KL7AnLfi/zlH4jxJhMJbJ9b80EhjRnFjTPj5ZogkQZRkg8aYotauYEs9TPNOkdQWIPM32q7+tX2WNu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f689d086-d6cb-41ac-c139-08d7f064cfb7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 19:53:27.1244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuWGEoEC4UkR2mgsCKkeylhePwsK/jCwhq1AfRGZ/9LWyiy1qkA45FUjosScWOwVWlCHgo2JeBA/rVoEt7dQ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIwLTA1LTA0IDEwOjU2IGEubS4sIFp1bywgSmVycnkgd3JvdGU6Cj4gW0FNRCBPZmZp
Y2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+IAo+IAo+IE9uIDIw
MjAtMDQtMjkgMTo1OCBwLm0uLCBKZXJyeSAoRmFuZ3poaSkgWnVvIHdyb3RlOgo+PiBJdCB3b3Jr
cyB0b2dldGhlciB3aXRoIGRybSBmcmFtZXdvcmsKPj4gImRybTogQWRkIHN1cHBvcnQgZm9yIERQ
IDEuNCBDb21wbGlhbmNlIGVkaWQgY29ycnVwdGlvbiB0ZXN0Igo+PiAKPj4gU2lnbmVkLW9mZi1i
eTogSmVycnkgKEZhbmd6aGkpIFp1byA8SmVycnkuWnVvQGFtZC5jb20+Cj4+IC0tLQo+PsKgIC4u
Li9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyB8IDQwICsrKysrKy0t
LS0tLS0tLS0tLS0KPj7CoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMjcgZGVs
ZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCj4+IGluZGV4IGM0MDdmMDZjZDFmNS4u
YjA4NmQ1YzkwNmUwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCj4+IEBAIC01NTQsNiArNTU0
LDcgQEAgZW51bSBkY19lZGlkX3N0YXR1cyBkbV9oZWxwZXJzX3JlYWRfbG9jYWxfZWRpZCgKPj7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRjX3NpbmsgKnNpbmspCj4+wqAg
ewo+PsKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9y
ID0gbGluay0+cHJpdjsKPj4gK8KgwqDCoMKgIHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0
b3IgPSAmYWNvbm5lY3Rvci0+YmFzZTsKPj7CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaTJjX2FkYXB0
ZXIgKmRkYzsKPj7CoMKgwqDCoMKgwqDCoCBpbnQgcmV0cnkgPSAzOwo+PsKgwqDCoMKgwqDCoMKg
IGVudW0gZGNfZWRpZF9zdGF0dXMgZWRpZF9zdGF0dXM7Cj4+IEBAIC01NzEsNiArNTcyLDE1IEBA
IGVudW0gZGNfZWRpZF9zdGF0dXMgZG1faGVscGVyc19yZWFkX2xvY2FsX2VkaWQoCj4+wqAgCj4+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVkaWQgPSBkcm1fZ2V0X2VkaWQoJmFjb25u
ZWN0b3ItPmJhc2UsIGRkYyk7Cj4+wqAgCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
RFAgQ29tcGxpYW5jZSBUZXN0IDQuMi4yLjYgKi8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAobGluay0+YXV4X21vZGUgJiYgY29ubmVjdG9yLT5lZGlkX2NvcnJ1cHQpCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9kcF9zZW5kX3JlYWxfZWRp
ZF9jaGVja3N1bSgmYWNvbm5lY3Rvci0+ZG1fZHBfYXV4LmF1eCwgY29ubmVjdG9yLT5yZWFsX2Vk
aWRfY2hlY2tzdW0pOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFlZGlk
ICYmIGNvbm5lY3Rvci0+ZWRpZF9jb3JydXB0KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNvbm5lY3Rvci0+ZWRpZF9jb3JydXB0ID0gZmFsc2U7Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBFRElEX0JBRF9D
SEVDS1NVTTsKPiAKPiBZb3UgcmV0dXJuIEVESURfQkFEX0NIRUNLU1VNIGhlcmUgYnV0IHRoZSBz
dXJyb3VuZGluZyBsb29wIHVzZXMKPiAiZWRpZF9zdGF0dXMgPT0gRURJRF9CQURfQ0hFQ0tTVU0i
IGFzIGNvbmRpdGlvbiB0byBnbyBhZ2Fpbi4gSXMgdGhpcwo+IGR1cGxpY2F0aW5nIGZ1bmN0aW9u
YWxpdHkgdGhhdCBkbV9oZWxwZXJzX3BhcnNlX2VkaWRfY2FwcyBkaWQ/Cj4gCj4gSGFycnkKPiAK
PiAKPiBJdCBpcyBub3QgZHVwbGljYXRlLiBZb3UgbWVudGlvbmVkIGRtX2hlbHBlcnNfcGFyc2Vf
ZWRpZF9jYXBzKCkgd2l0aAo+IHJldHJpZXMgaXMgZmFsbGVuIGludG8gdGhlIDNyZCBjaGVja3Vw
IHN0ZXDCoGJlbG93Ogo+IDEuIElmIGJhc2UgYmxvY2sgaXMgZmV0Y2hlZCB3aXRoIGNoZWNrc3Vt
IG1pc21hdGNoLCBkcm0gd2lsbCBzZXQKPiBjb25uZWN0b3ItPmVkaWRfY29ycnVwdCBhbmQgcmV0
dXJuIHdpdGggTnVsbCBlZGlkIGJ1ZmZlci4gVGhpcyBjYXNlIHdpbGwKPiBiZSBoYW5kbGVkIGFz
IGNvbXBsaWFuY2UgdGVzdCBjYXNlIDQuMi4yLjYsIHJldHVuaW5nIEVESURfQkFEX0NIRUNLU1VN
Cj4gcmlnaHQgYXdheSB3aXRob3V0IGdvaW5nIGFoZWFkIHRvIHBhcnNlIGVkaWQgY2FwcyAtLT4g
bmV3bHkgYWRkZWQKPiAyLiBJZiBlZGlkIGJ1ZmZlciBjYW5ub3QgYmUgY3JlYXRlZCwgcmV0dXJu
IEVESURfTk9fUkVTUE9OU0UgYnV0IGRvIG5vdAo+IHNldCBjb25uZWN0b3ItPmVkaWRfY29ycnVw
dAo+IDMuIEZvciBpbnZhbGlkIGV4dGVuc2lvbiBibG9ja3MsIGRybSBkb2Vzbid0IHNldAo+IGNv
bm5lY3Rvci0+ZWRpZF9jb3JydXB0LiBUaGlzIGNhc2Ugd2lsbCBiZSBmdXJ0aGVyIGhhbmRsZWQg
YnkKPiBkbV9oZWxwZXJzX3BhcnNlX2VkaWRfY2FwcygpIHdpdGggMyB0aW1lcyByZXRyaWVzLgo+
IElmIGZhaWxlZCBhbnkgc3RlcCBhYm92ZSB3aXRoIEVESURfQkFEX0NIRUNLU1VNLCB3aWxswqBl
bmFibGUgZmFpbC1zYWZlCj4gbW9kZSBpbiBEQy4KPiAKClRoYW5rcy4gSnVzdCBjdXJpb3VzIGlm
IHRoZXJlJ3MgYSB3YXkgdG8gc2ltcGxpZnkgdGhlIGNvZGUuCgpFaXRoZXIgd2F5LCB0aGlzIHBh
dGNoIGlzClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KCkhhcnJ5Cgo+IEplcnJ5Cj4gCj4gCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
PiArCj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghZWRpZCkKPj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBFRElEX05PX1JF
U1BPTlNFOwo+PsKgIAo+PiBAQCAtNjA1LDM0ICs2MTUsMTAgQEAgZW51bSBkY19lZGlkX3N0YXR1
cyBkbV9oZWxwZXJzX3JlYWRfbG9jYWxfZWRpZCgKPj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRFJNX0VSUk9SKCJFRElEIGVycjogJWQsIG9uIGNvbm5lY3RvcjogJXMiLAo+PsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVkaWRfc3RhdHVzLAo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjb25uZWN0b3ItPmJhc2UubmFtZSk7Cj4+IC3CoMKgwqDC
oCBpZiAobGluay0+YXV4X21vZGUpIHsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bmlv
biB0ZXN0X3JlcXVlc3QgdGVzdF9yZXF1ZXN0ID0geyB7MH0gfTsKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1bmlvbiB0ZXN0X3Jlc3BvbnNlIHRlc3RfcmVzcG9uc2UgPSB7IHswfSB9Owo+
PiAtCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1faGVscGVyc19kcF9yZWFkX2RwY2Qo
Y3R4LAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmssCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFBfVEVT
VF9SRVFVRVNULAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ0ZXN0X3JlcXVlc3QucmF3LAo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNpemVvZih1bmlvbiB0ZXN0X3JlcXVlc3QpKTsKPj4gLQo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghdGVzdF9yZXF1ZXN0LmJpdHMuRURJRF9SRUFEKQo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZWRpZF9zdGF0
dXM7Cj4+wqAgCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVzdF9yZXNwb25zZS5iaXRz
LkVESURfQ0hFQ0tTVU1fV1JJVEUgPSAxOwo+PiAtCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZG1faGVscGVyc19kcF93cml0ZV9kcGNkKGN0eCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsaW5r
LAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIERQX1RFU1RfRURJRF9DSEVDS1NVTSwKPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAmc2luay0+ZGNfZWRpZC5yYXdfZWRpZFtzaW5rLT5kY19lZGlkLmxlbmd0aC0xXSwK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAxKTsKPj4gLQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRtX2hlbHBlcnNfZHBfd3JpdGVfZHBjZChjdHgsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGluaywK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBEUF9URVNUX1JFU1BPTlNFLAo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICZ0ZXN0X3Jlc3BvbnNlLnJhdywKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YodGVzdF9yZXNw
b25zZSkpOwo+PiAtCj4+IC3CoMKgwqDCoCB9Cj4+ICvCoMKgwqDCoCAvKiBEUCBDb21wbGlhbmNl
IFRlc3QgNC4yLjIuMyAqLwo+PiArwqDCoMKgwqAgaWYgKGxpbmstPmF1eF9tb2RlKQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9kcF9zZW5kX3JlYWxfZWRpZF9jaGVja3N1bSgmYWNv
bm5lY3Rvci0+ZG1fZHBfYXV4LmF1eCwgc2luay0+ZGNfZWRpZC5yYXdfZWRpZFtzaW5rLT5kY19l
ZGlkLmxlbmd0aC0xXSk7Cj4+wqAgCj4+wqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVkaWRfc3RhdHVz
Owo+PsKgIH0KPj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
