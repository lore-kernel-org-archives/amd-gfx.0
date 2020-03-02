Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C366FC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9421C21739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UbITncri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9421C21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606CA6E858;
	Mon,  2 Mar 2020 21:48:02 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3036E858
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT1HRsxYXwEEHLzxav0FYmnoX9slNgcAPItR9WxtCdtCLtbTU4+7A/yEPeiqucK/pj34WmWB6j99H6AWmSoWL0BlUm95/A63kkKXDcLlE9/oxuGWS6ILyeHsDKTJXD5syXQdEGwaRLJP1NRaXe4yTWUdxOVNk66GRUMyHXESjILuBzf9sMVF65LUbJJf7hW3umQJlaZSXKd9ozjikv9x5xx5Edey6oqn405OiBijt2gtfg2HPihfha2FxKHS5K2RlELIWgHkgDJoPSZ528IKtV2RTnkyGm4GX+jM1wsoHhfvQVYBJGZPRk/u0NreaXmQEhf7YmPicXfe29RMEK79FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFsRsEX4S2OmksG6rei8HQCVYPhZF9UDFmZUr4mPNNE=;
 b=isT/Lati3X3VA5RP8luH00Rap+vUhyN1KXAloZKZVmhM8P4wTjvf9tiS+lJSqczLjMn72URj4nrz29lwQMoR1wdTJOhJv2nhEnfmyVrhsE8lT7Q8zIs2Ak0bYXn62e3ATIeH4U8jeeKlP235dJgZLaWRDuhaA99NSP57iSugykVJVIljYYe9dU3bZt4u3C3P5J/5Myp4UhqAt3SPYYZsKTKY1wJH+ZQvIOCZ+qdwuF+3H7K2C/lB0F8BABRAEUI1gsOPeSnjjHmsHZTuenBt4ozwjzLjhoEUcb+eRyA0PSA7i0/Vnm2nq9a9oV7d/vPJDRaWlRQQEIRVWCgl5XFVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFsRsEX4S2OmksG6rei8HQCVYPhZF9UDFmZUr4mPNNE=;
 b=UbITncrioiYZykX4+8txzkcemCq5ZzzidBrOT3TEYN1gG0TgGrpwsHt6yPI9GfTd20WngioVVwlcDYqWkoHqVeeIA2ddn228bA1H7CrtHBNtWO6BQnZZHI5Eym375JNrA0CIJxiPUFyHyhGE0f6Xlr90FDv3llpOUfnjhqbsHrk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 21:47:59 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 21:47:59 +0000
Subject: Re: Few TMZ BO move patches
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200302121759.13003-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <bb3600de-0448-667b-c3c0-eaaf6292f447@amd.com>
Date: Mon, 2 Mar 2020 16:47:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200302121759.13003-1-christian.koenig@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 21:47:58 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6d40a45-8f80-4e88-40a5-08d7bef35fbc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:
X-Microsoft-Antispam-PRVS: <DM6PR12MB336956C6D4196AA9C063691C99E70@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(966005)(4744005)(478600001)(45080400002)(31686004)(316002)(86362001)(31696002)(81156014)(8936002)(81166006)(8676002)(2616005)(44832011)(956004)(36756003)(2906002)(6512007)(16526019)(186003)(26005)(6486002)(52116002)(66946007)(53546011)(66556008)(5660300002)(6506007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3369;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKpx2tFmSb9fWvpGV77MQ4NEHQV4+cdM1Qw6PdQz5WllAYVxxN1Dq2GpC9SRWamhihxC93z8BT53okJ5edf5sdYN03nOpeqwOJhGC6sT6Tr4B0+AaLO7g4K0Cn+PF6HmcvuNGi9x0ebz2S/p202Y4UJ8YyALChqCxbCb52RFJhDVSr1e6L7oQyqIw3xvzCW9wMEPHGelFRiKlcszZwZ8Q0Pe/cSo89K+d/DoThwo3ossjWjt5ubKMuDg5w0YoXp1/B7rFGo+M4unGXC/xfm4b0n5/Ep9dudV5hd2vKFFMu5vAeZtVoQu3Ghr9yu3VeUmHYQac9WzxskZtUbV8HaTu201pokFVn52ZbfCiik26V/MplDvjxxgex4nxER9YR2FkLBdYp4ZfP0PwlRM5DhyKc/EF/WNo6xCUNv4ExUo1W32pwjqNtXVKJyvxu8I7IFuKGcKsqmISS3M4YDDld5u0hVWpBhrDtl6EhH+Tu3UVow=
X-MS-Exchange-AntiSpam-MessageData: yMikAvA2DQsZjsO/ptBL00iBseN0X/G0NHgzqMr9JIdkuMIK63jt11ZHJox7MeesuvV8WddmaQ/mbG/2mD267nUjWaZ+qbtULtcf2k79Yu227Rf257xGmj8UWfxiTfwuA2NaFJbUyYuhrA8fDIvCqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d40a45-8f80-4e88-40a5-08d7bef35fbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:47:58.9797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGHA81KXrdsmVhdvPQk+OCrbPW9c2E94Nyrh2nUdsjC74JT09sALuxcWu0MCTT7N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIENocmlzdGlhbi4gSSdsbCB0YWtlIGEgbG9vayBhbmQgcGxheSB3aXRoIGl0LgoKUmVn
YXJkcywKTHViZW4KCk9uIDIwMjAtMDMtMDIgNzoxNyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOgo+IEJlY2F1c2Ugb2YgYSBzaGlmdCBpbiBwcmlvcml0aWVzIEkgd29uJ3Qgd29yayBvbiBU
TVogdGhpcyB3ZWVrLgo+IAo+IFNvIGF0dGFjaGVkIGFyZSBhIGZldyBzbWFsbGVyIHBhdGNoZXMg
SSBhbHJlYWR5IHByZXBhcmVkLCBidXQgdGhlIGJvdW5jZSBjb3B5IGZvciBzeXN0ZW0gZXZpY3Rp
b24gaXMgc3RpbGwgbWlzc2luZy4KPiAKPiBQYXRjaGVzIGFyZSB0b3RhbGx5IHVudGVzdGVkLCBi
dXQgSSBhbnlib2R5IGZpbmQgdGhlbSB1c2VmdWwgZmVlbCBmcmVlIHRvIHRlc3QgYW5kIHJldmll
dyB0aGVtLgo+IAo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+IAo+IAo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3
Q2x1YmVuLnR1aWtvdiU0MGFtZC5jb20lN0NiYjBhMDRmZGUxZWE0Yjc5NjBkNDA4ZDdiZWEzYzJk
MCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxODc0ODI4
ODc1NjE5NTAmYW1wO3NkYXRhPUYxS0olMkJYJTJGMDRLa2o3V3p3NGJzYzFUWExSZUxOVmtyY3c5
UjVvaGJndk9RJTNEJmFtcDtyZXNlcnZlZD0wCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
