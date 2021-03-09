Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166CCC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72656525D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72656525D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757EC6E4AD;
	Tue,  9 Mar 2021 12:42:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83DA6E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 12:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwIxhaFtdnQo9cL0H1i1FGpw/wf57Nu8BSgo8YJAL2661nQuBo3pHKB5g5W7MT98J+p49nwBh2HGhAVJlwcnj9f+vO5YnFqLstoaHRr3/bnrLtCshoRLp540hJMtN15QFLvMSz8j1+HKkh0acbdQ0NV8vxKmuXZl7R5rRwLyRLBvRfNo7bbug7W23zS/BuiJDZf0mBDPvWZZ2vvS45PpMgmu+Uc01pdcSG7BCGwzKEnrDxHpzT07hE9YioUnYxDCleuxEzU/gECc82J1yV59UqAUp+BnlOfh/Sx+TxeLdydsdFTnMVz+BhMPKX8zA6BvaYvw0ymS4qbsdQL+HmMa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V/FdRBqlQVUvWyI/P3EWiYRbW+wXtbnRJ3B4+T1pgM=;
 b=Xt1Y4up6QDntl9hwS1leEZShw95a/EiAtt+He10S6zHlu0k0OIDDnb3vBz0lKanyRZujGUAx4RsskA38vHhOSfTvVkf+Oos4SmDke5lPauCCsHR8lbJdmLd89NiEzVa3YxQ6Unzs1dBhTtyi0xxUtGaBotEkX3lFAAsmh4/uzyYz5MUe5N/t5LxyTNPKI3twji8wOL1MzRwxuhh9duPwy6HXPXdqJxr1Hqr3OPDuDPePFoHjkJjb5ST1+i+6BbwzQSWxISOYf3G2/p3rgUBKv3RdX3zC7SroBUrtu7ItkHaRNgmoNITlHkbGKF8emsBnUctQzWbhqYGj2bt82zC8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V/FdRBqlQVUvWyI/P3EWiYRbW+wXtbnRJ3B4+T1pgM=;
 b=y3pKL43ofNx2OFgnOGB0QEZecbl76/JOC8B8/TtyffVPThf5xWUi59PfZHD9bdY4hIWfOppwIVxOa5nqlhaHXfIbHN6uqtOcOXZrZ0CjWtR5Ow9fLe6zlmFUsWqP6YbBv2EH+DF5Si0j/Y/lJ1u1Z+kOZGU96kEThe0HyH64q5c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 12:42:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 12:42:11 +0000
Subject: Re: [PATCH v3 5/5] drm/amdgpu: use amdgpu_bo_user bo for metadata and
 tiling flag
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
 <20210309084659.37649-5-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e42df77d-3cf0-99b0-f1ec-51c5d067b4b4@amd.com>
Date: Tue, 9 Mar 2021 13:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210309084659.37649-5-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe]
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe]
 (2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.23 via Frontend Transport; Tue, 9 Mar 2021 12:42:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3be7ed3-9902-4403-12e9-08d8e2f8c21d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110423302854E3ECF1F9ABF83929@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QisgGh4+mwgxd4z2JTcygAahbJiAxE77cgWLmXkvwrVj3ZrMWwks+//eTwwToo1mRUXjsg3ZecNTsiYix4NIfcOfx8zxSdt9+Hza3hXXZKNiGLHz4OZYNDOCDnck7yDPMAHEAUOdPZpgQ1Yr7hRWu5lfvXc4nXVOfo8VRyyc4jU9aUpDNeXipckvwTTNwgpn8caFoyH+hGgXzofbkdG+2HJ7+I8+zEbmsTnVeGSUKAiryrM4cn8ZeXBtXGoTPyojQxSFm/ME1rWumSoTzD0I5dh0/ZhnlvLr7a23bSoQXQfDLPio5Ax5GzZahne3Xm221gn53Jkcghnu26UNsoYluUI4/AzAEGtzMwJmhiBryUhfxuIC2Y0GhRzor0lqHXpB3cZafEz/8egrTQJ6ntLp0qvWil3FdY+gbdJKzCgCWnkYxvzvdz7GLTvjpY+aYr0bEZ8ewVscn+SkWwWbSq5MFkpt60969x/hzNDRvSvlaunmX9X5RCA3ekBYPMNgpxj1O3nVwIGHWc4Bvq/8h8u/xlxq8xWRPHg2orLI2ySNdfEypyWvX9zRCVMrrmaGamgXf0UT9PEGUI2AjTxVaOwTyknip4WE1MS24OjaBdjUS8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(4326008)(37006003)(6636002)(5660300002)(36756003)(66556008)(6862004)(8936002)(316002)(52116002)(6486002)(31686004)(8676002)(478600001)(6666004)(86362001)(31696002)(2906002)(16526019)(186003)(66946007)(66476007)(2616005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d045S0pRSzFQMTZ2cDdSei9UUEIyTmJvMG1kZStTa0RhRklFNmVTT1RxaGZ0?=
 =?utf-8?B?VS84VllaemVBREtqZXptZXNRWlZqTkxBMmRTdENmQ0M2M3NHd01NL2xKblN2?=
 =?utf-8?B?ZFpYdkxJRGFmUXJpVjd0NXZyUjF3dGp0SVJTZTNrZy91NXU5dmhoSHJ4Z2o2?=
 =?utf-8?B?b2svRHp5K1JtQ3gzNVdaZHdKQW1sbU5oUTZ5eDAxOTBlODBZTEVnR1ZiNmNK?=
 =?utf-8?B?UkZ6VGxVZkVZMnE2WlMyNmM4WWVOVVNhdFkyVFNtVCtBQVBqWHFYNFk4QXJQ?=
 =?utf-8?B?Z25acG53bWwrSkxuWXJBaEdHZTE4ZGZWU09ZTkwvRFdUOWhqekhucUJURXVn?=
 =?utf-8?B?QnBJSUV2Skt1NjZTOFlTRDNxMVJzeWQ5YzJSUHA3T1k4cmEyRTV4a2hRdHNQ?=
 =?utf-8?B?Mm85dEdOL3FyVlpsTUJMNmRFcVlTQVBCUXBraXROaFplR0xRL0ZRTndiUmFX?=
 =?utf-8?B?U0d1ejFXckx6SVdrMXJEZkVRYTZZSVMyMnpzMmErbVE3S3JnU042ajZKL3Yx?=
 =?utf-8?B?R2Q5V2pERnNlUy8vL2ZlSjdEV05FWTNCdlVtS05ub1lTanFVRlkvNWp3eFda?=
 =?utf-8?B?ZTRGT0VwSTFyZHRnUmtjSU11Q3htaW1ueVlTbUc2bVlSNWkyUkFPWDFiM09Q?=
 =?utf-8?B?SlpPMFhrYURTZ2JrOHlKZ05mWWdkaHRCeU13MC9VYUN3VUg5N1d0dTZhWFpN?=
 =?utf-8?B?cHBta2lTZ0U5bnJJMWdBTm1XbTU5Q0lUOENyek9EdmJ1c3lSYi8xcjZTNEZP?=
 =?utf-8?B?RzNhNCtVRFFHZ3plQm9VWVFpbGJXa3RreDRtZ1lSTk94bDB0ZWZMV0s2VFI5?=
 =?utf-8?B?bVNES3JMNjZUT2tlRkNvYzdqZFg3bEpGcUNSQWtPK3A5c2FiMGlxSWNkQm5M?=
 =?utf-8?B?aElFczJ3YVhkekkxNWo2bCtVYWFSMExJU1VlbFFuWjBJcXhOazdGRTZjYzVR?=
 =?utf-8?B?dGFxWGFZcDg5Tk54bTVaR3ZEZ3V4bjF3SlE5TlFUYnNoWjN0RHZpREtvYyth?=
 =?utf-8?B?S2FXTklZSE5YdnU4U1RpZFNkcjRUcTFkeTQvcHdKeWU1WWExSkdLdE55QVNT?=
 =?utf-8?B?ZXZNRXN3QjdpdGVXRHN4TVJGL0ZRdFBld3ZvekRiTjdyRlo3dENhMlF0QVkw?=
 =?utf-8?B?Nlo1NWkxbTE5YXdSUkxBN3ZjQWlYejlsem1VRXBPNzRxOXJRWTUyWkh5aHow?=
 =?utf-8?B?Ump6cjRLMlVqMTkyNlJxMFBUSERUVjAxZFNUbVdEMnJ3eFY0cmpTWjBJeklm?=
 =?utf-8?B?c2FjK1JDRTFpeU13T2RXWWlkZXBTTTJsQWFCZnBaRC9WTm9FbTVkQWlJcDBH?=
 =?utf-8?B?VGhoaG5Ba2djQlgzb1NJUjJoTFNvcUg4ZjhNR3kyTUltenA3aVM5VlU4dXVa?=
 =?utf-8?B?SUZsM0pxMWhGellNeWhFd2M1aDhjNGlzQUdPVmFPRE5qVDVMblFkZEpiMnNQ?=
 =?utf-8?B?cVhTUXB4NUNtTjh2cGlERXRac1RwOXB2ZjN5ME1hMk9COVN4Y3l2TzVmRmhi?=
 =?utf-8?B?RmlrQTJGVDdPSDBrUFkzV0ljZmM4RnJaajdvSTJEQnFBMGtNeW9KcENLdU9a?=
 =?utf-8?B?VDdmKzFXV3VMSExCVEcwcmxuc3ZMbW10V04yMWxtRnd2akttVCtRNWVreWdq?=
 =?utf-8?B?YkZZWEdJQVF6cmlzbEx3UWx3dFdSNWRrWnJxeXNaTlA4UFJMUTZEaVpvMjNl?=
 =?utf-8?B?YjJwamY1bi9kb2R6R2lOU1ZOZzFNYkpCaGN0S0tNN1pTTEw0SHpLUzl6dy9O?=
 =?utf-8?B?cE05NzIvclBBRHZkYXg4eHpuYmpObmlKZDNlTURXR01oRUw1am92VUVKenlW?=
 =?utf-8?B?Sk1aUlVOYjBEaGVYRC84TEhLNFZYY1VDa1lsQ3JVS240aENRM0FHKzRVeUZa?=
 =?utf-8?Q?vvZ6JwA4lf5ZP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3be7ed3-9902-4403-12e9-08d8e2f8c21d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 12:42:11.2075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVbIEMEhB/guLZluICxv8zMVz9ovifp1pIKfXXuspsbyX1MA1EPuHH+niu0P81dU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDMuMjEgdW0gMDk6NDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IFRpbGluZyBmbGFnIGFu
ZCBtZXRhZGF0YSBhcmUgb25seSBuZWVkZWQgZm9yIEJPcyBjcmVhdGVkIGJ5Cj4gYW1kZ3B1X2dl
bV9vYmplY3RfY3JlYXRlKCksIHNvIHdlIGNhbiByZW1vdmUgdGhvc2UgZnJvbSB0aGUKPiBiYXNl
IGNsYXNzLgo+Cj4gdjI6ICogc3F1YXNoIHRpbGluZ19mbGFncyBhbmQgbWV0YWRhdGEgcmVsYXJl
ZCBwYXRjaGVzIGludG8gb25lCj4gICAgICAqIHVzZSBCVUdfT04gZm9yIG5vbiB0dG1fYm9fdHlw
ZV9kZXZpY2UgdHlwZSB3aGVuIGFjY2Vzc2luZwo+ICAgICAgdGlsaW5nX2ZsYWdzIGFuZCBtZXRh
ZGF0YS5fCj4gdjM6ICppbmNsdWRlIHRvX2FtZGdwdV9ib191c2VyCj4KPiBDQzogZmVsaXgua3Vl
aGxpbmdAYW1kLmNvbQo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1k
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQu
YyB8ICAyIC0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8
IDUxICsrKysrKysrKysrKysrKy0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuaCB8ICA0IC0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlv
bnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYwo+IGluZGV4IGRlNmIzY2E2NGI0NS4uZWZhNzk3MTlkNDUzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+IEBAIC00OTgsOCAr
NDk4LDYgQEAgaW50IGFtZGdwdV9hbWRrZmRfZ2V0X2RtYWJ1Zl9pbmZvKHN0cnVjdCBrZ2RfZGV2
ICprZ2QsIGludCBkbWFfYnVmX2ZkLAo+ICAgCQkqZG1hX2J1Zl9rZ2QgPSAoc3RydWN0IGtnZF9k
ZXYgKilhZGV2Owo+ICAgCWlmIChib19zaXplKQo+ICAgCQkqYm9fc2l6ZSA9IGFtZGdwdV9ib19z
aXplKGJvKTsKPiAtCWlmIChtZXRhZGF0YV9zaXplKQo+IC0JCSptZXRhZGF0YV9zaXplID0gYm8t
Pm1ldGFkYXRhX3NpemU7Cj4gICAJaWYgKG1ldGFkYXRhX2J1ZmZlcikKPiAgIAkJciA9IGFtZGdw
dV9ib19nZXRfbWV0YWRhdGEoYm8sIG1ldGFkYXRhX2J1ZmZlciwgYnVmZmVyX3NpemUsCj4gICAJ
CQkJCSAgIG1ldGFkYXRhX3NpemUsICZtZXRhZGF0YV9mbGFncyk7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IGluZGV4IGJkODlkNDRhMWYyZi4uYWMwZTFj
ZDgzODU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
Ywo+IEBAIC03Nyw2ICs3Nyw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9ib19kZXN0cm95KHN0cnVj
dCB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHRiby0+YmRldik7Cj4gICAJc3RydWN0IGFtZGdwdV9i
byAqYm8gPSB0dG1fdG9fYW1kZ3B1X2JvKHRibyk7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIg
KnVibzsKPgo+ICAgCWlmIChiby0+dGJvLnBpbl9jb3VudCA+IDApCj4gICAJCWFtZGdwdV9ib19z
dWJ0cmFjdF9waW5fc2l6ZShibyk7Cj4gQEAgLTk0LDcgKzk1LDExIEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV9ib19kZXN0cm95KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+ICAgCX0KPiAg
IAlhbWRncHVfYm9fdW5yZWYoJmJvLT5wYXJlbnQpOwo+Cj4gLQlrZnJlZShiby0+bWV0YWRhdGEp
Owo+ICsJaWYgKGJvLT50Ym8udHlwZSA9PSB0dG1fYm9fdHlwZV9kZXZpY2UpIHsKPiArCQl1Ym8g
PSB0b19hbWRncHVfYm9fdXNlcihibyk7Cj4gKwkJa2ZyZWUodWJvLT5tZXRhZGF0YSk7Cj4gKwl9
Cj4gKwoKQXQgc29tZSBwb2ludCB3ZSBtaWdodCBuZWVkIHRvIGltcHJvdmUgdGhpcyBhbmQgdXNl
IHNvbWV0aGluZyBsaWtlIAphbWRncHVfYm9fZGVzdHJveV91c2VyKCksIGJ1dCBmb3Igbm93IHRo
ZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogCkNocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4uCgpUaGFua3MsCkNocmlzdGlhbi4KCj4gICAJa2ZyZWUoYm8pOwo+ICAgfQo+
Cj4gQEAgLTExNjAsMTIgKzExNjUsMTUgQEAgaW50IGFtZGdwdV9ib19mYmRldl9tbWFwKHN0cnVj
dCBhbWRncHVfYm8gKmJvLAo+ICAgaW50IGFtZGdwdV9ib19zZXRfdGlsaW5nX2ZsYWdzKHN0cnVj
dCBhbWRncHVfYm8gKmJvLCB1NjQgdGlsaW5nX2ZsYWdzKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7Cj4gKwlzdHJ1
Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPgo+ICsJQlVHX09OKGJvLT50Ym8udHlwZSAhPSB0dG1f
Ym9fdHlwZV9kZXZpY2UpOwo+ICAgCWlmIChhZGV2LT5mYW1pbHkgPD0gQU1ER1BVX0ZBTUlMWV9D
WiAmJgo+ICAgCSAgICBBTURHUFVfVElMSU5HX0dFVCh0aWxpbmdfZmxhZ3MsIFRJTEVfU1BMSVQp
ID4gNikKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4KPiAtCWJvLT50aWxpbmdfZmxhZ3MgPSB0aWxp
bmdfZmxhZ3M7Cj4gKwl1Ym8gPSB0b19hbWRncHVfYm9fdXNlcihibyk7Cj4gKwl1Ym8tPnRpbGlu
Z19mbGFncyA9IHRpbGluZ19mbGFnczsKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPgo+IEBAIC0xMTc5
LDEwICsxMTg3LDE0IEBAIGludCBhbWRncHVfYm9fc2V0X3RpbGluZ19mbGFncyhzdHJ1Y3QgYW1k
Z3B1X2JvICpibywgdTY0IHRpbGluZ19mbGFncykKPiAgICAqLwo+ICAgdm9pZCBhbWRncHVfYm9f
Z2V0X3RpbGluZ19mbGFncyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdTY0ICp0aWxpbmdfZmxhZ3Mp
Cj4gICB7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPiArCj4gKwlCVUdfT04oYm8t
PnRiby50eXBlICE9IHR0bV9ib190eXBlX2RldmljZSk7Cj4gICAJZG1hX3Jlc3ZfYXNzZXJ0X2hl
bGQoYm8tPnRiby5iYXNlLnJlc3YpOwo+ICsJdWJvID0gdG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+
Cj4gICAJaWYgKHRpbGluZ19mbGFncykKPiAtCQkqdGlsaW5nX2ZsYWdzID0gYm8tPnRpbGluZ19m
bGFnczsKPiArCQkqdGlsaW5nX2ZsYWdzID0gdWJvLT50aWxpbmdfZmxhZ3M7Cj4gICB9Cj4KPiAg
IC8qKgo+IEBAIC0xMjAxLDEzICsxMjEzLDE2IEBAIHZvaWQgYW1kZ3B1X2JvX2dldF90aWxpbmdf
ZmxhZ3Moc3RydWN0IGFtZGdwdV9ibyAqYm8sIHU2NCAqdGlsaW5nX2ZsYWdzKQo+ICAgaW50IGFt
ZGdwdV9ib19zZXRfbWV0YWRhdGEgKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB2b2lkICptZXRhZGF0
YSwKPiAgIAkJCSAgICB1aW50MzJfdCBtZXRhZGF0YV9zaXplLCB1aW50NjRfdCBmbGFncykKPiAg
IHsKPiArCXN0cnVjdCBhbWRncHVfYm9fdXNlciAqdWJvOwo+ICAgCXZvaWQgKmJ1ZmZlcjsKPgo+
ICsJQlVHX09OKGJvLT50Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9kZXZpY2UpOwo+ICsJdWJvID0g
dG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+ICAgCWlmICghbWV0YWRhdGFfc2l6ZSkgewo+IC0JCWlm
IChiby0+bWV0YWRhdGFfc2l6ZSkgewo+IC0JCQlrZnJlZShiby0+bWV0YWRhdGEpOwo+IC0JCQli
by0+bWV0YWRhdGEgPSBOVUxMOwo+IC0JCQliby0+bWV0YWRhdGFfc2l6ZSA9IDA7Cj4gKwkJaWYg
KHViby0+bWV0YWRhdGFfc2l6ZSkgewo+ICsJCQlrZnJlZSh1Ym8tPm1ldGFkYXRhKTsKPiArCQkJ
dWJvLT5tZXRhZGF0YSA9IE5VTEw7Cj4gKwkJCXViby0+bWV0YWRhdGFfc2l6ZSA9IDA7Cj4gICAJ
CX0KPiAgIAkJcmV0dXJuIDA7Cj4gICAJfQo+IEBAIC0xMjE5LDEwICsxMjM0LDEwIEBAIGludCBh
bWRncHVfYm9fc2V0X21ldGFkYXRhIChzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdm9pZCAqbWV0YWRh
dGEsCj4gICAJaWYgKGJ1ZmZlciA9PSBOVUxMKQo+ICAgCQlyZXR1cm4gLUVOT01FTTsKPgo+IC0J
a2ZyZWUoYm8tPm1ldGFkYXRhKTsKPiAtCWJvLT5tZXRhZGF0YV9mbGFncyA9IGZsYWdzOwo+IC0J
Ym8tPm1ldGFkYXRhID0gYnVmZmVyOwo+IC0JYm8tPm1ldGFkYXRhX3NpemUgPSBtZXRhZGF0YV9z
aXplOwo+ICsJa2ZyZWUodWJvLT5tZXRhZGF0YSk7Cj4gKwl1Ym8tPm1ldGFkYXRhX2ZsYWdzID0g
ZmxhZ3M7Cj4gKwl1Ym8tPm1ldGFkYXRhID0gYnVmZmVyOwo+ICsJdWJvLT5tZXRhZGF0YV9zaXpl
ID0gbWV0YWRhdGFfc2l6ZTsKPgo+ICAgCXJldHVybiAwOwo+ICAgfQo+IEBAIC0xMjQ2LDIxICsx
MjYxLDI1IEBAIGludCBhbWRncHVfYm9fZ2V0X21ldGFkYXRhKHN0cnVjdCBhbWRncHVfYm8gKmJv
LCB2b2lkICpidWZmZXIsCj4gICAJCQkgICBzaXplX3QgYnVmZmVyX3NpemUsIHVpbnQzMl90ICpt
ZXRhZGF0YV9zaXplLAo+ICAgCQkJICAgdWludDY0X3QgKmZsYWdzKQo+ICAgewo+ICsJc3RydWN0
IGFtZGdwdV9ib191c2VyICp1Ym87Cj4gKwo+ICAgCWlmICghYnVmZmVyICYmICFtZXRhZGF0YV9z
aXplKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPgo+ICsJQlVHX09OKGJvLT50Ym8udHlwZSAhPSB0
dG1fYm9fdHlwZV9kZXZpY2UpOwo+ICsJdWJvID0gdG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+ICAg
CWlmIChidWZmZXIpIHsKPiAtCQlpZiAoYnVmZmVyX3NpemUgPCBiby0+bWV0YWRhdGFfc2l6ZSkK
PiArCQlpZiAoYnVmZmVyX3NpemUgPCB1Ym8tPm1ldGFkYXRhX3NpemUpCj4gICAJCQlyZXR1cm4g
LUVJTlZBTDsKPgo+IC0JCWlmIChiby0+bWV0YWRhdGFfc2l6ZSkKPiAtCQkJbWVtY3B5KGJ1ZmZl
ciwgYm8tPm1ldGFkYXRhLCBiby0+bWV0YWRhdGFfc2l6ZSk7Cj4gKwkJaWYgKHViby0+bWV0YWRh
dGFfc2l6ZSkKPiArCQkJbWVtY3B5KGJ1ZmZlciwgdWJvLT5tZXRhZGF0YSwgdWJvLT5tZXRhZGF0
YV9zaXplKTsKPiAgIAl9Cj4KPiAgIAlpZiAobWV0YWRhdGFfc2l6ZSkKPiAtCQkqbWV0YWRhdGFf
c2l6ZSA9IGJvLT5tZXRhZGF0YV9zaXplOwo+ICsJCSptZXRhZGF0YV9zaXplID0gdWJvLT5tZXRh
ZGF0YV9zaXplOwo+ICAgCWlmIChmbGFncykKPiAtCQkqZmxhZ3MgPSBiby0+bWV0YWRhdGFfZmxh
Z3M7Cj4gKwkJKmZsYWdzID0gdWJvLT5tZXRhZGF0YV9mbGFnczsKPgo+ICAgCXJldHVybiAwOwo+
ICAgfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBpbmRl
eCAwNmI2ZmEzNWRiOTkuLjI1NDExYjJjNGRkOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBAQCAtOTIsMTAgKzkyLDYgQEAgc3RydWN0IGFtZGdw
dV9ibyB7Cj4gICAJc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0CXRibzsKPiAgIAlzdHJ1Y3QgdHRt
X2JvX2ttYXBfb2JqCQlrbWFwOwo+ICAgCXU2NAkJCQlmbGFnczsKPiAtCXU2NAkJCQl0aWxpbmdf
ZmxhZ3M7Cj4gLQl1NjQJCQkJbWV0YWRhdGFfZmxhZ3M7Cj4gLQl2b2lkCQkJCSptZXRhZGF0YTsK
PiAtCXUzMgkJCQltZXRhZGF0YV9zaXplOwo+ICAgCXVuc2lnbmVkCQkJcHJpbWVfc2hhcmVkX2Nv
dW50Owo+ICAgCS8qIHBlciBWTSBzdHJ1Y3R1cmUgZm9yIHBhZ2UgdGFibGVzIGFuZCB3aXRoIHZp
cnR1YWwgYWRkcmVzc2VzICovCj4gICAJc3RydWN0IGFtZGdwdV92bV9ib19iYXNlCSp2bV9ibzsK
PiAtLQo+IDIuMzAuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
