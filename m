Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DFCC04E69
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 15:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC09610E618;
	Thu,  3 Aug 2023 15:28:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011BF10E618
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 15:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXkhBf/Tn7N4jZZJbjUF7dyx4sRJxAortrALIia4Z43hfPk93kgIs0ZRCAPnqWoItCHjpIk2eFS5psUMEm/yu/MdAzcCpLBUP/hPbJJCbeJvwQ7Oi6cuxVHDLay1bAxaxnx8LVtjdeXhA40pz0Bo0m4vL1tzHlqvpdcyPX3QGIb7KN08QZZ2VCiwlS/zJLXATo2WD/NKdgiFJBhaO9796OlCkV9ZtZm3WUS78+b1xUd89ymHTclSmIOs+c1qMVxgfVwYteP1jHq1vUkTnS+lTr13x5JpgdQoufHBAYy25qWk4wthRx74WvTLuVFUAbpgOS/xkJcAEceyx9s5Hc3kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAlj/F2Fa1Xw5iPs7OS3jIm4EKwtDs22rEEVnqgPrF0=;
 b=gcuv6V8jxSb/wf7SEoY96rl+2xj3M0O60xquDp4TJ2zfz9TeuSuDg03KBR+3Yo9QeQS8Rzs07ud/73EORIydmYK6JMDimMc8umR1jSVtNk3Ghs/LDPCI2I3NMFrbQem3iJA80YRR8gCFG4TixaUaPYM8U9EsCqmshpgGb25KTUadCg42gJbDc8fYZsiWT7woY2cLj9uRYMrKnKFLGYf+HVN9nrffxQxMXdMGXb9X81KZyHDzWqag87DHvYFBDWVVfoJpPg525xZU4tD8fTvE93P1Tkp07F9UtfSXd9vfjrf+wvhdwzxgnbhKGCI1dHHt1gV8dm2jzX346Xt9vhfNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAlj/F2Fa1Xw5iPs7OS3jIm4EKwtDs22rEEVnqgPrF0=;
 b=Ow0PFVhhhAxDSDmZj0YMv0+WUf7apZp4NLDMmoSTG/95fxpKQ2OLJ1anLSEIk8g4YqWIJKmZJeudFqA3et+Qfxrk8HulJEY4dFIzu1YbXLswgizsktHaeq1XRzqAUF/AxXLtg1sXdRvTNjT4+zsDO/VevTHfNnsPM5kemBNfj6Q=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:28:10 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:28:10 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add support to create large TMR BO for APU
Thread-Topic: [PATCH] drm/amdgpu: add support to create large TMR BO for APU
Thread-Index: AQHZxEtBMA1g3ttLEkKRYh1urNE1Ya/YtYkC
Date: Thu, 3 Aug 2023 15:28:10 +0000
Message-ID: <DM6PR12MB42503F416BD78E9163666A90FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20230801073832.2133509-1-Lang.Yu@amd.com>
In-Reply-To: <20230801073832.2133509-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-03T15:28:09.1263529Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4250:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: d94524ca-5bb3-4510-5ec5-08db94363ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLu1LVZvZbIqC+PQBUsMm1YCE9PwGQQ1A0JsyWEqiUywP0GzrIkYggEZkzGuHJEOHZ8hwO7wQuImpWd6X0f8B83mJyhFCU30BLG6dgqwq2MEwu5BRZp2HjorEoR3FSYMFFX0mH/9GU5uH20y3kc/Xi5d6ashQD2mbzQFaRvn6p2RDhnISxkqB8v6tRyeYWWXbRmZMguuUBBwiqOjgS15ApLXtmclLw7/JNZ9kcpQsgd2mosJTn/wAfo+9p50CXheXHpP4ASvQBwOVUbxwFUBB9CcP6KrUWGIqUqV9emTSP5YgWWoJzh3EgfbzAsqK2VBErvcgPDdsqv2iONOV75C/ukpO9AYtp3+Uce8eDOQ3MdU/N8GHR0vTFbUzlGtoTFX4CXMwxSPVLWQQc2wac8VFbwIz2OfPqQC5si3xDxmGUUkfdxpb7YfzttANMrqPaDdXL9B7fsUFTzVIyg8XCAm9uA9ue1CQVcWpiqOzS6ketbbOPtIvuio9anFZp4b8edktjDSz/SQialu1wbXLotWuECvAv45Ud4vSuzxIbisdBEi31u7fJ+gZy0kktBRgRJWWkuhRq0vB3HqGOIToECY4w6QokiMVFKqZhlnZjoj43AzfhuXUTO/IS3fYMGK5Rte
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(6506007)(26005)(86362001)(38100700002)(122000001)(38070700005)(316002)(71200400001)(478600001)(9686003)(7696005)(66446008)(54906003)(55016003)(6916009)(33656002)(4326008)(64756008)(66946007)(66556008)(66476007)(76116006)(2906002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WHpCSDFLOFVDeGZzSkQzZ3VKSXpnc1BTNUNlN2lCbjUwNksxUFk2NXREUnNv?=
 =?gb2312?B?QWtUNmxYMmhLRVA5akx3OXJYOFBudDJuZGNBNStjOENTMVZ4UisrSjVab2pk?=
 =?gb2312?B?SEtmSUxBUnN4MGVWVFhvRUxSVFJSR1FoM2lHcGN5TWR6VXh2U0xnNjZBZ202?=
 =?gb2312?B?SjdWcWc5M2t0dWphQXVCZWpGSVRlYWRBYzJoZTF5ekRCV1hOZTRpaENyK3ZK?=
 =?gb2312?B?SGp5MTVLS3gxVFprWEs1eU82K05QcVA4V2lxQmZEQjBtSHlmdTNNSGN1Z1B2?=
 =?gb2312?B?L1FRL1RWckl2K1VISmxLM2F1LzVxMnM1NkgvUXl4R0FOVDhrQjdpdzVBbG9I?=
 =?gb2312?B?OFJ6emQ2Mkh4cm9RSis2MFN6QmEvczVjWkpLWDVVaGh6MXNRc2Q4NUpucFJI?=
 =?gb2312?B?bUxCRE1tMlBUdUttNnZjd2dIQ1BrSVlKS04rU2lVN3o4RDFsYitlc0dNNm4w?=
 =?gb2312?B?WjZCQnRNU3k2VUFUazZ3ZE1oTy9xYkFWOEl3L05od0JBODZPdC8xWktKeDBI?=
 =?gb2312?B?R2RuaWJQbGFDVm9rL0JmY1ZUVEYxNlFoZiswOFgvSU5oQTROTEZiMnVtRHpY?=
 =?gb2312?B?dXh4VjJyZW9XVFE2Q1FrT2xIbzgzTEhlYjNrS0gxcDZsMzVTa2lTZ2k5R2h2?=
 =?gb2312?B?anhDSzFqMTdhcTlpNWVEOTU3M2txYytBWTArVm0zdnFIUUJ0TWdROGFJU1ly?=
 =?gb2312?B?Z1RwekxVaFJSL01YeXc5UWhFb3B3N3hVVEpkZE83QjNuazNwNW9lOFVKY0ZY?=
 =?gb2312?B?bHNWQk85TEFzYzczSkNxbDhNL1hMaHRUdWVmWlFWMFNueHBZSHkzaXB5UmpJ?=
 =?gb2312?B?bFZWRmJzaGxtbWovcUtrajY1Z1BzeU1xanFxa2MvRGlIcUxNNGxFU0FlQmZq?=
 =?gb2312?B?dUJCRTgrYS8vcVpsYnBrdW43Rjc0MngxcjEzcVhOREVscG5WMkpkZkdvQ0N0?=
 =?gb2312?B?NjFBOU9BcCtJdEVyWlVDRmJCOUFCNUpQQ2xxbVZvcUpuZU1ZKzBaU1BtS3oy?=
 =?gb2312?B?TWVyUnZtS0VQa2o2UXZSYThiY1UwYkkwaE5FUktoUWpubEliTmxpUTM5Sk9x?=
 =?gb2312?B?cU1KV0NCRzdtYjd6VW1BYTdDQks2M3R6Y3RIZFlZNm4yUGVMb0Q0MUR6ZGJD?=
 =?gb2312?B?ZEZNbm9DZEhFcTNmUTVRRmdRRHJzYmdIU3k5SHdoVHJtMXgxclJGMDREYW0z?=
 =?gb2312?B?aTZuVm1WbGFucXhIMFFUMmdvZ0F4UzkyNU10bjM2WXAySGdUYXhLa3Z6dTNy?=
 =?gb2312?B?K3MxMzMwSEgvTCtkS1dHY1pPZ2M1azgzZVdDTlFaQVZ6Y0l0Ym5jVFVjTllS?=
 =?gb2312?B?Q0x4Y2k2dnVaQnU5cytxRkxIYVRiamFGT0F4bDRSQWpmQ3c2d2xJQUNIQUlu?=
 =?gb2312?B?V1liWnZITyt5YUhJUnBqR3lUMTNGVzVVY043Rks0cnR3T3UrKzcwckQzdFFy?=
 =?gb2312?B?aC9SWFNnQjAwbjhvdWpHa3ZuaFFQVmVXb0hEVWh1ZkMwWGhUZjh6YU5yeERC?=
 =?gb2312?B?aG5QamJuMjJWV1ltL1I3dktydzFDN2hlZGNkSjU5RWhUYm5nNGluSE9Qd0RD?=
 =?gb2312?B?bUMzR3JlRHBKZ25IUWtta2xJSGtoclFIWitWOFN1dGFTd1VnQnc4bXJodWN2?=
 =?gb2312?B?NXBFbXlkMjAvZUpETWp1ajd4N0Z4RTJjek5NelZ4emNBeC9yVm40azVMUUpW?=
 =?gb2312?B?bCs4OWVPVmVQaSttT0dqZ3Ewa3JldGRGYzRPUjF2VHl6OUhpdURwb3JVMWtr?=
 =?gb2312?B?d3RUNXBoejdMdVdTUmI5Ky9FdlZBZGtkU2hPVnRuZTM2ZlNqUjI1aE55WlJ3?=
 =?gb2312?B?TVl0YWR0TGFHQ2FFRldlQUZKTEdlWitvdjVscjAwQkE5SDE5N1ZmUVNKdC9q?=
 =?gb2312?B?eEROcWF0UGc1eEd0ZS8yWFZyUW1QdEpVR1dtVHJFcmpkUjRrcUpQVWJSR3FL?=
 =?gb2312?B?WWlOdWNIaklwU1ZvcW95TEE4VXZyNnEyTU5ObGptNTZLMnNYdjBnWTg3dXRk?=
 =?gb2312?B?WnFQZTFwNnNDWk5uN2VqbVpkZVVTVWs3RnB1VnJOdzA4NVgyNUs1KzNXaXgv?=
 =?gb2312?B?LzJ1K3ZiZndwcGJqNXFJV3BvVmFYMTVSMjZwbXI3dytQT1Q1dGE1bnZBQys0?=
 =?gb2312?Q?PQH5tgX0y4cws//3BM1eG8JNe?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB42503F416BD78E9163666A90FB08ADM6PR12MB4250namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94524ca-5bb3-4510-5ec5-08db94363ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 15:28:10.3140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwrt4p00Z7n6jCa5vma/pFa8xhA4dtsfiazxSEaGEq1ShiMQgrl+qUEs2k2rnZT4P3yw6J+uWlbESS+eXjY+EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Paneer Selvam, 
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB42503F416BD78E9163666A90FB08ADM6PR12MB4250namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KUGluZw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7I
yzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT4NCreiy83KsbzkOiBUdWVzZGF5LCBBdWd1c3Qg
MSwgMjAyMyAzOjM4OjMyIFBNDQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCrOty806IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxB
cnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhh
bmdAYW1kLmNvbT47IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQrW98ziOiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGFkZCBzdXBwb3J0IHRvIGNyZWF0ZSBsYXJnZSBUTVIgQk8gZm9yIEFQVQ0KDQpU
TVIgcmVxdWlyZXMgcGh5c2ljYWwgY29udGlndW91cyBtZW1vcnksIGFtZGdwdV9ib19jcmVhdGVf
a2VybmVsKCkNCmNhbid0IHNhdGlzZnkgbGFyZ2UoPjEyOE1CKSBwaHlzaWNhbCBjb250aWd1b3Vz
IG1lbW9yeSBhbGxvY2F0aW9uDQpyZXF1ZXN0IHdpdGggZGVmYXVsdCA1MTJNQiBWUkFNIG9uIEFQ
VS4NCg0KV2hlbiByZXF1ZXN0ZWQgVE1SIHNpemUgPiAxMjhNQiwgdXNlIGFtZGdwdV9ib19jcmVh
dGVfa2VybmVsX2F0KCkNCnRvIGNyZWF0ZSB0aGUgQk8gYXQgb2Zmc2V0IDMyTUIgd2l0aCBhIHN0
ZXAgMU1CIGluIHRoZSBWUkFNIHJhbmdlLg0KDQpTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxMYW5n
Lll1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDM1IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMNCmluZGV4IDE1MjE3ZTMzYjUxZC4uM2ZhZGZhYTYzYjJlIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCkBAIC03ODMsNiArNzgzLDM0IEBAIHN0
YXRpYyBib29sIHBzcF9ib290dGltZV90bXIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAg
ICAgICB9DQogfQ0KDQorc3RhdGljIGludCBwc3BfY3JlYXRlX2xhcmdlX3Rtcl9ib19mb3JfYXB1
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCB0bXJfc2l6ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICoqY3B1X2FkZHIpDQorew0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1
X3ZyYW1fbWdyICptZ3IgPSAmcHNwLT5hZGV2LT5tbWFuLnZyYW1fbWdyOw0KKyAgICAgICB1aW50
MzJfdCByb3VuZGVkX3NpemUgPSByb3VuZF91cCh0bXJfc2l6ZSwgMHgxMDAwMDApOw0KKyAgICAg
ICB1aW50MzJfdCBzdGFydCA9IDB4MjAwMDAwMDsNCisgICAgICAgdWludDMyX3Qgc3RlcCA9IDB4
MTAwMDAwOw0KKyAgICAgICBpbnQgcmV0ID0gLUVOT01FTTsNCisNCisgICAgICAgZm9yICg7IHN0
YXJ0ICsgcm91bmRlZF9zaXplIDw9IG1nci0+bWFuYWdlci5zaXplICYmDQorICAgICAgICAgICAg
c3RhcnQgKyBzdGVwIDw9IG1nci0+bWFuYWdlci5zaXplOyBzdGFydCArPSBzdGVwKSB7DQorDQor
ICAgICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWxfYXQocHNwLT5hZGV2
LCBzdGFydCwgdG1yX3NpemUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnBzcC0+dG1yX2JvLCBjcHVfYWRkcik7DQorICAgICAgICAgICAgICAgaWYg
KHJldCA9PSAtRU5PTUVNKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQorICAg
ICAgICAgICAgICAgaWYgKHJldCkNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQorDQorICAgICAgICAgICAgICAgcHNwLT50bXJfbWNfYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zm
c2V0KHBzcC0+dG1yX2JvKTsNCisNCisgICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgfQ0K
Kw0KKyAgICAgICByZXR1cm4gcmV0Ow0KK30NCisNCiAvKiBTZXQgdXAgVHJ1c3RlZCBNZW1vcnkg
UmVnaW9uICovDQogc3RhdGljIGludCBwc3BfdG1yX2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApDQogew0KQEAgLTgxMyw4ICs4NDEsMTMgQEAgc3RhdGljIGludCBwc3BfdG1yX2luaXQoc3Ry
dWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAgICAgICAgICAgICAgIH0NCiAgICAgICAgIH0NCg0K
LSAgICAgICBpZiAoIXBzcC0+dG1yX2JvKSB7DQotICAgICAgICAgICAgICAgcHB0ciA9IGFtZGdw
dV9zcmlvdl92Zihwc3AtPmFkZXYpID8gJnRtcl9idWYgOiBOVUxMOw0KKyAgICAgICBpZiAocHNw
LT50bXJfYm8pDQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorDQorICAgICAgIHBwdHIgPSBh
bWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSA/ICZ0bXJfYnVmIDogTlVMTDsNCisgICAgICAgaWYg
KHBzcC0+YWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmIHRtcl9zaXplID4gMHg4MDAwMDAwKQ0K
KyAgICAgICAgICAgICAgIHJldCA9IHBzcF9jcmVhdGVfbGFyZ2VfdG1yX2JvX2Zvcl9hcHUocHNw
LCB0bXJfc2l6ZSwgcHB0cik7DQorICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICAgcmV0ID0g
YW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwocHNwLT5hZGV2LCB0bXJfc2l6ZSwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFNQX1RNUl9BTElHTk1FTlQsDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9IQVNf
VlJBTShwc3AtPmFkZXYpID8NCkBAIC04MjIsNyArODU1LDYgQEAgc3RhdGljIGludCBwc3BfdG1y
X2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX0dUVCwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBzcC0+dG1yX2JvLCAmcHNwLT50
bXJfbWNfYWRkciwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcHB0cik7DQotICAgICAgIH0NCg0KICAgICAgICAgcmV0dXJuIHJldDsNCiB9DQotLQ0KMi4y
NS4xDQoNCg==

--_000_DM6PR12MB42503F416BD78E9163666A90FB08ADM6PR12MB4250namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr">Ping</div>
</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Yu, Lan=
g &lt;Lang.Yu@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Tuesday, August 1, 2023 3:38:32 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Pa=
neer Selvam, Arunpravin &lt;Arunpravin.PaneerSelvam@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: add support to create large TMR BO=
 for APU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">TMR requires physical contiguous memory, amdgpu_bo=
_create_kernel()<br>
can't satisfy large(&gt;128MB) physical contiguous memory allocation<br>
request with default 512MB VRAM on APU.<br>
<br>
When requested TMR size &gt; 128MB, use amdgpu_bo_create_kernel_at()<br>
to create the BO at offset 32MB with a step 1MB in the VRAM range.<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++++++++++++++-=
-<br>
&nbsp;1 file changed, 35 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 15217e33b51d..3fadfaa63b2e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -783,6 +783,34 @@ static bool psp_boottime_tmr(struct psp_context *psp)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static int psp_create_large_tmr_bo_for_apu(struct psp_context *psp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; int tmr_size,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; void **cpu_addr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr *mgr =3D &amp;=
psp-&gt;adev-&gt;mman.vram_mgr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rounded_size =3D round_up(tm=
r_size, 0x100000);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start =3D 0x2000000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t step =3D 0x100000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; start + rounded_size &lt;=3D m=
gr-&gt;manager.size &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start +=
 step &lt;=3D mgr-&gt;manager.size; start +=3D step) {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel_at(psp-&gt;adev, start, tmr_size=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;tmr=
_bo, cpu_addr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D -ENOMEM)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;tmr_mc_addr =3D amdgpu_bo_gpu_offset(psp-&gt;tmr_bo);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;/* Set up Trusted Memory Region */<br>
&nbsp;static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;{<br>
@@ -813,8 +841,13 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;tmr_bo) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev) ? &amp;tmr_buf : NULL;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;tmr_bo)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev=
) ? &amp;tmr_buf : NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;flags &amp; AMD_=
IS_APU &amp;&amp; tmr_size &gt; 0x8000000)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_create_large_tmr_bo_for_apu(psp, tmr_size, pptr);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&gt;adev, tmr_siz=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_TMR_ALIGNMENT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_HAS_VRAM(psp-&gt=
;adev) ?<br>
@@ -822,7 +855,6 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;tmr_bo, &a=
mp;psp-&gt;tmr_mc_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB42503F416BD78E9163666A90FB08ADM6PR12MB4250namp_--
