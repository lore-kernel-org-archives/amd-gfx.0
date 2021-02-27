Return-Path: <SRS0=9a13=H5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D333C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 03:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06A364D9A
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 03:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06A364D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366986E49D;
	Sat, 27 Feb 2021 03:56:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E642E6E499
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 03:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS61e4SM0uDLv2fYv1CZVuGiKg7LPtvw08+0CN+g01oddSXXoClAwg1BAZ4yEcZcpKnBiKQ5IVF+xfWfuZMjhEwLWw+jMOm8kkMtAkgVSGXEizIzUZonEQ7sEtAtPjSkWhXmAUEPqtBAfrd9Av/4mjjMReu98r2QxKA7oby2+ZEMLgcKG0ktN69H10YZDPItHOCMIypsYPwtVRSxPI0Zd3S41evksjqeGZWvkNaOSOL33tg3iLrlB52W2P0apkxMAzz8/hMs4gHtuyWhSumWoi3lo40fJBvQW4HxRFhoGrK94uLLWXxYrOW2SPf8NJGoX9KI6q/e367YMTqR53yMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EaOzEhhybuT9kYhiDez+sXvMW2MpnuvJan2/X++l1U=;
 b=RKYc8DovYcJy0q3A6H0Eq6c8+Brh4lHVg2NNvujFQB2ogN8kVqHz6jrTritP4K7iCm1Aoewz93NcbOLfYkaS+fXILKXALBler/OdvayStW2jbIOwc9vm35VijKHzLwAeseSwTdW/xiU1/KewkAGJgnEgdPt5Rvqn/glR1dbLgzgzQBVWuIJbcO2d2t4qNwhkUhbHuT4ocJNk+y7xO1bMZ4PdxCufeijtKHHKo6w3OWWEmZWxw6FKJpwZr1jvrm0khdqzd0OPfF/NP8OFSHcFxJoEuTAqo/rkiWkjpAoCKD5FZhTSFJ1yObVukM9/fqMJUWVnI4jCY/Pmj+czR9G/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EaOzEhhybuT9kYhiDez+sXvMW2MpnuvJan2/X++l1U=;
 b=xHq3zFaseaBXcDl4HDT5LlBMkQo7sLGTv0LNubzv/wLeSjlyyWwPatWKEOD9MZR40dCn1EeFr4Ucl4NqdoisDk6WjXWVYLMJmVPvKjGNWJtwDRsC9Ffx4uABhF7BmX8WbdoiJSuigjv0U8iOy4sCwE2APJ7Xuk0VccBoNfqVaSU=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sat, 27 Feb
 2021 03:56:22 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3868.033; Sat, 27 Feb
 2021 03:56:22 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1JGQ10gYSBuZXcgYXBwcm9hY2ggdG8gZGV0ZWN0IHdoaWNoIHJp?=
 =?gb2312?Q?ng_is_the_real_black_sheep_upon_TDR_reported?=
Thread-Topic: [RFC] a new approach to detect which ring is the real black
 sheep upon TDR reported
Thread-Index: AdcMAadhaEND07KHR4C1q7rMxPXb/AAE23MAAAgNKLAACoR3gAAXIQ1w
Date: Sat, 27 Feb 2021 03:56:22 +0000
Message-ID: <DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <eb07f03b-0ea4-f9a1-47bf-4e8b65ac7081@amd.com>
In-Reply-To: <eb07f03b-0ea4-f9a1-47bf-4e8b65ac7081@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6c8e468a-565a-429d-99f1-fe81ed5ad39c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-27T03:51:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 528e0b1d-78b3-4a57-0616-08d8dad3a5d6
x-ms-traffictypediagnostic: DM6PR12MB3865:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38651CD3B96008A357485BF4849C9@DM6PR12MB3865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: php00VpuuH7edhILvgShYm4cVslHwKYOvHb8pul92JKWZsw59e9qNvo1iXW9RIBA3lMLCRF0HmwHbP+Fk+uuUlY/md2tXWSrqA2HtvTvaUgS6U6pH9mqZ3RYi6spQnZiPBb3hJaymvBzN0+iywWHPjWBD2d8fG6HnnT58y/bIMggKfu55XGkmt8v1pNfuco+9VBk8kyqanGq4IsYmBfvCaehs9OXMQLQ6h4vcIljaYwoYVZZdHZ+X9fzDbf0anrp3VdyMzkHKE1QFbwKonywHgeBMEHibCTo/rHZGMc5/SFSrMuLQAo+lVPg8+eY2kEGJBTriobMjXG0J5it93nNpG1fvGqdSoirCi2Wrk/2TiuccywwnDBHHvbPDR9DDRtmh+WfAjXi4LnixK2LWX7m8CmcsiYyPnVvwPWCrpW6YjLiG9sQgX48bHcDfxQvQNux/vIwHG5X7uv/B2hJk/hVEaW4VJJ26UpIzsWs6w7MTxyx0fcrzwdKPUCwMPIpKpmsdou3gt4FaLapOotKYIyH100g7I5h0Cbp/FrWJjkqECvKLo/0DChY64uap8CQeRzg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(53546011)(224303003)(71200400001)(6506007)(110136005)(33656002)(54906003)(64756008)(66946007)(66476007)(76116006)(4326008)(9686003)(2906002)(55016002)(86362001)(478600001)(7696005)(66446008)(316002)(5660300002)(52536014)(26005)(966005)(8936002)(66556008)(166002)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?aFJxS3haOXlWV1JMdVYzbEluYURBbXI2TGVoUzJOdGhrMHllQVBjWnoyYU5V?=
 =?gb2312?B?S2VZUVR5MzA3SlF6dzZKN1Z3dWtHaGxlaERhT3c2ZzRETHBUK0FmS1lVOVoz?=
 =?gb2312?B?dXhBK1RSTDFhcUw1T1Zra3J1bGczRWVRNTY0bjUvYXIwN3VRdHBWUDZ0STR6?=
 =?gb2312?B?dUZqc1puSUlaTDlOZUt2MDFrOEQ0QnM3L2diSUlhVXpoQVFhdXRlYllGcDJk?=
 =?gb2312?B?Y1VJVFVwWkZISDBRaS8zYU15MndSckZDZ3V2bHpUaU5tMTVQakdjMEYrNjFy?=
 =?gb2312?B?Q3RxWUJKclpTa2lUN2RLY2JsdWJVRk1rRWM2SmNXK1NIWllJUXY2dnhOT3Aw?=
 =?gb2312?B?b1ZhYkYyUE5UeEJZcnY0M3Z4TVdTejllTlprSXRoZmJtV2FNN0NwQTJQNUx4?=
 =?gb2312?B?RUdIZEZPZ1NKRzNwSnBSQmNQRFU0aGNzVW80SGxLU2d2cHQvY3ZaTnRlY3NL?=
 =?gb2312?B?enhTRGYrUmEzYUE5T2t2MDJiZy9CUG84Y0dQS29SUlRGWFhoazQ0T29sVUl2?=
 =?gb2312?B?UnhmcE5wbXZOVU5NQkcwN3IxL1AyOU1NelJXYTFMa1lrN0tuVS9ZQlJTdDJ0?=
 =?gb2312?B?WjhMcGh3K2hsREtLcGtOZ3lSaE5ZN2doenhTZ1BHOVpSZ01nUjZFNFVMdlFa?=
 =?gb2312?B?TTA4cHdONE9CUEk2NnNxU1NKcFNBc055aUp3VUVOdmg1MVpubzBIUDlHM1dY?=
 =?gb2312?B?b1dJYVB1bHJWblBJS0c1cURPcWYxSWVHTEE4d09MS3lRWEJvUTROQUc0M1N0?=
 =?gb2312?B?Q2pmUy8rRFBoRG1kU282VW10SERYYWpvVjlnT1hINDhHdnJnL1FDZFpHWkxr?=
 =?gb2312?B?MVJkV1RaSVZLNTRoRERMdklqZXdLR0pFdGVwcWpYTTZTbzVhQzlGTWdSK256?=
 =?gb2312?B?QjBqVis3OUQ1SUpRUE5QcldLaXFIbWVzdGhSRVlqcWxmWXZzNnVXeFlqcHV4?=
 =?gb2312?B?bzJMc1BENVRQanJoOG8wMmx2ZTAzUXpkSTAxUnNEd3RDVWdqdGRXcjd6VkFu?=
 =?gb2312?B?eURPU1FoWTk4U0pFbXIraFd4ZUxzRzhhbUt6blhVZCtQbmoxRzdSVSsxMEhI?=
 =?gb2312?B?eFovUGFLWnNzanFUSDlRL2J0NDlJbnpOVkZxSmtITHFhVkR4YkZQNWs2M0tm?=
 =?gb2312?B?SVVFWUZHUjBrSFB2cDNTVnJCMENkVytxR3JRVGl5UGV3SzFrWkJtdFd3L2tY?=
 =?gb2312?B?YUNmdXZ4VEtIM0FabzRCVkNkT3FoTFJkVXc4aHBxaU02eE9iaHdqTE1kZXNR?=
 =?gb2312?B?eFFDajVrODdZMlN3aDdPRzRYS1pSR0xxYWdURVkrbkg5UW5YdmVVaXdsNGE5?=
 =?gb2312?B?b05hMXpjNFViRDNUL2M0ZHZEYTBEemp0aVlSVDZSTHBRQXpvUWxtczRmM041?=
 =?gb2312?B?Q1RiZktLVjgvSzNJaXJKaVl5Mk5Va2tPN0E0aGljWEJ1c2ZoM2Jld2NrUW82?=
 =?gb2312?B?NVpGbXQ1aERKR3NBN1V6U0JXSUlienRnaFlzcTBzbFE4ZWc3Yi80MDhUZzNr?=
 =?gb2312?B?K0NsakxhaWJ5aWxoMVpPb0FSdWF4YVY2WGY0a0VpcWlHTTNlcmpOZXc3N0dT?=
 =?gb2312?B?MWlFUjdFWkZSQ0dTc2hXTk1XM2UxelgyY29od1FGbG83eFAzeGlBWnRTYytE?=
 =?gb2312?B?ZnZhUi9oMXlrWGR4eEJ3WTJOeElOMzhVTG0xdFZFZlFsTzNBa2h1WlNUS2Yz?=
 =?gb2312?B?TWJPc0RqU3FBMWEwTmx2Z3BwUU9nL0p0d2dERHl1emYreTJDZ0RMREFMTzhS?=
 =?gb2312?Q?gHXulqwTIEhTjdamlsIAnWilJ9fVchXn4q3ilFH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528e0b1d-78b3-4a57-0616-08d8dad3a5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2021 03:56:22.6527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AwDrFexQEW2ShCH/PO8hw+tQS8QvYpQM8ybHHic695xMUB7jsYRX6aOnL5w9het
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1078174031=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1078174031==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1708A26CFB637B10A7C7F6B7849C9DM5PR12MB1708namp_"

--_000_DM5PR12MB1708A26CFB637B10A7C7F6B7849C9DM5PR12MB1708namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
IEFuZHJleQ0KDQpUaGUgc2NlbmFyaW8gSSBoaXQgaGVyZSBpcyBub3QgdGhlIG9uZSB5b3UgbWVu
dGlvbmVkLCBsZXQgbWUgZXhwbGFpbiBpdCB3aXRoIG1vcmUgZGV0YWlscyBieSBhbm90aGVyIG11
Y2ggZWFzaWVyIHVuZGVyc3Rvb2QgZXhhbXBsZToNCg0KQ29uc2lkZXIgcmluZyB5b3UgaGF2ZSBh
IGpvYjEgb24gS0NRLCBidXQgdGhlIHRpbWVvdXQgb2YgS0NRIGlzIDYwIHNlY29uZHMgKGp1c3Qg
Zm9yIGV4YW1wbGUpDQpZb3UgYWxzbyBoYXZlIGEgam9iMiBvbiBHRlggcmluZywgYW5kIHRoZSB0
aW1lb3V0IG9mIEdGWCBpcyAyIHNlY29uZHMNCg0KV2Ugc3VibWl0IGpvYjEgZmlyc3QsIGFuZCBh
c3N1bWUgam9iMSBoYXZlIGJ1ZyBhbmQgaXQgd2lsbCBjYXVzZSBzaGFkZXIgaGFuZyB2ZXJ5IHZl
cnkgc29vbg0KQWZ0ZXIgMTAgc2Vjb25kcyB3ZSBzdWJtaXQgam9iMiwgc2luY2UgS0NRIGhhdmUg
NjAgc2Vjb25kcyB0byByZXBvcnQgVERSIHRodXMgU1cga25vdyBub3RoaW5nIGFib3V0IHRoZSBl
bmdpbmUgYWxyZWFkeSBoYW5nDQpBZnRlciAyIHNlY29uZHMgd2UgZ290IFREUiByZXBvcnQgZnJv
bSBqb2IyIG9uIEdGWCByaW5nLCBzY2hlZF9qb2JfdGltZW91dCgpIHRoaW5rIHRoZSBsZWFkaW5n
IGpvYiBvZiBHRlggcmluZyBpcyB0aGUgYmxhY2sgc2hlZXAgc28gaXQgaXMgZGVsZXRlZCBmcm9t
IHRoZSBtaXJyb3IgbGlzdA0KQnV0IGluIGZhY3QgdGhpcyBqb2IxIGlzIGlubm9jZW50LCBhbmQg
d2Ugc2hvdWxkIGluc2VydCBpdCBiYWNrIGFmdGVyIHJlY292ZXJ5ICwgYW5kIGR1ZSB0byBpdCB3
YXMgYWxyZWFkeSBkZWxldGVkIHRoaXMgaW5ub2NlbnQgam9ioa9zIGNvbnRleHQvcHJvY2VzcyBp
cyByZWFsbHkgaGFybWVkDQoNCkhvcGUgYWJvdmUgZXhhbXBsZSBoZWxwcw0KDQpUaGFua3MNCg0K
t6K8/sjLOiBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+DQq3
osvNyrG85DogMjAyMcTqMtTCMjfI1SAwOjUwDQrK1bz+yMs6IExpdSwgTW9uayA8TW9uay5MaXVA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0Ks63LzTogWmhhbmcsIEFuZHkgPEFuZHkuWmhh
bmdAYW1kLmNvbT47IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IFpoYW5nLCBK
YWNrIChKaWFuKSA8SmFjay5aaGFuZzFAYW1kLmNvbT4NCtb3zOI6IFJlOiBbUkZDXSBhIG5ldyBh
cHByb2FjaCB0byBkZXRlY3Qgd2hpY2ggcmluZyBpcyB0aGUgcmVhbCBibGFjayBzaGVlcCB1cG9u
IFREUiByZXBvcnRlZA0KDQoNCg0KT24gMjAyMS0wMi0yNiA2OjU0IGEubS4sIExpdSwgTW9uayB3
cm90ZToNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBP
bmx5XQ0KDQpTZWUgaW4gbGluZQ0KDQpUaGFua3MNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpNb25rIExpdSB8IENsb3VkLUdQVSBDb3JlIHRlYW0NCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpGcm9tOiBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjxtYWlsdG86Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPg0KU2VudDogRnJpZGF5LCBGZWJydWFyeSAyNiwgMjAyMSAzOjU4IFBNDQpUbzog
TGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjxtYWlsdG86TW9uay5MaXVAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4NCkNjOiBaaGFuZywgQW5keSA8QW5keS5aaGFuZ0BhbWQuY29tPjxtYWlsdG86QW5k
eS5aaGFuZ0BhbWQuY29tPjsgQ2hlbiwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPjxtYWls
dG86SG9yYWNlLkNoZW5AYW1kLmNvbT47IFpoYW5nLCBKYWNrIChKaWFuKSA8SmFjay5aaGFuZzFA
YW1kLmNvbT48bWFpbHRvOkphY2suWmhhbmcxQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1JGQ10g
YSBuZXcgYXBwcm9hY2ggdG8gZGV0ZWN0IHdoaWNoIHJpbmcgaXMgdGhlIHJlYWwgYmxhY2sgc2hl
ZXAgdXBvbiBURFIgcmVwb3J0ZWQNCg0KSGkgTW9uaywNCg0KaW4gZ2VuZXJhbCBhbiBpbnRlcmVz
dGluZyBpZGVhLCBidXQgSSBzZWUgdHdvIG1ham9yIHByb2JsZW1zIHdpdGggdGhhdDoNCg0KMS4g
SXQgd291bGQgbWFrZSB0aGUgcmVzZXQgdGFrZSBtdWNoIGxvbmdlci4NCg0KMi4gVGhpbmdzIGdl
dCBvZnRlbiBzdHVjayBiZWNhdXNlIG9mIHRpbWluZyBpc3N1ZXMsIHNvIGEgZ3VpbHR5IGpvYiBt
aWdodCBwYXNzIHBlcmZlY3RseSB3aGVuIHJ1biBhIHNlY29uZCB0aW1lLg0KW01MXSBidXQgdGhl
IGlubm9jZW50IHJpbmcgYWxyZWFkeSByZXBvcnRlZCBhIFREUiwgYW5kIHRoZSBkcm0gc2NoZWQg
bG9naWMgYWxyZWFkeSBkZWxldGVkIHRoaXMgobBzY2hlZF9qb2KhsSBpbiBpdHMgbWlycm9yIGxp
c3QsIHRodXMgeW91IGRvbqGvdCBoYXZlIGNoYW5jZSB0byByZS1zdWJtaXQgaXQgYWdhaW4gYWZ0
ZXIgcmVzZXQsIHRoYXShr3MgdGhlIG1ham9yIHByb2JsZW0gaGVyZS4NCg0KDQoNCkp1c3QgdG8g
Y29uZmlybSBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCBNb25rIHJlcG9ydHMgYSBzY2VuYXJpbyB3
aGVyZSB0aGUgc2Vjb25kIFREUiB0aGF0IHdhcyByZXBvcnRlZCBieSB0aGUgaW5ub2NlbnQgam9i
IGlzIGJhaWxpbmcgb3V0IEJFRk9SRSBoYXZpbmcgYSBjaGFuY2UgdG8gcnVuICBkcm1fc2NoZWRf
c3RvcCBmb3IgdGhhdCBzY2hlZHVsZXIgd2hpY2ggc2hvdWxkIGhhdmUgcmVpbnNlcnRlZCB0aGUg
am9iIGJhY2sgaW50byBtaXJyb3IgbGlzdCAoYmVjYXVzZSB0aGUgZmlyc3QgVERSIHJ1biBpcyBz
dGlsbCBpbiBwcm9ncmVzcyBhbmQgaGVuY2UgYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYgZmFpbHMg
Zm9yIHRoZSBzZWNvbmQgVERSKSBhbmQgc28gdGhlIGlubm9jZW50IGpvYiB3aGljaCB3YXMgZXh0
cmFjdGVkIGZyb20gbWlycm9yIGxpc3QgaW4gZHJtX3NjaGVkX2pvYl90aW1lZG91dCBpcyBub3cg
bG9zdC4NCklmIHNvIGFuZCBhcyBhIHBvc3NpYmxlIHF1aWNrIGZpeCB1bnRpbCB3ZSBvdmVyaGF1
bCB0aGUgZW50aXJlIGRlc2lnbiBhcyBzdWdnZXN0ZWQgaW4gdGhpcyB0aHJlYWQgLSBtYXliZSB3
ZSBjYW4gbW9kaWZ5IGRybV9zY2hlZF9iYWNrZW5kX29wcy50aW1lZG91dF9qb2IgY2FsbGJhY2sg
dG8gcmVwb3J0IGJhY2sgcHJlbWF0dXJlIHRlcm1pbmF0aW9uIEJFRk9SRSBkcm1fc2NoZWRfc3Rv
cCBoYWQgYSBjaGFuY2UgdG8gcnVuIGFuZCB0aGVuIHJlaW5zZXJ0IGJhY2sgdGhlIGpvYiBpbnRv
IG1pcnJvciBsaXN0IGZyb20gd2l0aGluICBkcm1fc2NoZWRfam9iX3RpbWVkb3V0PyBUaGVyZSBp
cyBubyBwcm9ibGVtIG9mIHJhY2luZyBhZ2FpbnN0IGNvbmN1cnJlbnQgZHJtX3NjaGVkX2dldF9j
bGVhbnVwX2pvYiBvbmNlIHdlIHJlaW5zZXJ0IHRoZXJlIGFzIHdlIGRvbid0IHJlZmVyZW5jZSB0
aGUgam9iIHBvaW50ZXIgYW55bW9yZSBhZnRlciB0aGlzIHBvaW50IGFuZCBzbyBpZiBpdCdzIGFs
cmVhZHkgc2lnbmFsZWQgYW5kIGZyZWVkIHJpZ2h0IGF3YXkgLSBpdCdzIG9rLg0KDQpBbmRyZXkN
Cg0KDQoNCkFwYXJ0IGZyb20gdGhhdCB0aGUgd2hvbGUgcmluZyBtaXJyb3IgbGlzdCB0dXJuZWQg
b3V0IHRvIGJlIGEgcmVhbGx5IGJhZCBpZGVhLiBFLmcuIHdlIHN0aWxsIHN0cnVnZ2xlIHdpdGgg
b2JqZWN0IGxpZmUgdGltZSBiZWNhdXNlIHRoZSBjb25jZXB0IGRvZXNuJ3QgZml0IGludG8gdGhl
IG9iamVjdCBtb2RlbCBvZiB0aGUgR1BVIHNjaGVkdWxlciB1bmRlciBMaW51eC4NCg0KV2Ugc2hv
dWxkIHByb2JhYmx5IHdvcmsgb24gdGhpcyBzZXBhcmF0ZWx5IGFuZCBzdHJhaWdodGVuIHVwIHRo
ZSBqb2IgZGVzdHJ1Y3Rpb24gb25jZSBtb3JlIGFuZCBrZWVwIHRoZSByZWNvdmVyeSBpbmZvcm1h
dGlvbiBpbiB0aGUgZmVuY2UgaW5zdGVhZC4NCltNTF0gd2UgY2xhaW0gdG8gb3VyIGN1c3RvbWVy
IHRoYXQgbm8gaW5ub2NlbnQgcHJvY2VzcyB3aWxsIGJlIGRyb3BwZWQgb3IgY2FuY2VsbGVkLCBh
bmQgb3VyIGN1cnJlbnQgbG9naWMgd29ya3MgZm9yIHRoZSBtb3N0IHRpbWUsIGJ1dCBvbmx5IHdo
ZW4gdGhlcmUgYXJlIGRpZmZlcmVudCBwcm9jZXNzIHJ1bm5pbmcgb24gZ2Z4L2NvbXB1dGVzIHJp
bmdzIHRoZW4gd2Ugd291bGQgcnVuIGludG8gdGhlIHRyaWNreSBzaXR1YXRpb24gSSBzdGF0ZWQg
aGVyZSwgYW5kIHRoZSBwcm9wb3NhbCBpcyB0aGUgb25seSB3YXkgSSBjYW4gZmlndXJlIG91dCBz
byBmYXIsIGRvIHlvdSBoYXZlIGEgYmV0dGVyIHNvbHV0aW9uIG9yIGlkZWEgd2UgcmV2aWV3IGl0
IGFzIGFub3RoZXIgY2FuZGlkYXRlIFJGQyA/IEJlIG5vdGUgdGhhdCB3ZSByYWlzZWQgdGhpcyBw
cm9wb3NhbCBpcyBiZWNhdXNlIHdlIGRvIGhpdCBvdXIgdHJvdWJsZSBhbmQgd2UgZG8gbmVlZCB0
byByZXNvbHZlIGl0IKGtLiBTbyBldmVuIGEgbm90IHBlcmZlY3Qgc29sdXRpb24gaXMgc3RpbGwg
YmV0dGVyIHRoYW4ganVzdCBjYW5jZWwgdGhlIGlubm9jZW50IGpvYiAoYW5kIHRoZWlyIGNvbnRl
eHQvcHJvY2VzcykNClRoYW5rcyAhDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQpBbSAyNi4wMi4y
MSB1bSAwNjo1OCBzY2hyaWViIExpdSwgTW9uazoNCg0KW0FNRCBQdWJsaWMgVXNlXQ0KDQpIaSBh
bGwNCg0KTkFWSTJYICBwcm9qZWN0IGhpdCBhIHJlYWxseSBoYXJkIHRvIHNvbHZlIGlzc3VlIG5v
dywgYW5kIGl0IGlzIHR1cm5lZCBvdXQgdG8gYmUgYSBnZW5lcmFsIGhlYWRhY2hlIG9mIG91ciBU
RFIgbWVjaGFuaXNtICwgY2hlY2sgYmVsb3cgc2NlbmFyaW86DQoNCg0KICAxLiAgVGhlcmUgaXMg
YSBqb2IxIHJ1bm5pbmcgb24gY29tcHV0ZTEgcmluZyBhdCB0aW1lc3RhbXANCiAgMi4gIFRoZXJl
IGlzIGEgam9iMiBydW5uaW5nIG9uIGdmeCByaW5nIGF0IHRpbWVzdGFtcA0KICAzLiAgSm9iMSBp
cyB0aGUgZ3VpbHR5IG9uZSwgYW5kIGpvYjEvam9iMiB3ZXJlIHNjaGVkdWxlZCB0byB0aGVpciBy
aW5ncyBhdCBhbG1vc3QgdGhlIHNhbWUgdGltZXN0YW1wDQogIDQuICBBZnRlciAyIHNlY29uZHMg
d2UgcmVjZWl2ZSB0d28gVERSIHJlcG9ydGluZyBmcm9tIGJvdGggR0ZYIHJpbmcgYW5kIGNvbXB1
dGUgcmluZw0KICA1LiAgQ3VycmVudCBzY2hlbWUgaXMgdGhhdCBpbiBkcm0gc2NoZWR1bGVyIGFs
bCB0aGUgaGVhZCBqb2JzIG9mIHRob3NlIHR3byByaW5ncyBhcmUgY29uc2lkZXJlZCChsGJhZCBq
b2KhsSBhbmQgdGFrZW4gYXdheSBmcm9tIHRoZSBtaXJyb3IgbGlzdA0KICA2LiAgVGhlIHJlc3Vs
dCBpcyBib3RoIHRoZSByZWFsIGd1aWx0eSBqb2IgKGpvYjEpIGFuZCB0aGUgaW5ub2NlbnQgam9i
IChqb2IyKSB3ZXJlIGFsbCBkZWxldGVkIGZyb20gbWlycm9yIGxpc3QsIGFuZCB0aGVpciBjb3Jy
ZXNwb25kaW5nIGNvbnRleHRzIHdlcmUgYWxzbyB0cmVhdGVkIGFzIGd1aWx0eSAoc28gdGhlIGlu
bm9jZW50IHByb2Nlc3MgcmVtYWlucyBydW5uaW5nIGlzIG5vdCBzZWN1cmVkKQ0KDQoNCkJ1dCBi
eSBvdXIgd2lzaCB0aGUgaWRlYWwgY2FzZSBpcyBURFIgbWVjaGFuaXNtIGNhbiBkZXRlY3Qgd2hp
Y2ggcmluZyBpcyB0aGUgZ3VpbHR5IHJpbmcgYW5kIHRoZSBpbm5vY2VudCByaW5nIGNhbiByZXN1
Ym1pdHMgYWxsIGl0cyBwZW5kaW5nIGpvYnM6DQoNCiAgMS4gIEpvYjEgdG8gYmUgZGVsZXRlZCBm
cm9tIGNvbXB1dGUxIHJpbmehr3MgbWlycm9yIGxpc3QNCiAgMi4gIEpvYjIgaXMga2VwdCBhbmQg
cmVzdWJtaXR0ZWQgbGF0ZXIgYW5kIGl0cyBiZWxvbmdpbmcgcHJvY2Vzcy9jb250ZXh0IGFyZSBl
dmVuIG5vdCBhd2FyZSBvZiB0aGlzIFREUiBhdCBhbGwNCg0KDQpIZXJlIEkgaGF2ZSBhIHByb3Bv
c2FsIHRlbmQgdG8gYWNoaWV2ZSBhYm92ZSBnb2FsIGFuZCBpdCByb3VnaCBwcm9jZWR1cmUgaXMg
Og0KDQogIDEuICBPbmNlIGFueSByaW5nIHJlcG9ydHMgYSBURFIsIHRoZSBoZWFkIGpvYiBpcyAq
bm90KiB0cmVhdGVkIGFzIKGwYmFkIGpvYqGxLCBhbmQgaXQgaXMgKm5vdCogZGVsZXRlZCBmcm9t
IHRoZSBtaXJyb3IgbGlzdCBpbiBkcm0gc2NoZWQgZnVuY3Rpb25zDQogIDIuICBJbiB2ZW5kb3Kh
r3MgZnVuY3Rpb24gKG91ciBhbWRncHUgZHJpdmVyIGhlcmUpOg0KDQogICAgICogICByZXNldCBH
UFUNCiAgICAgKiAgIHJlcGVhdCBiZWxvdyBhY3Rpb25zIG9uIGVhY2ggUklOR1MgKiBvbmUgYnkg
b25lICo6DQoNCjEuIHRha2UgdGhlIGhlYWQgam9iIGFuZCBzdWJtaXQgaXQgb24gdGhpcyByaW5n
DQoNCjIuIHNlZSBpZiBpdCBjb21wbGV0ZXMsIGlmIG5vdCB0aGVuIHRoaXMgam9iIGlzIHRoZSBy
ZWFsIKGwYmFkIGpvYqGxDQoNCjMuICB0YWtlIGl0IGF3YXkgZnJvbSBtaXJyb3IgbGlzdCBpZiB0
aGlzIGhlYWQgam9iIGlzIKGwYmFkIGpvYqGxDQoNCiAgICAgKiAgIEFmdGVyIGFib3ZlIGl0ZXJh
dGlvbiBvbiBhbGwgUklOR1MsIHdlIGFscmVhZHkgY2xlYXJzIGFsbCB0aGUgYmFkIGpvYihzKQ0K
DQogIDEuICBSZXN1Ym1pdCBhbGwgam9icyBmcm9tIGVhY2ggbWlycm9yIGxpc3QgdG8gdGhlaXIg
Y29ycmVzcG9uZGluZyByaW5ncyAodGhpcyBpcyB0aGUgZXhpc3RlZCBsb2dpYykNCg0KVGhlIGlk
ZWEgb2YgdGhpcyBpcyB0byB1c2UgobBzZXJpYWyhsSB3YXkgdG8gcmUtcnVuIGFuZCByZS1jaGVj
ayBlYWNoIGhlYWQgam9iIG9mIGVhY2ggUklORywgaW4gb3JkZXIgdG8gdGFrZSBvdXQgdGhlIHJl
YWwgYmxhY2sgc2hlZXAgYW5kIGl0cyBndWlsdHkgY29udGV4dC4NCg0KUC5TLjogd2UgY2FuIHVz
ZSB0aGlzIGFwcHJvYWNoZXMgb25seSBvbiBHRlgvS0NRIHJpbmcgcmVwb3J0cyBURFIgLCBzaW5j
ZSB0aG9zZSByaW5ncyBhcmUgaW50ZXJtdXR1YWxseSBhZmZlY3RlZCB0byBlYWNoIG90aGVyLiBG
b3IgU0RNQSByaW5nIHRpbWVvdXQgaXQgZGVmaW5pdGVseSBwcm92ZXMgdGhlIGhlYWQgam9iIG9u
IFNETUEgcmluZyBpcyByZWFsbHkgZ3VpbHR5Lg0KDQpUaGFua3MNCg0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNb25rIExpdSB8IENsb3VkLUdQVSBDb3JlIHRl
YW0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQoNCg0KDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCmFtZC1n
ZnggbWFpbGluZyBsaXN0DQoNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCg0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo=

--_000_DM5PR12MB1708A26CFB637B10A7C7F6B7849C9DM5PR12MB1708namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML \9884\8BBE\683C\5F0F \5B57\7B26";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.HTML
	{mso-style-name:"HTML \9884\8BBE\683C\5F0F \5B57\7B26";
	mso-style-priority:99;
	mso-style-link:"HTML \9884\8BBE\683C\5F0F";
	font-family:"Courier New";}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">H Andrey<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">The scenario I hit here is not the one you mentioned, let =
me explain it with more details by another much easier understood example:<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Consider ring you have a job1 on KCQ, but the timeout of K=
CQ is 60 seconds (just for example)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">You also have a job2 on GFX ring, and the timeout of GFX i=
s 2 seconds<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">We submit job1 first, and assume job1 have bug and it will=
 cause shader hang very very soon
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">After 10 seconds we submit job2, since KCQ have 60 seconds=
 to report TDR thus SW know nothing about the engine already hang
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">After 2 seconds we got TDR report from job2 on GFX ring, s=
ched_job_timeout() think the leading job of GFX ring is the black sheep so =
it is deleted from the mirror list<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">But in fact this job1 is innocent, and we should insert it=
 back after recovery , and due to it was already deleted this innocent job=
=A1=AFs context/process is really harmed
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Hope above example helps<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Thanks
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-family:DengXian">=B7=A2=BC=FE=
=C8=CB<span lang=3D"EN-US">:</span></span></b><span lang=3D"EN-US" style=3D=
"font-family:DengXian"> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt=
;
<br>
</span><b><span style=3D"font-family:DengXian">=B7=A2=CB=CD=CA=B1=BC=E4<spa=
n lang=3D"EN-US">:</span></span></b><span lang=3D"EN-US" style=3D"font-fami=
ly:DengXian"> 2021</span><span style=3D"font-family:DengXian">=C4=EA<span l=
ang=3D"EN-US">2</span>=D4=C2<span lang=3D"EN-US">27</span>=C8=D5<span lang=
=3D"EN-US">
 0:50<br>
</span><b>=CA=D5=BC=FE=C8=CB<span lang=3D"EN-US">:</span></b><span lang=3D"=
EN-US"> Liu, Monk &lt;Monk.Liu@amd.com&gt;; Koenig, Christian &lt;Christian=
.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
</span><b>=B3=AD=CB=CD<span lang=3D"EN-US">:</span></b><span lang=3D"EN-US"=
> Zhang, Andy &lt;Andy.Zhang@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.=
com&gt;; Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
</span><b>=D6=F7=CC=E2<span lang=3D"EN-US">:</span></b><span lang=3D"EN-US"=
> Re: [RFC] a new approach to detect which ring is the real black sheep upo=
n TDR reported<o:p></o:p></span></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">On 2021-02-26 6:54 a.m., Liu, M=
onk wrote:<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheadera92f4c5c" style=3D"margin:0cm"><span lang=3D"EN-US" s=
tyle=3D"font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offici=
al Use Only - Internal Distribution Only]</span><span lang=3D"EN-US"><o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">See in line<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------------------=
-----------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Monk Liu | Cloud-GPU Core team<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------------------=
-----------<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt=
;</a> <br>
<b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
<b>To:</b> Liu, Monk <a href=3D"mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.c=
om&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Cc:</b> Zhang, Andy <a href=3D"mailto:Andy.Zhang@amd.com">&lt;Andy.Zhang=
@amd.com&gt;</a>; Chen, Horace
<a href=3D"mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Zha=
ng, Jack (Jian)
<a href=3D"mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
<b>Subject:</b> Re: [RFC] a new approach to detect which ring is the real b=
lack sheep upon TDR reported<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
Hi Monk,<br>
<br>
in general an interesting idea, but I see two major problems with that:<br>
<br>
1. It would make the reset take much longer.<br>
<br>
2. Things get often stuck because of timing issues, so a guilty job might p=
ass perfectly when run a second time.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
[ML] but the innocent ring already reported a TDR, and the drm sched logic =
already deleted this =A1=B0sched_job=A1=B1 in its mirror list, thus you don=
=A1=AFt have chance to re-submit it again after reset,
 that=A1=AFs the major problem here.<o:p></o:p></span></p>
</blockquote>
<p><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p><span lang=3D"EN-US">Just to confirm I understand correctly, Monk report=
s a scenario where the second TDR that was reported by the innocent job is =
bailing out BEFORE having a chance to run&nbsp; drm_sched_stop for that sch=
eduler which should have reinserted the
 job back into mirror list (because the first TDR run is still in progress =
and hence amdgpu_device_lock_adev fails for the second TDR) and so the inno=
cent job which was extracted from mirror list in drm_sched_job_timedout is =
now lost.<br>
If so and as a possible quick fix until we overhaul the entire design as su=
ggested in this thread - maybe we can modify drm_sched_backend_ops.timedout=
_job callback to report back premature termination BEFORE drm_sched_stop ha=
d a chance to run and then reinsert
 back the job into mirror list from within&nbsp; drm_sched_job_timedout? Th=
ere is no problem of racing against concurrent drm_sched_get_cleanup_job on=
ce we reinsert there as we don't reference the job pointer anymore after th=
is point and so if it's already signaled
 and freed right away - it's ok. <o:p></o:p></span></p>
<p><span lang=3D"EN-US">Andrey<o:p></o:p></span></p>
<p><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
<br>
Apart from that the whole ring mirror list turned out to be a really bad id=
ea. E.g. we still struggle with object life time because the concept doesn'=
t fit into the object model of the GPU scheduler under Linux.<br>
<br>
We should probably work on this separately and straighten up the job destru=
ction once more and keep the recovery information in the fence instead.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
[ML] we claim to our customer that no innocent process will be dropped or c=
ancelled, and our current logic works for the most time, but only when ther=
e are different process running on gfx/computes
 rings then we would run into the tricky situation I stated here, and the p=
roposal is the only way I can figure out so far, do you have a better solut=
ion or idea we review it as another candidate RFC ? Be note that we raised =
this proposal is because we do hit
 our trouble and we do need to resolve it =A1=AD. So even a not perfect sol=
ution is still better than just cancel the innocent job (and their context/=
process)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
Thanks ! <o:p>
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
<br>
Regards,<br>
Christian.<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Am 26.02.21 um 06:58 schrieb Li=
u, Monk:<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheader251902e5" style=3D"margin:0cm"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#31=
7100">[AMD Public Use]</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">NAVI2X &nbsp;project hit a real=
ly hard to solve issue now, and it is turned out to be a general headache o=
f our TDR mechanism , check below scenario:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1"><span lang=3D"EN-US">There is a job1 running on compute1 ring at time=
stamp
<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:=
0cm;mso-list:l0 level1 lfo1"><span lang=3D"EN-US">There is a job2 running o=
n gfx ring at timestamp<o:p></o:p></span></li><li class=3D"MsoListParagraph=
" style=3D"margin-left:0cm;mso-list:l0 level1 lfo1"><span lang=3D"EN-US">Jo=
b1 is the guilty one, and job1/job2 were scheduled to their rings at almost=
 the same timestamp
<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:=
0cm;mso-list:l0 level1 lfo1"><span lang=3D"EN-US">After 2 seconds we receiv=
e two TDR reporting from both GFX ring and compute ring<o:p></o:p></span></=
li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 leve=
l1 lfo1"><b><span lang=3D"EN-US">Current scheme is that in drm scheduler al=
l the head jobs of those two rings are considered =A1=B0bad job=A1=B1 and t=
aken away from the mirror list
</span></b><span lang=3D"EN-US"><o:p></o:p></span></li><li class=3D"MsoList=
Paragraph" style=3D"margin-left:0cm;mso-list:l0 level1 lfo1"><span lang=3D"=
EN-US">The result is both the real guilty job (job1) and the innocent job (=
job2) were all deleted from mirror list, and their corresponding contexts w=
ere also treated as
 guilty<b> (so the innocent process remains running is not secured)</b><o:p=
></o:p></span></li></ol>
<p class=3D"MsoListParagraph"><b><span lang=3D"EN-US">&nbsp;</span></b><spa=
n lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">But by our wish the ideal case =
is TDR mechanism can detect which ring is the guilty ring and the innocent =
ring can resubmits all its pending jobs:<o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l2 level1 =
lfo2"><span lang=3D"EN-US">Job1 to be deleted from compute1 ring=A1=AFs mir=
ror list<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"marg=
in-left:0cm;mso-list:l2 level1 lfo2"><span lang=3D"EN-US">Job2 is kept and =
resubmitted later and its belonging process/context are even not aware of t=
his TDR at all
<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Here I have a proposal tend to =
achieve above goal and it rough procedure is :<o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 =
lfo3"><span lang=3D"EN-US">Once any ring reports a TDR, the head job is *<b=
>not</b>* treated as =A1=B0bad job=A1=B1, and it is *<b>not</b>* deleted fr=
om the mirror list in drm sched functions<o:p></o:p></span></li><li class=
=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 lfo3"><sp=
an lang=3D"EN-US">In vendor=A1=AFs function (our amdgpu driver here):<o:p><=
/o:p></span></li></ol>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level2 =
lfo3"><span lang=3D"EN-US">reset GPU<o:p></o:p></span></li><li class=3D"Mso=
ListParagraph" style=3D"margin-left:0cm;mso-list:l1 level2 lfo3"><span lang=
=3D"EN-US">repeat below actions on each RINGS * one by one *:<o:p></o:p></s=
pan></li></ul>
</ol>
<p class=3D"MsoListParagraph" style=3D"margin-left:108.0pt;text-indent:-9.0=
pt;mso-list:l1 level3 lfo3">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">take the head job and s=
ubmit it on this ring<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:108.0pt;text-indent:-9.0=
pt;mso-list:l1 level3 lfo3">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">see if it completes, if=
 not then this job is the real =A1=B0bad job=A1=B1<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:108.0pt;text-indent:-9.0=
pt;mso-list:l1 level3 lfo3">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">3=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">&nbsp;take it away from=
 mirror list if this head job is =A1=B0bad job=A1=B1<o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level2 =
lfo3"><span lang=3D"EN-US">After above iteration on all RINGS, we already c=
lears all the bad job(s)<o:p></o:p></span></li></ul>
</ol>
<ol style=3D"margin-top:0cm" start=3D"3" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 =
lfo3"><span lang=3D"EN-US">Resubmit all jobs from each mirror list to their=
 corresponding rings (this is the existed logic)<o:p></o:p></span></li></ol=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The idea of this is to use =A1=
=B0serial=A1=B1 way to re-run and re-check each head job of each RING, in o=
rder to take out the real black sheep and its guilty context.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">P.S.: we can use this approache=
s only on GFX/KCQ ring reports TDR , since those rings are intermutually af=
fected to each other. For SDMA ring timeout it definitely proves the head j=
ob on SDMA ring is really guilty.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------------------=
-----------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Monk Liu | Cloud-GPU Core team<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------------------=
-----------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
<br>
<o:p></o:p></span></p>
<pre><span lang=3D"EN-US">_______________________________________________<o=
:p></o:p></span></pre>
<pre><span lang=3D"EN-US">amd-gfx mailing list<o:p></o:p></span></pre>
<pre><span lang=3D"EN-US"><a href=3D"mailto:amd-gfx@lists.freedesktop.org">=
amd-gfx@lists.freedesktop.org</a><o:p></o:p></span></pre>
<pre><span lang=3D"EN-US"><a href=3D"https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a=
><o:p></o:p></span></pre>
</blockquote>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1708A26CFB637B10A7C7F6B7849C9DM5PR12MB1708namp_--

--===============1078174031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1078174031==--
