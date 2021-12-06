Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300AAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE5B7AC5F;
	Mon,  6 Dec 2021 10:20:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349527318E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 07:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzlhDurSiLZ6+Af8xvg6qwefSoEgUveDTOQN/nXDufRXVrroegIHG3eJ+S+lK83EH/pus8z5BqgCJ+DY9waMvbxeOg8qVJsNmMu7Pi68/F7JEnF6KjLsM2ipl57rD9c5z1lLdc6w18nSJv1xu7mZWg2dlCwBzN9bUSzVsY58T8EY4L3MvzuyKTQty+lW67uL+mt9c3bR01GAZrKfo/xq2xCQSwXXs+iWIMtR4DqfOrMPWSjKL+OGjNZVGpreByPnotMVYcRJLV8C00QxZKC8jbloDzwqD8WclSudJf4LDEZF7TVCJ83mEB89VeDcbukRBzsHD8NCoYmcTKvwes8Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMx4ZugCqsqEeU9tiyFGvQM9IkiQu7g6ZzuISWSECgA=;
 b=RLGNVTStziUqgWuq1YtKXRA4jCt+Jan/vAtMhfDArfg1pitPGPyQ2AsjDodeo/HgBc0OVfHa5dJqSHJp9rJx3XleWgdBpKuu+IHrb3mbGpOPyqxkLTKqtk455zWkp2E/WkTLzpelOx2C+zigfy8w288usnKr6SPHJ31d+ncYG/6rTYeMVBOGNpezALHhho3MyvL88vIyCObr2ndrFD1wBTDUCCyAlxzwHHZMesPTZ76D8qrqOZumlMmlxLQ4N4adujgLCjK5OrCx6JY8HsFNBkv6lH1G2hPgvlzNFjyj8Lr7VkLK2YNFyeX5a+J83d5wL0+Q7+pt8O4U1PJl4IpYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMx4ZugCqsqEeU9tiyFGvQM9IkiQu7g6ZzuISWSECgA=;
 b=f/ycycnfgpIuXOl2U+3eSCEK1UuRasjXCD8gilECUUjey96aC7OpNy1nL2vAQGrtoViARaTcAJJ8OLXOQz+iiEfrnPjbBupHR33meQw+0P+8rSyzAHZu+Ba1v2zmsZJ0SJy9ilI4zpcRae91ScpWd0WVjpJB9AahNC1DqJHjH6Q=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16; Mon, 6 Dec 2021 06:48:46 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:48:46 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when
 dpm is disabled
Thread-Topic: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
 when dpm is disabled
Thread-Index: AQHX6BKd6VxxmsBvHECw3m2gr5Y+dqwghsoAgAQ/fRCAAA/YgIAAMWnwgAACuxA=
Date: Mon, 6 Dec 2021 06:48:46 +0000
Message-ID: <DM6PR12MB42500FDF83B2FF999385D5E3FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
 <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
 <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-06T06:38:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7dbe8117-c56d-46d2-a862-6fe557c43f50;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-06T06:48:43Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8c8885ba-f098-4c9e-80a1-41f12921b063
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adb6eaf-6456-4b4c-ad22-08d9b884738b
x-ms-traffictypediagnostic: DM6PR12MB4778:EE_
x-microsoft-antispam-prvs: <DM6PR12MB477854CC6D1637C09342A3F8FB6D9@DM6PR12MB4778.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUuP1PdpKPLQThNW6z0KVKsJaC5NGZRxf+NK6M7rpirrJ9cyDJgiw+b6IpebipcXSj+D0ZJiMO7uG4fkvO4iZ8Xe4x39b4AlpRxamN6Y6yloWMOGgTPtywrT216YEtjziVkNavL8no+LcO9aOVXStpr+WrrgE5HIGURCTcVWFCKa0F1fZ3ldY9GpepO3KRki3BAfvWxcK/thgAld21cwxlAqs/nSe+3dnzssiSrmw59aqQGyJAna+zX4lgTwWQ8D3Pq3wugrQAZNbTvcjX7reZFojNzFH2PfW3s8xoHcoMuWd/buQxIKYjX1Rsyr1WFqLaW4Gz0TWi0XYPQ51u3ZQSIKk7az8jKE17sXcT4aX6lTlsQbSaW91ULDxSZ/2vZ1iXup/2nS6l7BfslJQoFFt5IynYfmxHtrl1kXRJ6Et0DwtRrPdjW7u+Wna3accoI1Jxu5d0zlUacP2GNejtPNqK/ng3h4Pr0/wjvFizLA1tXmjUJ1ppqJSRSnBpNj2ttRYYxNz7aTq2cPThtBvX5sqUoiPKpODI6kCLfDPTjkBmxbOWLbZs7GfPXObaK645p+tihokDi/YZKQAb+KRf53yMCQ647xcCLm7p9ugJjr61ZXobNhTFvm4vs9b9LWWjWVDeyE1ScK+F7lHRkUlloVEH57iwcH6QbuReVXe4UqZOHkZvKlGrxJgLHQeNDzEsywGRffmSLlMNyshh+qiKfOXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(54906003)(76116006)(66946007)(316002)(64756008)(66476007)(5660300002)(66556008)(66446008)(53546011)(15650500001)(86362001)(4326008)(38100700002)(6506007)(110136005)(55016003)(186003)(33656002)(122000001)(26005)(2940100002)(71200400001)(8676002)(2906002)(8936002)(508600001)(52536014)(9686003)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODFxSVBxTHJScVkyZXNDWFYreGNKY042Q2xJMzd0NzljTHBwR3lpNjlkN1RK?=
 =?utf-8?B?c0l2YzRnZlppUjJZOWhNc3RKMTRsV21rVTlPVmFXUENZSVExVms3M1dkMkZM?=
 =?utf-8?B?QmJVSVhFMDlmNUZLM1pPenFKL0t2Q0lTNkRPUFZCbUlIU3lhS21QZFJIWS9P?=
 =?utf-8?B?WXZjUmg1UjNMRitVNUM5S1U2aTNHMlJPemtDaWh4bllMSlpOcFBVYWlnS0V3?=
 =?utf-8?B?THRHUEVmOHZqdjIvdTlhUmpTeS94WjhFZE0rMng4c3VhL050bGt0Sy81MEQw?=
 =?utf-8?B?dzJGZmFYRnZtV1pzaVZyR3FMb2xpWkUyK3JDMStkYUNQc0g3N0NuRE1weVIv?=
 =?utf-8?B?bjNLdnVMcjNWdHVBZnBUcmNMUVE3NS9JQ0hlQUx3WklwV3VnMmdiWFUvVWs2?=
 =?utf-8?B?Y2xKeEdNNVh5V1BQdXc4ZFRYdGR0d1BrcTkzODgzOFphcmlmT0E0Y1VZeTZS?=
 =?utf-8?B?RUpma1l5Vlh1SGtBTW1DZk5oNDd1WEdyYUFBR3JaaFROeWovWDkyQnlGdWcr?=
 =?utf-8?B?VnI5cjAxUUJweEVubEVNcTVKT0FXbCsxbFVmWDRBK1FnbXpBTnJudHdNTGls?=
 =?utf-8?B?STBlRTVGaUUxUVRIYWg3WVl6NFBOSm91QkxSb0xrbFFOU0Y3TktXSG51N3Y0?=
 =?utf-8?B?Z3JLVmNKcmNPUCs0b0hua0VjU3prWFpReWQwUFBPdlB5UEFNS0pIUmU5ellr?=
 =?utf-8?B?aVVtSk5jQ1pWRG1RdVRxUStxUExCUTluTmh2RFpwc3JQbWw2RllvZ0c2akdR?=
 =?utf-8?B?Rk9pU0NDNWVmVjFzTVZ1a1czMCtVUnpjaWtuTTdkZTIyc2xocWI2c3B4dCtJ?=
 =?utf-8?B?NlgrWE9Kamg0ekNCaThXQmhJSHFLb2tTKy9Vem1XbW91cXl0UFJhK0kvRlBQ?=
 =?utf-8?B?Mmt5V2lPRjFNcHBTZHE3QUpIY1U3TTQyODRYYkNHdGhFSk0vRVNKd0t6OGcx?=
 =?utf-8?B?Tjk4c2FPOFBlc1U5bmpSUEc3OFFGTVNZa0pOUzlCRTR0Q0lmdXlHUEt2anBO?=
 =?utf-8?B?bDdSaGJlVHdsTEoxRm1GSGw1TGtuREx4NEtSSlJ2bnVuN3hHSlJOSDRtd01p?=
 =?utf-8?B?SXdUZGZtK3NQVDIvV1pKNkV1S05KSkdiT0pmV2pMMXRUS1QwaVlVV25KRjk5?=
 =?utf-8?B?V3ZtUXJHSTg2VG14K09tQmVwMU1zaFJPVTEyZ010czhodllVTUtPd0FhTlJ5?=
 =?utf-8?B?d1ZpSyt6VW1QenliY0VpMlNnanp0SndOMEN0WkUwb0REcjg1TytjTFZoN0g1?=
 =?utf-8?B?cDhGVkQrRGdHL0tJZ080MEZGd2x3NVI0RzdKQXB0cjV0aUcydWdnUEhNcjBG?=
 =?utf-8?B?c2N3cm9ycE9WN2paM0JLMEZWV3FJenJhSjYxMTFINHVXZmM1d2NPME1EOHN2?=
 =?utf-8?B?OTlwdnZ4TENPeWtTdU1IMW5qdTRSWW1kWk5UbE0yK2ZyZjM2bUJTWXlGV3Fi?=
 =?utf-8?B?WWg1SENiWGkrY3hYYU5SNHFKbzloV1NSbzBiUkM2bk4wamZtT0VUQnhHUWZp?=
 =?utf-8?B?dEFiajYrOERzcFBCeWdBOVZpeW9qZGxqb0dtUnF0MmZqaDRxZVhxb2RMZXBy?=
 =?utf-8?B?OE1nT3ZMMk8xNEdvWHg2dXZZZUVkQXQvVVIvYVRGSzVwZXFLNzlPeWdhUHFK?=
 =?utf-8?B?STA0ckZMM0RVQkVrazZzeUNFMWQ5Zkx3MWZmdjg5SGxuSWs3MGIzY3htTlEz?=
 =?utf-8?B?MnNIZkpGY2N3RjVkQXA0T1FuSmQ2UXI2a0xkSngvQVpMNFR1bzFkYk1kTHFm?=
 =?utf-8?B?akxYY2I0ZHdWanZKaWp2eDhRVVBHNVQwSk5xUUhMN04zS3hyeHhaMTQxS1Ft?=
 =?utf-8?B?VElPMllWa1NrVUFuQ1JXMGlNaUNoWWxJU3lZdnVnM2U3Si8rVW5VQWtwcFVB?=
 =?utf-8?B?bE84aW5VKzJQQkxXbnhuK3djMFo2YklqNW5XTmd0Y3hwME8yanhPYk5LT2pn?=
 =?utf-8?B?bnFaTzhJMm1JWFJNZitGUmo5Y2dVTFUvZHUzSnBsVENlTnhSelZkLzJkRjNm?=
 =?utf-8?B?WndJVzMwYlFRRElXK2REamFGQmdYRldzQWpuNHhTRi83d2Z1YnB6d0VISjRR?=
 =?utf-8?B?Q1NDa2ZHOHRzQ2QvSUV6ajB1MlBidWR3STZ0WnE3L2lWN0hTaU5oTXZLV3ZS?=
 =?utf-8?B?bVRDZW9uN1NKdFBaQUEzUEwreGRtOUQ0V0h2aGtKVjkzUm5FVVFJV0pkSkU1?=
 =?utf-8?Q?fCbRgmwCO+PtsIB5KX0VIBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adb6eaf-6456-4b4c-ad22-08d9b884738b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:48:46.2009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfexr67ll45JxnEE3cubouWrFIEucRxXGT5dVkkzCTANcQD+O2XuC8vbdHGmzgbe6r3nIa4cUy/GuqMdCsO96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KQSB0eXBvLg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBZdSwgTGFuZw0KPlNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgNiwgMjAyMSAyOjQ3IFBNDQo+VG86
IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIdWFuZywgUmF5DQo+PFJheS5IdWFuZ0BhbWQuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFU
Q0ggMi8yXSBkcm0vYW1kZ3B1OiBhbGxvdyBBUFUgdG8gc2VuZCBwb3dlciBnYXRlIG1lc3NhZ2UN
Cj53aGVuIGRwbSBpcyBkaXNhYmxlZA0KPg0KPltQdWJsaWNdDQo+DQo+DQo+DQo+Pi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+DQo+PlNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgNiwgMjAyMSAxMTo0MSBBTQ0KPj5UbzogWXUs
IExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
PkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFu
ZywgUmF5DQo+PjxSYXkuSHVhbmdAYW1kLmNvbT4NCj4+U3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IGRybS9hbWRncHU6IGFsbG93IEFQVSB0byBzZW5kIHBvd2VyIGdhdGUNCj4+bWVzc2FnZSB3aGVu
IGRwbSBpcyBkaXNhYmxlZA0KPj4NCj4+DQo+Pg0KPj5PbiAxMi82LzIwMjEgODoxOSBBTSwgWXUs
IExhbmcgd3JvdGU6DQo+Pj4gW1B1YmxpY10NCj4+Pg0KPj4+DQo+Pj4NCj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1k
LmNvbT4NCj4+Pj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAzLCAyMDIxIDU6NTIgUE0NCj4+Pj4g
VG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPj4+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgSHVhbmcsIFJheQ0KPj4+PiA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+Pj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBhbGxvdyBBUFUgdG8gc2VuZCBwb3dlciBnYXRl
DQo+Pj4+IG1lc3NhZ2Ugd2hlbiBkcG0gaXMgZGlzYWJsZWQNCj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+
Pj4gT24gMTIvMy8yMDIxIDEyOjI0IFBNLCBMYW5nIFl1IHdyb3RlOg0KPj4+Pj4gVGhlIGdlbmVy
YWwgaHcgZmluaSBzZXF1ZW5jZSBpcyBTTVUtPiAuLi4gLT5TRE1BLT4gLi4uDQo+Pj4+PiBXZSBu
ZWVkIHRvIHNlbmQgcG93ZXIgZ2F0ZSBtZXNzYWdlIHRvIHBvd2VyIG9mZiBTRE1BKGluIFNETUEN
Cj4+Pj4+IGh3X2ZpbmkoKSkgYWZlciBkcG0gaXMgZGlzYWJsZWQoaW4gU01VIGh3X2ZpbmkoKSku
IEFsbG93IHRoYXQgZm9yIEFQVS4NCj4+Pj4NCj4+Pj4gVGhpcyBtZXNzYWdlIGlzIG5vdCByaWdo
dC4gSW4gQVBVcyB0aGVyZSBpcyBubyBtZXNzYWdlIHByb3ZpZGVkIGJ5DQo+Pj4+IEZXIHRvIGVu
YWJsZS9kaXNhYmxlIERQTSwgaXQgaXMgZG9uZSBpbiBCSU9TLiBSZXBocmFzZSB0byBzb21ldGhp
bmcNCj4+Pj4gbGlrZSBhZnRlciBzbXUgaHdfZmluaSBpcyBjb21wbGV0ZWQuDQo+Pj4NCj4+PiBJ
dCBpcyBwb3dlciBvbi9vZmYgU0RNQSBtZXNzYWdlLiBOb3QgZW5hYmxlL2Rpc2FibGUgRFBNLg0K
Pj4+DQo+PkJhZCBjaG9pY2Ugb2Ygd29yZCA6KSBJIGRpZG4ndCBtZWFuIEZXIG1lc3NhZ2UsIGl0
IHdhcyBhYm91dCB0aGlzIGxpbmUNCj4+aW4gImNvbW1pdCBtZXNzYWdlIiAtICJhZmVyIGRwbSBp
cyBkaXNhYmxlZCIuDQo+DQo+T2suIEkgZ290IGl0Lg0KPg0KPj4NCj4+Pj4+DQo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFtZC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jIHwgMiArLQ0KPj4+Pj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pg0K
Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3Nt
dS5jDQo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+
Pj4+PiBpbmRleCAyZDcxOGMzMGM4ZWIuLjI4NWEyMzdmMzYwNSAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+Pj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPj4+Pj4gQEAgLTI3Nyw3
ICsyNzcsNyBAQCBzdGF0aWMgaW50IHNtdV9kcG1fc2V0X3Bvd2VyX2dhdGUodm9pZCAqaGFuZGxl
LA0KPj4+Pj4gICAgCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gaGFuZGxlOw0KPj4+Pj4gICAg
CWludCByZXQgPSAwOw0KPj4+Pj4NCj4+Pj4+IC0JaWYgKCFzbXUtPnBtX2VuYWJsZWQgfHwgIXNt
dS0+YWRldi0+cG0uZHBtX2VuYWJsZWQpIHsNCj4+Pj4+ICsJaWYgKCFzbXUtPnBtX2VuYWJsZWQg
fHwgKCFzbXUtPmlzX2FwdSAmJg0KPj4+Pj4gKyFzbXUtPmFkZXYtPnBtLmRwbV9lbmFibGVkKSkg
ew0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGlzIGNoZWNrIHdhcyB0aGVyZSBiZWZvcmUgYWxzbywgb25s
eSB0aGUgV0FSTiBpcyBhZGRlZC4gVGhhdCBtZWFucw0KPj4+PiBpdCB3YXMgc2tpcHBpbmcgc2Vu
ZGluZyBtZXNzYWdlcyBpbiBBUFVzIGFsc28gYW5kIHNvIGZhciB0aGlzIHdhcw0KPj4+PiB3b3Jr
aW5nIGZpbmUgKHVudGlsIHRoaXMgZ2V0cyBub3RpY2VkIGJlY2F1c2Ugb2YgdGhlIHdhcm5pbmcp
Lg0KPj4+Pg0KPj4+PiBOb3cgdGhpcyB3b3VsZCB0cnkgdG8gc2VuZCB0aGUgbWVzc2FnZSB0byBB
UFUgd2l0aG91dCBhbnkgY2hlY2suDQo+Pj4+IFRoYXQgZG9lc24ndCBsb29rIGdvb2QuIElkZWFs
IHdheSBzaG91bGQgYmUgdG8gZml4IHRoZSBzZXF1ZW5jZS4NCj4+Pj4gT3RoZXJ3aXNlLCBzdWdn
ZXN0IHRvIGRvIHNvbWV0aGluZyBsaWtlIGJlbG93IGFzIHRoZSBsYXN0IHN0ZXAgb2YNCj4+Pj4g
c211IGh3IGNsZWFudXAgcmF0aGVyIHRoYW4gc2VuZGluZyB0aGUgbWVzc2FnZSBibGluZGx5Lg0K
Pj4+Pg0KPj4+PiAJaWYgKHNtdS0+aXNfYXB1KQ0KPj4+PiAJCXNtdS0+cG0uZHBtX2VuYWJsZWQg
PSBzbXVfaXNfZHBtX3J1bm5pbmcoc211KTsNCj4+Pg0KPj4+IHNtdV9pc19kcG1fcnVubmluZyhz
bXUpIHdpbGwgY2F1c2UgZXJyb3JzIGluIHN1c3BlbmQuDQo+Pj4NCj4+VGhhdCBpcyBpbnRlcmVz
dGluZy4gV2hhdCBpcyB0aGUgZXJyb3IgeW91IGdldD8NCj4NCj5bZHJtOmFtZGdwdV9kcG1fZW5h
YmxlX3V2ZCBbYW1kZ3B1XV0gKkVSUk9SKiBEcG0gZW5hYmxlIHV2ZCBmYWlsZWQsIHJldCA9DQo+
LTk1IFRoYXQgbWVhbnMgRU9QTk9UU1VQUC4NCj4NCj5BY3R1YWxseSwgaW4gcmVzdW1lIHByb2Nl
c3MsIGJ1dCBhZGV2LT5pbl9zdXNwZW5kICBpcyBzdGlsbCB0cnVlLg0KPkZvciBSZW5vaXIgc2Vy
aWVzIEFQVSwgc211X2lzX2RwbV9ydW5uaW5nIGlzIGhhcmRjb2RlZCBhcyBmb2xsb3dpbmcsDQo+
DQo+c3RhdGljIGJvb2wgcmVub2lyX2lzX2RwbV9ydW5uaW5nKHN0cnVjdCBzbXVfY29udGV4dCAq
c211KSB7DQo+CXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KPg0KPgkv
Kg0KPgkgKiBVbnRpbCBub3csIHRoZSBwbWZ3IGhhc24ndCBleHBvcnRlZCB0aGUgaW50ZXJmYWNl
IG9mIFNNVQ0KPgkgKiBmZWF0dXJlIG1hc2sgdG8gQVBVIFNLVSBzbyBqdXN0IGZvcmNlIG9uIGFs
bCB0aGUgZmVhdHVyZQ0KPgkgKiBhdCBlYXJseSBpbml0aWFsIHN0YWdlLg0KPgkgKi8NCj4JaWYg
KGFkZXYtPmluX3N1c3BlbmQpDQo+CQlyZXR1cm4gZmFsc2U7DQo+CWVsc2UNCj4JCXJldHVybiB0
cnVlOw0KPg0KPn0NCj4NCj5TbyB3ZSBnb3Qgc3VjaCBhbiBlcnJvci4NCj4NCj5SZWdhcmRzLA0K
PkxhbmcNCj4NCj4+VGhhbmtzLA0KPj5MaWpvDQo+Pg0KPj4+IEhlcmUgd2UganVzdCAgc2VuZCBz
b21lIElQIHBvd2VyIG9uL29mZiBtZXNzYWdlcy4NCj4+PiBJcyBpdCBuZWNlc3NhcnkgdG8gZW5h
YmxlIERQTSB0byBzZW5kIHN1Y2ggbWVzc2FnZXM/DQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IExh
bmcNCj4+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+IExpam8NCj4+Pj4NCj4+Pj4+ICAgIAkJZGV2X1dB
Uk4oc211LT5hZGV2LT5kZXYsDQo+Pj4+PiAgICAJCQkgIlNNVSB1bmluaXRpYWxpemVkIGJ1dCBw
b3dlciAlcyByZXF1ZXN0ZWQgZm9yICV1IVxuIiwNCj4+Pj4+ICAgIAkJCSBnYXRlID8gImdhdGUi
IDogInVuZ2F0ZSIsIGJsb2NrX3R5cGUpOw0KPj4+Pj4NCg==
