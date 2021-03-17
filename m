Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55081C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 09:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F136964F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 09:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F136964F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31C76E506;
	Wed, 17 Mar 2021 09:46:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9591E6E506
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 09:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCcFdAw8PTfD+tiq7BwOSQAoiyRChB6T548UMKNtEsJTZGOutOmF04DCdwFrSMZbCpdzZtFfQk3MTuvW0oFIjVBR+7G4X11VYYNZRbtXQamgsfFUgIYZaYj2/WGsocsGqI9ISZDlVg1K0qzIzzrZfKl2sf4WipLi0t4/9s7xVqAPNugDQnVg0OkKQyGh6cyF/9uL0fnFLfZRAOUO0lW5SkklQvJN5Vy1UdolEyTua5/0R/BbzzLNFgCyHDIFzJl28YqF+aBnkUVrUEWBkFhGq4lqcxF750LrHihGQQe3fgJ0OKIADnXVjVJWJjC+qG+blBbbEWymsMZKckm5Jnk9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q24GuvnkbK5Mo5XLJY1hUri7EGczOmyclZKZvyB8TMM=;
 b=Fbg4t96SucX6YX+ZzDWbKoX7vFJxT3N7ufJ3RahDmir053YBu7AanCQfimm5d4F4aopTipA9iXahbTQnUtnEKxay3Xpv8sHpaHUHYASoFJ//xSjM/2rEb84i8lkOvTDd2bAPtsxZybnvAb8268S2yUULJfIlcT1nPE93WQU664V47Pw5VHcvEBmlgfooExoyiSjNSw1DeHXzjsE+lTwRyajknVPYtWKzrpEJj33gNZ/vD8oN+pBD1/AJDj2nodsFOYOefyQwd7TPRQS/gNMLEceZ08srCCUo7GmeoszAwZvtDw9JiCY91seJFXdx6+n3fHQPxgsJZrwFIwauXIyqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q24GuvnkbK5Mo5XLJY1hUri7EGczOmyclZKZvyB8TMM=;
 b=AoIBXrzW8DGzBfjbonLfXU/HakFwV6/10MyychoQWIjoMmTZwLzRP1DvTWgtEt4LQyTfSAi2vRP5Zb+1wTsFoJv0pfaFvC2w+e6ySq2dELMTMGQO0rD4kqpoaIIZd3W6KPvkShiIOssbCzfYMRBmoZiyWqGD/ovwDWdiUHO2AfM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2483.namprd12.prod.outlook.com (2603:10b6:207:4c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 09:46:08 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 09:46:08 +0000
Subject: Re: [PATCH] radeon: use kvcalloc for relocs and chunks
To: Chen Li <chenli@uniontech.com>
References: <87czvyz4dd.wl-chenli@uniontech.com>
 <03eefbb1-4d33-8a96-a53c-df1654a7d3f6@amd.com>
 <87blbiyw6o.wl-chenli@uniontech.com> <87a6r2yv7s.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <57ca491a-724f-95b5-ba31-bfd05ae36b05@amd.com>
Date: Wed, 17 Mar 2021 10:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <87a6r2yv7s.wl-chenli@uniontech.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM0PR08CA0007.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM0PR08CA0007.eurprd08.prod.outlook.com (2603:10a6:208:d2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 09:46:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 275b32bc-90bf-4e1b-8966-08d8e9297d90
X-MS-TrafficTypeDiagnostic: BL0PR12MB2483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB248387BD30C2C8436BA6ACDA836A9@BL0PR12MB2483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYu7K3tCvP/ZfYx6aymO6DWCpkLOU7Dl+q6T6pW+/MYple3RwpQ45P9NvYYdGfcSN8Sgq5ZRzRpA2grtPeH1Cul7Fw4kg54Ey4EetQjNfsSllfoUA2tL8IAzUVpqoJEpBSfOn/o583qCfDnl6yXuYY6ssXy7GkuADe/xvVAR38meMirYuBWhUVbV5J1CL5wXwkt5Ogt5teM2eST3PdtQ0vcm7uF2JqDEnXh+4HR08S7pdZvxFmKMu/t/gM/S5W5bPhdUWEhjPv4hzoLjBol3oCuZPGD+umVnXTnLYq7HARYqW/uPGQHS/hGR5S0PBNGK6R0jFb8YgOzgWrd05LhaupLlsSY7gZPb5iRg8qRl3Pzj+NKcIvp3VC2MhgTUz309TUyJi13xwt0Z5OxHOFfX3KElgCYQOTmxkg2UbWXOoCJw0DSy2YEwDZMz7uvsJcxoDG4b1X5CFCI6V61TBe0ho2bvsQ3wwnxH+bUVTT+ACqnEB3FOkRoWvUtCf0DXBLcz45azd8zd/HCfMsKLISCz0L+OTH6gwm31Sik8FLEJyGIKx5hWCLVnopUBdFzL4eJNmhm7aFFaOi6cUbt2gfQHJ60mUjIUrM5alXfm+nHnuVm163xzpqE4NEsjH9+94eR0xVz6yl8LDFJ/9uVpK/Tyi3AF0YyPOkjoTjqV5ROMkIleb52t3JKPLP3Q2cRlYYMGX5qTJc0jtfZfEkPpjG3D2Ja5ds9OUMcu6c28pVDrqcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(45080400002)(6486002)(2906002)(66574015)(2616005)(478600001)(52116002)(8676002)(36756003)(66946007)(966005)(66556008)(16526019)(66476007)(4326008)(8936002)(316002)(6916009)(6666004)(186003)(5660300002)(31696002)(31686004)(83380400001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFU3citTeFhKMXNxT1NvUFkvYi9ITmtIY2l0MzZjbTYrVXc2aURlV01wRjFB?=
 =?utf-8?B?dXNlM29RdS9vRlFJQTNSQWJGQzNHVm11YUUxUlBWcUl5U3RnL3EvWFhLa0Fa?=
 =?utf-8?B?a0pYQjJXWWpiSFlxWWlvZU4wZWcyd1A2ZFlHc1dEN0dEcU5mVTRJSkhQbjRP?=
 =?utf-8?B?WDcrREE5Z0tOQUduRTlWN2NnZ3c0Mzk3RW5GTTVGTmd4dkhFVHRJempRVndH?=
 =?utf-8?B?VzJvR2hua01aMTJsdytsbTZBeFNnWTN1RmhuZGcvNW5OdWF4SlhTVmFEYzZR?=
 =?utf-8?B?UUM1TzRLd0wxL0NNTmlnYXVaWXFjM2dLK3JNbDd1YlZ6UnVmUk5nejJpdEVH?=
 =?utf-8?B?aU9JbDFONTVqUUZ1WFVEYlIrSXVXcWR6WEdpV0JFc0ZiYzFvM3piYUtiYmVu?=
 =?utf-8?B?QitPS3dqcWFKeWJ4UU5xem8yZFJpU2JSdndwQ0NqR1VWWUtWTUlEamt4a0Z5?=
 =?utf-8?B?OXlNTkgyQ3ZzcVFoTFZ1TjVlcG1CMjlEYzVtYzNRT2dlSWFJREQ4WTgvTjFv?=
 =?utf-8?B?OFg3aXlFOVMrR2FvWjZUR3o1ckNWQ0tSY2xIRzFLMXJpM2pCejRmak0vMHJR?=
 =?utf-8?B?L2NtUENWeVlSUEU5OFoyOVpCSTRDbS9OTTRDQzMxdk9EdFRIcVY4dFF3S0pW?=
 =?utf-8?B?UndFNDFlMzNFcTlSbmltSVUvbFVPcmEvWTB2b1Bmci9FSDhpMVpJQng4SkZ4?=
 =?utf-8?B?REt5TGlJZ1NiLy9hVVMxNXlYa3ArMDdtWks2QWZKVW1YZC91WUtreTBIbERk?=
 =?utf-8?B?dDBPVWpyV21weE4wMkx4elZsY1ZTdkpBQ2pHeE1hZm1nVC9lMkV4N1VCSVhv?=
 =?utf-8?B?UDVXa0hram1MQU5vbDYwL2lVenJSNWE1cGtubDRRR3o0RGNzMk5QSzdGUWZk?=
 =?utf-8?B?OUVHZnYwbTMyRzRrdjRuVU9oL3M2TXlTdlo2cm5PUjB3ekp5K0YzQ1llYnJt?=
 =?utf-8?B?enVkOXVTZTNDVk40SVpTa3dYUVFNaVg5aTJNYmlsSGVQQ0dFTFR3cXRPeHVI?=
 =?utf-8?B?Wnh3a25WUkswY3kyMnpkb2t1RitYUldsdXVjMC81NVJRdjhJQ3pPQ25Ua25y?=
 =?utf-8?B?em1qU3c1QUpUem9ncC9mamRFR0hUd3J5ZUM2N2p4NURoc29uK25MYWRtV3Z0?=
 =?utf-8?B?UFQrT0QyaHdRdnhzQTNxdGVrL1pBejAzSTBaN0pkc2JmSm4zNEc3bUI0c2ZH?=
 =?utf-8?B?dU1WVzU4K1dSb0J6Um4rMlRaVmhrejZWekxjK0g5Z2swdlI1KzJJOUxOVnhW?=
 =?utf-8?B?VHR0ZzhTam5PYWIvNE5QdEJQL3NsV2t4azRuZ2RUSVd2SkhXZkRiS3JoREJD?=
 =?utf-8?B?cW03ZWlTMkRhUXd0N0JTWFhmSmlPK0lUVHFwV0VwVDVKOStjZGsvcEFtNUN0?=
 =?utf-8?B?eWZsc2FyaFdlOWwwMEs0Y2tLSzkrU0Y1bENLc1NHUVhnZHFibVhUYXpSSzA3?=
 =?utf-8?B?ejVOcGlLb1BwZ1hHQlExaDJpZHkvNXhBTkpOSWZpK1NtL0VrZndIQWVKMVd2?=
 =?utf-8?B?OXZxeG1TeUpuOVBUZjRPQU1laHg5dnNhb3Z6YzlHNUw0c2dGQlU3eVorSVRT?=
 =?utf-8?B?NG9YRDlHYVhXSEk1VHJtTmhnTnpmbHFIUllVZTE0RkUxOExzQW15UzNKQmEz?=
 =?utf-8?B?elVoL2I0dS9VbzdIS2dHR24xQkI2SURrRnhRN213UVZ1MDhLeW5MSlFSaHNS?=
 =?utf-8?B?Qzdpc1JUQUxVSDF4Z3ZwanRLRHF0eGFpRFExb1ZOODdtWjltYWN5ZEY0U05s?=
 =?utf-8?B?ZDU3S29CSkNweVZFWlkzREF0d1JmZVRsa1MxV2F3dkN0RFpzK2ZmdEVaYnMx?=
 =?utf-8?B?bW10Ky9ZMDRQU1lRMk5iL0Z1NDArY2YyeFFzbitwTVFlbVZzRHRzRjFuZ2ZC?=
 =?utf-8?Q?3KHYzp9UFuYqg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275b32bc-90bf-4e1b-8966-08d8e9297d90
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 09:46:08.5578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orxiYJQziUmp1NH7JwZ9n6Bpk1ebb3dPQe59CiC9DBRk8hjHYqZg0w262txAbS74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2483
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNy4wMy4yMSB1bSAxMDo0MCBzY2hyaWViIENoZW4gTGk6Cj4gT24gV2VkLCAxNyBNYXIg
MjAyMSAxNzoxOToxMSArMDgwMCwKPiBDaGVuIExpIHdyb3RlOgo+PiBPbiBXZWQsIDE3IE1hciAy
MDIxIDE1OjU1OjQ3ICswODAwLAo+PiBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTcu
MDMuMjEgdW0gMDc6MjIgc2NocmllYiBDaGVuIExpOgo+Pj4+IGt2bWFsbG9jX2FycmF5ICsgX19H
RlBfWkVSTyBpcyB0aGUgc2FtZSB3aXRoIGt2Y2FsbG9jLgo+Pj4+Cj4+Pj4gQXMgZm9yIHAtPmNo
dW5rcywgaXQgd2lsbCBiZSB1c2VkIGluOgo+Pj4+IGBgYAo+Pj4+IGlmIChpYl9jaHVuay0+a2Rh
dGEpCj4+Pj4gCQltZW1jcHkocGFyc2VyLT5pYi5wdHIsIGliX2NodW5rLT5rZGF0YSwgaWJfY2h1
bmstPmxlbmd0aF9kdyAqIDQpOwo+Pj4+IGBgYAo+Pj4+Cj4+Pj4gSWYgY2h1bmtzIGRvZXNuJ3Qg
emVybyBvdXQgd2l0aCBfX0dGUF9aRVJPLCBpdCBtYXkgcG9pbnQgdG8gc29tZXdoZXJlIGVsc2Us
IGUuZy4sCj4+Pj4gYGBgCj4+Pj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVl
c3QgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMTAwMDAKPj4+PiAuLi4KPj4+PiBwYyBp
cyBhdCBtZW1jcHkrMHg4NC8weDI1MAo+Pj4+IHJhIGlzIGF0IHJhZGVvbl9jc19pb2N0bCsweDM2
OC8weGI5MCBbcmFkZW9uXQo+Pj4+IGBgYAo+Pj4+Cj4+Pj4gYWZ0ZXIgYWxsb2NhdGluZyBjaHVu
a3Mgd2l0aCBfX0dGUF9LRVJORUwva3ZjYWxsb2MsIHRoaXMgYnVnIGlzIGZpeGVkLgo+Pj4gTkFL
IHRvIHplcm9pbmcgdGhlIGNodW5rcyBhcnJheS4KPj4+Cj4+PiBUaGF0IGFycmF5IHNob3VsZCBi
ZSBmdWxseSBpbml0aWFsaXplZCB3aXRoIGRhdGEgYmVmb3JlIHVzaW5nIGl0LCBvdGhlcndpc2Ug
d2UKPj4+IGhhdmUgYSBtdWNoIG1vcmUgc2VyaW91cyBidWcgYW5kIHplcm9pbmcgaXQgb3V0IG9u
bHkgcGFwZXJzIG92ZXIgdGhlIHJlYWwgaXNzdWUuCj4+Pgo+Pj4gSG93IGRpZCB5b3UgdHJpZ2dl
ciB0aGUgTlVMTCBwb2ludGVyIGRlcmVmIGFib3ZlPwo+PiBIaSwgQ2hyaXN0aWFuLCB0aGFua3Mg
Zm9yIHJlcGx5ISBGcm9tIHJhZGVvbl9jc19wYXJzZXJfaW5pdDoKPj4gYGBgCj4+IAlpZiAodXNl
cl9jaHVuay5jaHVua19pZCA9PSBSQURFT05fQ0hVTktfSURfSUIpIHsKPj4gCQkJaWYgKCFwLT5y
ZGV2IHx8ICEocC0+cmRldi0+ZmxhZ3MgJiBSQURFT05fSVNfQUdQKSkKPj4KPj4gICAgICAgICAg
ICAgIC8qKioqKiogY2hlbmxpOiBjaHVua3NbMF0gY29tZSBoZXJlIGFuZCBjb250aW51ZSEgKioq
KioqLwo+Pgo+PiAJCQkJY29udGludWU7Cj4+IAkJfQo+Pgo+PiAJCXAtPmNodW5rc1tpXS5rZGF0
YSA9IGt2bWFsbG9jX2FycmF5KHNpemUsIHNpemVvZih1aW50MzJfdCksIEdGUF9LRVJORUwpOwo+
PiBgYGAKPj4gSW4gbXkgY2FzZSwgY2h1bmtzWzBdIGlzIG5vdCBhbGxvY2F0ZWQgYmVjYXVzZSBp
dCBpcyBqdXN0IGdldCBjb250aW51ZWQsIHNvIGl0J3Mgbm90Cj4+IHdpcmVkIHRoYXQga2RhdGEg
aW4gIm1lbWNweShwYXJzZXItPmliLnB0ciwgaWJfY2h1bmstPmtkYXRhLCBpYl9jaHVuay0+bGVu
Z3RoX2R3ICogNCk7Igo+PiB0cmlnZ2VyIHRoZSBpbnZhbGlkIGFkZHJlc3MuCj4+ICAgICAgICAg
IAo+IEJ5IHRoZSB3YXlzLCBjaHVua3Mgd2VyZSBhbGxvY2F0ZWQgd2l0aCBrY2FsbG9jIGJlZm9y
ZSBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZnaXQua2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJG
Z2l0JTJGbmV4dCUyRmxpbnV4LW5leHQuZ2l0JTJGY29tbWl0JTJGJTNGaWQlM0QzZmNiNGYwMWRl
ZWRmYTI5MGU5MDNlMDMwOTU2YjhlMWE1Y2I3NjRmJmFtcDtkYXRhPTA0JTdDMDElN0NjaHJpc3Rp
YW4ua29lbmlnJTQwYW1kLmNvbSU3Q2EyMzg2ZjAxNmE2ZjQwZDkxMGE4MDhkOGU5MjhhODhmJTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUxNTcwODEzODg0
OTA5MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT16
dGdSd1JzUkxWJTJGVVlxYVd2Q3JROVdHRUVWaDZ4M2E0JTJGSFp5UyUyRiUyRnR0QmMlM0QmYW1w
O3Jlc2VydmVkPTAsCj4gd2hpY2ggZG8gemVybyB0aGUgY2h1bmtzIGFycmF5LCB0aGF0J3Mgd2h5
IHRoaXMgZXJyb3IgbmV2ZXIgaGFwcGVuIGJlZm9yZS4KCkFoISBJIHdhcyByZWFsbHkgd29uZGVy
aW5nIHdoeSB0aGF0IHdvcmtlZCBhbGwgdGhvc2UgeWVhcnMuCgpXZSB0cnkgdG8gYXZvaWQga2Nh
bGxvYyBhbmQgc2ltaWxhciBpbiBuZXcgY29kZSBiZWNhdXNlIGl0IGlzIG9mdGVuIHVzZWQgCmFz
IGEgd2lsZGNhcmQgdG8gcGFwZXIgb3ZlciByZWFsIHByb2JsZW1zIGFuZCBkaXNhYmxlcyBLQVNB
TiBjaGVja3MgCmV0Yy4uLiBCdXQgd2hlbiB0aGlzIGlzIGp1c3QgcmVzdG9yaW5nIG9sZCBiZWhh
dmlvciBpdCBpcyBwcm9iYWJseSBvay4KClBsZWFzZSBhZGQgYSBGaXhlczogdGFnIHBvaW50aW5n
IHRvIHRoZSBvcmlnaW5hbCBjb21taXQgd2hpY2ggaW50cm9kdWNlZCAKdGhlIHByb2JsZW0gc28g
dGhhdCBiYWNrcG9ydGVycyBjYW4gaGFuZGxlIHRoYXQgcHJvcGVybHkuCgpXaXRoIHRoYXQgZG9u
ZSB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+CgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPj4+IFRoYW5rcywKPj4+IENo
cmlzdGlhbi4KPj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBMaSA8Y2hlbmxpQHVuaW9udGVj
aC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3Mu
YyB8IDYgKysrLS0tCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYwo+Pj4+IGlu
ZGV4IGZiNzM2ZWY5ZjlhYS4uMDU5NDMxNjg5YzJkIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9jcy5jCj4+Pj4gQEAgLTkzLDggKzkzLDggQEAgc3RhdGljIGludCByYWRlb25f
Y3NfcGFyc2VyX3JlbG9jcyhzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCkKPj4+PiAgICAJcC0+
ZG1hX3JlbG9jX2lkeCA9IDA7Cj4+Pj4gICAgCS8qIEZJWE1FOiB3ZSBhc3N1bWUgdGhhdCBlYWNo
IHJlbG9jcyB1c2UgNCBkd29yZHMgKi8KPj4+PiAgICAJcC0+bnJlbG9jcyA9IGNodW5rLT5sZW5n
dGhfZHcgLyA0Owo+Pj4+IC0JcC0+cmVsb2NzID0ga3ZtYWxsb2NfYXJyYXkocC0+bnJlbG9jcywg
c2l6ZW9mKHN0cnVjdCByYWRlb25fYm9fbGlzdCksCj4+Pj4gLQkJCUdGUF9LRVJORUwgfCBfX0dG
UF9aRVJPKTsKPj4+PiArCXAtPnJlbG9jcyA9IGt2Y2FsbG9jKHAtPm5yZWxvY3MsIHNpemVvZihz
dHJ1Y3QgcmFkZW9uX2JvX2xpc3QpLAo+Pj4+ICsJCQlHRlBfS0VSTkVMKTsKPj4+PiAgICAJaWYg
KHAtPnJlbG9jcyA9PSBOVUxMKSB7Cj4+Pj4gICAgCQlyZXR1cm4gLUVOT01FTTsKPj4+PiAgICAJ
fQo+Pj4+IEBAIC0yOTksNyArMjk5LDcgQEAgaW50IHJhZGVvbl9jc19wYXJzZXJfaW5pdChzdHJ1
Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCwgdm9pZCAqZGF0YSkKPj4+PiAgICAJfQo+Pj4+ICAgIAlw
LT5jc19mbGFncyA9IDA7Cj4+Pj4gICAgCXAtPm5jaHVua3MgPSBjcy0+bnVtX2NodW5rczsKPj4+
PiAtCXAtPmNodW5rcyA9IGt2bWFsbG9jX2FycmF5KHAtPm5jaHVua3MsIHNpemVvZihzdHJ1Y3Qg
cmFkZW9uX2NzX2NodW5rKSwgR0ZQX0tFUk5FTCk7Cj4+Pj4gKwlwLT5jaHVua3MgPSBrdmNhbGxv
YyhwLT5uY2h1bmtzLCBzaXplb2Yoc3RydWN0IHJhZGVvbl9jc19jaHVuayksIEdGUF9LRVJORUwp
Owo+Pj4+ICAgIAlpZiAocC0+Y2h1bmtzID09IE5VTEwpIHsKPj4+PiAgICAJCXJldHVybiAtRU5P
TUVNOwo+Pj4+ICAgIAl9Cj4+Pgo+Pj4KPj4gUmVnYXJkcywKPj4gICAgQ2hlbiBMaQo+Pgo+Pgo+
IFJlZ2FyZHMsCj4gICAgQ2hlbiBMaQo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
