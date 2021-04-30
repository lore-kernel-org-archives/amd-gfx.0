Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC232C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 02:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854DD61420
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 02:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854DD61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98A06E41B;
	Fri, 30 Apr 2021 02:45:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EC76E41B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 02:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYG0AbumFwM/fosCcFAtqdPV6tuvbfVdo3Rdu9Y6cnNcjrbj4nLxO60mD63//LUlj4uBtnwBaQ5xkReOtRFRq0/0Zz6VSQhj4kK9pVwTztbdMywpJrf1gXQx/kOXJIdPzNy9FFr4kaHyidNJkj1tA+zJ93+0Ci+U9hSCFUerdljRnVaCH0FV4bGnpe80cxKNQMEs5LpVkZXsSKd2NEjRnH5bhEGk2WxkOnm6dNrLV0A8UMupWPpaJiGjLxQyuMui/1Xt04HFLR/fAaLSNQQ0BfpouJ1fRqEFHgkJdsZ44YROQGQsg3rU8Bm9Uwgp/+SSDAgoIZd+o9+2e52P/iOVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyoB7YQviaPymfccrphVEcPR+OvmuDXjDlacKweJ24U=;
 b=XvK3XYL54smz1RaPeNo4rLVMtYrDBvKrNVuuXiKLZ5194bhd1WT2VT86LtG9jY39nLSV0jTC5b6YY9bvE52xyqj0N9DpgOUq2NlaGnOBKp2cURehfzrW29FExVyp4WRHYPBgotY7be4Zpiu7h0mhUBYIxG+xtmC11p/NBXeNU2hSlfw41i6iStzuKVP5HXcGDhMJ9gzQ0QbIJQpAVR/Y7lg+0D7Iynm6lygPjs6RyCTuB+cZb2oul35IWIfAmJbUkDrPaOTti1R/vP92c1RsJLujo26nAApmdrTWKzNzPiEPEJuwvoR5ZtdM3AOHuyp1tssi9th6rJKTBONPpQsDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyoB7YQviaPymfccrphVEcPR+OvmuDXjDlacKweJ24U=;
 b=OYuikd+30JUO7DvnTMJJ3Ydhv2cdK9OpsWijXcA+DRQHtcnK1GA2KdiTYp2Rn6U+iaiKvoKSRJG0jkEnoai26DDxtJX9tgqJzmdJlNKGWj1oZY5vxw0BbjSizmzHfII8tlKfgQT6ZFZG0XHVCaE+LzWdBlRruoBb5G1nbPPhqrk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 02:45:48 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 02:45:48 +0000
Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
 <73D22904-489B-4F5F-ABDF-EC534F21D9F5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <199d4259-0968-863a-d321-ef5c04643b9e@amd.com>
Date: Thu, 29 Apr 2021 22:45:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <73D22904-489B-4F5F-ABDF-EC534F21D9F5@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 02:45:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc50bbfd-b344-4f8e-854f-08d90b820f95
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2353BF9C9BF279F75DE4A545925E9@BL0PR12MB2353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulWrjCp40XRsqOkxdPUgIQf9Ox6g/X0iaKjq5cLSjOR04IIhpdPa6O6908mlH7EqVO9e3SIQmnSdE3lmKNmWAPNMDatkNw0zsoj8SmGcpJkxN+S/xCGv1+6YVYzhy+42gULPrXYOkWnYYFGr7IMOz4eXlaxpgNHXX8wn1iOpoF5cU0fVuecWNboV3bgrcp1fLmq8BuVdTaKqXosyQNyt98Et5FSewetbWxkbwMQEPkaFkgbr5gYlk4fdVaNNKKUfB0UuTqEObo0Ov5X8VmBUnrbSmwbWuj/byXzs8Fgr+PWSfBH13OIjmYRUU8XjLO+bSzeij62lV0Ffk8/wxXkbLalIzxIvF8GJDqw83rzYYtA5vTBIOXdJ/v0c7wXVd/6Zmzh58ZaZ1ekCKDJqnf12fJCdLzUtH+w897A3Hn9/jwi/HwjVdGRTGh6E5qZvs7+yFm3Xgj41mNCGtfJ8OC5d6+Gx6yMgffG8RPYXXHOprpf27JldNMkH2VafxJ0YcDQ9N27Uk5NHEBMzrpqT/X4A8r1FKSYaEpnwL3gw4FwdTQUvTViNmQWn0wa2mg+XYQ6ier7MU+lo/mv66XIFBBmptGftI8mofP2PMXtnIlqwkCEbjcHbk2z/ZvtqTW8nqnUsSHH250TlZxXCjPST70P3MndN0jcf9LSgAthCxBnBWX6lLiLUsy39V+bCE1RIAQxm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(66556008)(66476007)(38100700002)(66946007)(5660300002)(956004)(86362001)(31686004)(31696002)(6486002)(478600001)(186003)(16576012)(83380400001)(2906002)(16526019)(110136005)(316002)(4326008)(8936002)(26005)(2616005)(8676002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U0VYVUJob1FuNXV6ZVhzMG5TNjh6ME5COGVxMjZHT0Z0MW10cTYrd1NGaERu?=
 =?utf-8?B?bytldTVidHlKa3dud2oycCtwTEg1ZFAvejdUTmVjc1M2SWttZUlOZjJuM1ZO?=
 =?utf-8?B?UHd6dlNWNW44MklDK2xoODB2ZE5PbFRqSWpoR0dFNDBVZlh1V25STVRlOVBW?=
 =?utf-8?B?NnpldkVzSTJjMFltdkJQVjNZWkYzN25aZytLMVNIbUh0YUdEcUZjaG1PTzY3?=
 =?utf-8?B?WG5HbzZ2YWJkQnA0V0hRRHJibmpzQlI3bHVUbXZMK1hGOEFFTitIWm93eDNM?=
 =?utf-8?B?M1VGR2xZU0t2Nmp3Z2pHRnJZcGlHb2R0dDRpemdHOSt6c0I3SHUxd3N1elQ3?=
 =?utf-8?B?R2lueVczZktuenJOSkRHUWhlNVhPTDVtQVlvalBwSWNYeml2Zm1aWVRDUnVq?=
 =?utf-8?B?SVFGenh0V1BVQjROZFBRQ0ZzWmxYT29lNHNEd3ZJdE1qbUdqdFVVa2Ewc1BM?=
 =?utf-8?B?bTRXWG1yVnJCaEs4M0I2RHdxVlBOR3dsc1dxSVBxN0gxQnQ4eWY0SFp6cnAx?=
 =?utf-8?B?MXA3UnE4MndsUTY3TjUyd05GVVgyZkh3ZkVqZ0c3aHJKdXNZMGtwQlNHanlx?=
 =?utf-8?B?MzdETzBjcXZ5QUZHY3NrNS9TWEdOai9rNDlLckJZSEpNc1ArT1M5UjhHMnZI?=
 =?utf-8?B?QmtCaG5idk53REN3RXB0NEs0cU9kajNOMXBFWGtVUm1QUnhsUUwxd0o0MXcy?=
 =?utf-8?B?Q2tOSmIvbm5KM0hsZS9zMll2dVNnYWE1am1WYThhdVROSXFFL09PU2MwOVZm?=
 =?utf-8?B?ZHhwWkZuZXRhUUdoSHh1VTVtZEw4bjQzeVpCNERBeGlyZ3REcjlrQmpIdGsw?=
 =?utf-8?B?VGFMR2E3d3VRTzBPSWUxSkxzd01sZExWUG9IWFRQWkowVXBxL2JVRzJyTXha?=
 =?utf-8?B?aW9yV3hPWXRnVzNLZUdiaG4xVTBWMys1MFVhL0lTeGdZK0hVUlhjWkNyOENh?=
 =?utf-8?B?NkY0MFhqMDBnZ1VxTTVoL09yR2ZrT2pzZTFpSk5tWU5vUXI2RXJlY1NrZlRW?=
 =?utf-8?B?VXN6RG5BQ2NYendFTHM2dU9KSnZyNkoxM0FxZllEV0lmelF1c3pIMFZjaVBl?=
 =?utf-8?B?ZFZXTFB2NkpTcWY2akt4Z25YcmM5Yk5FT2NVbHNLRnNvTURWTzZyUWhLRTNh?=
 =?utf-8?B?UDMyNWFJWEQrNkhyWU5HK05wWnhiRHBSNEYvR2kzYm1JdnZBUVh2bzVCcWdh?=
 =?utf-8?B?YkhRNk1BM0hVekFQWkZXbUhLNnRQWWhLTXBzMG1OWWhRaU1BTnR4K00ydkJs?=
 =?utf-8?B?dSs4Z0xCOGZvSWlQaytSNm5wSW9DbTdITEpFem90Q2F0bExiekhIMEFoSUZQ?=
 =?utf-8?B?S2E5blBSblFSeWNPWEJhY2tDQnBQUElNeWNYUmgwMXRzNnV0YlQxRHNtek8r?=
 =?utf-8?B?TFlWTlVQamc5VEFPekp5RzBMcncybjBCeHA3S3laQm5FS0Q2RStpZUcxU3Bk?=
 =?utf-8?B?WkVlRlordnVjVTZMVWsrK0sraWRGWUQwZ3o3SFVHRlNtUVRuZE41S1BIejRO?=
 =?utf-8?B?aVJZVVYrTHdxYjE4QmJvYmxpa2ZsQjl0TFBnT1RsQlh6L2d3eGEzZXUxVWl1?=
 =?utf-8?B?RkU5UG1JeW5NODJxSEp0d1V4dVMyWnlrUTUxNEh1V3B6QTY5ZFZEMjNOeUtZ?=
 =?utf-8?B?VlZGTDh6ZXN3NlVmRUUrSmNpWkNYNkZNTlhuYXhBV2hsTExSYnpnZ2M2eGFC?=
 =?utf-8?B?VWlHalFSRTJBV1lzZTJHbWYxelZSVTNDWFgxQVVneFk4UE9CVStlV3pLUFha?=
 =?utf-8?Q?bGuOFP3g7tAFV9PTuwJe3FgR1J4Ia8iEt15K3iH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc50bbfd-b344-4f8e-854f-08d90b820f95
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 02:45:48.7056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vac5waD9VRKWYF5GtXl3kQ65wtV9PWyQvBTJC5IgAz3y3BMzEUeh2DXK7Awho8Dx7sdUDoa5RiKL/CbwMZcpmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDQtMjkgdW0gOToxMiBwLm0uIHNjaHJpZWIgWmVuZywgT2FrOgo+IEkgdGhpbmsg
cGFydCBvZiB0aGlzIGNhbiBiZSBkb25lIG1vcmUgY2xlYW4gaW4gYW1kZ3B1X2RldmljZV9pbml0
Ogo+Cj4gCXIgPSAwOwo+IAlJZiAoIWFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUpCj4g
CQkvKiBlbmFibGUgUENJRSBhdG9taWMgb3BzICovCj4gCQlyID0gcGNpX2VuYWJsZV9hdG9taWNf
b3BzX3RvX3Jvb3QoYWRldi0+cGRldiwKPiAJCQkJCSAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19D
T01QMzIgfAo+IAkJCQkJICBQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVA2NCk7Cj4gCWlmIChy
KSB7Cj4gCQlhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCA9IGZhbHNlOwo+IAkJRFJNX0lORk8o
IlBDSUUgYXRvbWljIG9wcyBpcyBub3Qgc3VwcG9ydGVkXG4iKTsKPiAJfSBlbHNlIHsKPiAJCWFk
ZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0ID0gdHJ1ZTsKPiAJfQoKVGhpcyBjb2RlIGlzIGFscmVh
ZHkgaW4gYW1kZ3B1X2RldmljZV9pbml0LiBJJ20gbm90IHN1cmUgd2hhdCdzIHlvdXIKcG9pbnQu
IEFyZSB5b3Ugc3VnZ2VzdGluZyB0aGF0IHRoZSB0b3BvbG9neSBmbGFncyBzaG91bGQgYmUgdXBk
YXRlZCBpbgphbWRncHVfZGV2aWNlX2luaXQ/IFRoYXQncyBub3QgcmVhbGx5IHBvc3NpYmxlIGJl
Y2F1c2UgdGhlIEtGRCB0b3BvbG9neQpkYXRhIHN0cnVjdHVyZXMgZG9uJ3QgZXhpc3QgYXQgdGhh
dCB0aW1lICh0aGV5IGRvIG9ubHkgYWZ0ZXIgdGhlIGNhbGwgdG8KYW1kZ3B1X2RldmljZV9pcF9p
bml0KSBhbmQgdGhlIGRhdGEgc3RydWN0dXJlcyBhcmUgbm90IGtub3duIGluCmFtZGdwdV9kZXZp
Y2UuYy4gSXQncyBjbGVhbmVyIHRvIGtlZXAgdGhpcyBjb21wYXJ0bWVudGFsaXplZCBpbgprZmRf
dG9wb2xvZ3kuYy4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiBSZWdhcmRzLAo+IE9hayAKPgo+ICAK
Pgo+IO+7v09uIDIwMjEtMDQtMjksIDU6MzYgQU0sICJLaW0sIEpvbmF0aGFuIiA8Sm9uYXRoYW4u
S2ltQGFtZC5jb20+IHdyb3RlOgo+Cj4gICAgIExpbmsgYXRvbWljcyBzdXBwb3J0IG92ZXIgeEdN
SSBzaG91bGQgYmUgcmVwb3J0ZWQgaW5kZXBlbmRlbnRseSBvZiBQQ0llLgo+Cj4gICAgIFNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+Cj4gICAgIFRlc3Rl
ZC1ieTogUmFtZXNoIEVycmFib2x1IDxyYW1lc2guZXJyYWJvbHVAYW1kLmNvbT4KPiAgICAgLS0t
Cj4gICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDI5ICsr
KysrKysrKysrKysrLS0tLS0tLS0tCj4gICAgICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiAgICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmMKPiAgICAgaW5kZXggMDgzYWM5YmFiZmE4Li4zMDQzMGFlZmNmYzcgMTAw
NjQ0Cj4gICAgIC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5j
Cj4gICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4g
ICAgIEBAIC0xMTk2LDYgKzExOTYsNyBAQCBzdGF0aWMgdm9pZCBrZmRfZmlsbF9pb2xpbmtfbm9u
X2NyYXRfaW5mbyhzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqZGV2KQo+ICAgICAgewo+ICAg
ICAgCXN0cnVjdCBrZmRfaW9saW5rX3Byb3BlcnRpZXMgKmxpbmssICpjcHVfbGluazsKPiAgICAg
IAlzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqY3B1X2RldjsKPiAgICAgKwlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldjsKPiAgICAgIAl1aW50MzJfdCBjYXA7Cj4gICAgICAJdWludDMyX3Qg
Y3B1X2ZsYWcgPSBDUkFUX0lPTElOS19GTEFHU19FTkFCTEVEOwo+ICAgICAgCXVpbnQzMl90IGZs
YWcgPSBDUkFUX0lPTElOS19GTEFHU19FTkFCTEVEOwo+ICAgICBAQCAtMTIwMywxOCArMTIwNCwy
NCBAQCBzdGF0aWMgdm9pZCBrZmRfZmlsbF9pb2xpbmtfbm9uX2NyYXRfaW5mbyhzdHJ1Y3Qga2Zk
X3RvcG9sb2d5X2RldmljZSAqZGV2KQo+ICAgICAgCWlmICghZGV2IHx8ICFkZXYtPmdwdSkKPiAg
ICAgIAkJcmV0dXJuOwo+Cj4gICAgIC0JcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoZGV2LT5n
cHUtPnBkZXYsCj4gICAgIC0JCQlQQ0lfRVhQX0RFVkNBUDIsICZjYXApOwo+ICAgICAtCj4gICAg
IC0JaWYgKCEoY2FwICYgKFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDMyIHwKPiAgICAgLQkJ
ICAgICBQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVA2NCkpKQo+ICAgICAtCQljcHVfZmxhZyB8
PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8Cj4gICAgIC0JCQlDUkFUX0lP
TElOS19GTEFHU19OT19BVE9NSUNTXzY0X0JJVDsKPiAgICAgKwlhZGV2ID0gKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICopKGRldi0+Z3B1LT5rZ2QpOwo+ICAgICArCWlmICghYWRldi0+Z21jLnhnbWku
Y29ubmVjdGVkX3RvX2NwdSkgewo+ICAgICArCQlwY2llX2NhcGFiaWxpdHlfcmVhZF9kd29yZChk
ZXYtPmdwdS0+cGRldiwKPiAgICAgKwkJCQlQQ0lfRVhQX0RFVkNBUDIsICZjYXApOwo+ICAgICAr
Cj4gICAgICsJCWlmICghKGNhcCAmIChQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVAzMiB8Cj4g
ICAgICsJCQkgICAgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KSkpCj4gICAgICsJCQlj
cHVfZmxhZyB8PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8Cj4gICAgICsJ
CQkJQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7Cj4gICAgICsJfQo+Cj4gICAg
IC0JaWYgKCFkZXYtPmdwdS0+cGNpX2F0b21pY19yZXF1ZXN0ZWQgfHwKPiAgICAgLQkgICAgZGV2
LT5ncHUtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSA9PSBDSElQX0hBV0FJSSkKPiAgICAgLQkJ
ZmxhZyB8PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8Cj4gICAgIC0JCQlD
UkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzY0X0JJVDsKPiAgICAgKwlpZiAoIWFkZXYtPmdt
Yy54Z21pLm51bV9waHlzaWNhbF9ub2Rlcykgewo+ICAgICArCQlpZiAoIWRldi0+Z3B1LT5wY2lf
YXRvbWljX3JlcXVlc3RlZCB8fAo+ICAgICArCQkJCWRldi0+Z3B1LT5kZXZpY2VfaW5mby0+YXNp
Y19mYW1pbHkgPT0KPiAgICAgKwkJCQkJCQlDSElQX0hBV0FJSSkKPiAgICAgKwkJCWZsYWcgfD0g
Q1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9CSVQgfAo+ICAgICArCQkJCUNSQVRfSU9M
SU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOwo+ICAgICArCX0KPgo+ICAgICAgCS8qIEdQVSBv
bmx5IGNyZWF0ZXMgZGlyZWN0IGxpbmtzIHNvIGFwcGx5IGZsYWdzIHNldHRpbmcgdG8gYWxsICov
Cj4gICAgICAJbGlzdF9mb3JfZWFjaF9lbnRyeShsaW5rLCAmZGV2LT5pb19saW5rX3Byb3BzLCBs
aXN0KSB7Cj4gICAgIC0tIAo+ICAgICAyLjE3LjEKPgo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
