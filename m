Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED72C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C80B10E1D1;
	Mon,  3 Jun 2024 08:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yl19zsUa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1969E10E1D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpGASmV26kjXyh9gN0yvKNwhgGFMzKEWWS8/OhFiyqCJF4LkspWkaYEuMdQ1AjPVFGL3tuK1q1XBf5KlFcdAO+og4lJSxeSVyKYMkIZz+A7MBv1OTxGx98xfGDluk4vfQSIF/L8avBeqpk6mmuf9OCUuYdg3WXQ3I0TnPpdgmb/9vramIS84sRkujelJiK5wYY1G+Qan+8POP+PnQ7zYgnO3mgwWej/o8Hb+iMjYSvjXw6HmmR8kIl66M0ujPmG+f1YS5BKfBlBue71TKUbeUqhegG+1cqXENOHiel2cdOq3F5AxMvFMKDJ7lNbVb1Vwy8hRC848ndRMLmYuJhJ1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIarKZt7QYKWyu+yi1GsDqV8aVMeWPXqRB3sne/JetQ=;
 b=BqzW+Pagh14kYQUGeLsnA/nGSwmQP4jEJVtP/XMsxwAhRG05lmDAuVq8Htdh0d1D/HXD6F5dALXdSpe0AdtQrlX5NP2Et206M+w9IP/9i+MsZ3P33piHO1KN0SCU7roUfjyS6JKKotCXBlMdVonai4kyb0Lj18wdWHQzhsxE9CijKfDhv1OfLc+g+JVpGb6e0RSClbvMt9SeqZIcvz1Ts65JitNemqp5zkTIIEDXKm2rKqQzqO3tIalIEjMcAlFN+knLVSSgLJiqrOnU6igwMdmjP/BeN82/+oc9NoXRnC/AofimE1pyeW/PVm3uZlv5jNUtZQRRwqlxhD0NAORVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIarKZt7QYKWyu+yi1GsDqV8aVMeWPXqRB3sne/JetQ=;
 b=Yl19zsUaB2ePM89xa2xRcej9ko5Ib8sxdvp2f4BxpVyBtIY0035NkSVVmsQFJdukkeHJyN6OrK3l0+GAYBxsEQpm4QjRFKgvaiPxpzW8OPTPLgsDtaOaOW1dkI5950XCG2BVb5BqH+1cJjONOzTG+RtNTYPOCs1PU/Mlgz+71nc=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 08:53:16 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 08:53:16 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
Thread-Topic: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
Thread-Index: AQHatXszvdNW9bsNjUaleNKtw9bdv7G1rB0AgAAO8KA=
Date: Mon, 3 Jun 2024 08:53:16 +0000
Message-ID: <CO6PR12MB5394B8D4CCD80B551FFE43EA94FF2@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240603055925.353172-1-bob.zhou@amd.com>
 <643687ee-4f93-4448-8d09-c841e1ce2746@amd.com>
In-Reply-To: <643687ee-4f93-4448-8d09-c841e1ce2746@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=34f046f5-d9eb-4e1c-b4f8-e33cb9efb290;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T08:49:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|DS0PR12MB9445:EE_
x-ms-office365-filtering-correlation-id: ac00e3e8-1cc7-42a9-30ef-08dc83aa9c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VE5FS3k1R0wreFdsVzFYVWM2MjQzK2gvemRsZUtHNVVISWh4WlZJNXJPNFhU?=
 =?utf-8?B?SGRGT0R3VUVHU2Z1MFNwemg3WjgvZEJRNVgyUXVwYndJMk90eUF4V29CdnB5?=
 =?utf-8?B?RmJ1QXY1VldZVHA5OXNnVlJKT0p5MmVkMkZhM3A3RkFYY2I4QkUwclJUb09F?=
 =?utf-8?B?OU93QTFGZHdXRE8xYnY1b3JjcVBFN2dIc0lEWkRUZm9zMjNaZGJEcTJLcWRx?=
 =?utf-8?B?VVNLM1gvL3gzNWxhZnc2WmNtbTF5dUljaVFNTEVSYUwzdk5rOUJVOEtiSXlx?=
 =?utf-8?B?NE4wUU9VMDVBVGl4WVh2VmlQelpCVHBmSzJabVRRSVdvTHdHOWxHaER3c25M?=
 =?utf-8?B?N3RjRkk3RGc3WVFYdXpiUzUzcFZCeFN3dVo0Nmk2M0w1STRDU0NFMk9NNGNW?=
 =?utf-8?B?N1JSVEVPTEY5cmhISUdVcm1laGtBdGJGT2Z0d3lrOHA4eDNjY3d4MWNSUHE4?=
 =?utf-8?B?cml2RlF5NDh3ZlBCbERyaGNzbDZLVkxXQ0VUSG1uLy81WHI0RUd0dU5aa3h4?=
 =?utf-8?B?UEVzbXpva3JKbGg1dlFQam1yY0J6YzZuMnJyK0QxNDBmRzZ5OWttNkdrS0NY?=
 =?utf-8?B?eEdyY0JZOVR2bmlmN3E1NW9KTTdWNjU4UGtMZENDbGxKazVKWWRWZmw1SGoy?=
 =?utf-8?B?QXhuVm5HcEdnMXdDOUdkQXF4aEZaVzRRS1ZZVUZBVHZLZjJrVWZMUkNiQVFC?=
 =?utf-8?B?R0pCL2dnYlhzeHNTbCtSKzNKTXdPbTcwN1ZneGdqa2pXSnB0VEZIWXcxa0F6?=
 =?utf-8?B?VkFIcXNyYlJxTzBVaWZmWjliM3VIcW5lSzhHdThVRUttVFJKRnR3aXNqODVY?=
 =?utf-8?B?cENwSGdtb1ZCM1JNMStmYkEyZjlDUjdSL0RPNWd1RjZPMEZKNHdPYWx6cnc5?=
 =?utf-8?B?L0Z6cTlqZFBOVGFsRFBDM1VEZGUzSjA3d3FBalE3bGllbUgrQXNqam1CUWRk?=
 =?utf-8?B?ZXFLMGdvNit3K2VoWExHdXJkSnZKUjhUUFhkSStvck56bk5PSjEvM2NVSEg4?=
 =?utf-8?B?QkxjcVBnRjdEN21PRkRyV2ozRk9Wc0xOOW5JTFBPRXVqNGpUNk9VNlY5YTdT?=
 =?utf-8?B?Nk9jMjRMR2xhYkhZNVRrZzFscSt3TENodmlxY1NJSHJwM0hBUzNNNWlwTWg2?=
 =?utf-8?B?MjNyT3RFaWpjb0phYzdObGZFakcyWHNZSklDcGw0NHNqcnhlcm5tQ1l3SlFi?=
 =?utf-8?B?N0l1QThad21YckcwWVU3ZDlkV3NkMWk1dUxGZ0pweTZZYy8wZ1Y1TFhRVWZX?=
 =?utf-8?B?dEV6Ky9ENEk2RnFKOFFkNGt1clhOdnFJZ1p0Mkt1L2NtNFRrWjN4Zk9lQmM1?=
 =?utf-8?B?dnBIV3FwSmFLb21BOUhkVmZjQ0l2dGhWbmNjSHlnN20ya3lPMVgvNFZmUDVR?=
 =?utf-8?B?TU1qemxadEZFT1piZXU1anRzVFAvSnNwQXg4cVdmRlp0STYwRWlFMy9oWVQ1?=
 =?utf-8?B?aHh3WVZXNUM1aXZwMXYvam1uM0p5TmhWZk9WYnEvYWlWN0ZOS2g0Qk81TjAv?=
 =?utf-8?B?eFB1Z2ZQaElBNkxVUGJoMWpvQXR1VndwNWppdUdFWVZPYnpQNGhkTllHWVpF?=
 =?utf-8?B?T0NQSGNVaFJTQkJVNGVTZ2Z5Y3JSWnRyOUQ0cElQcm9sMElIQVhRTXJBTWtH?=
 =?utf-8?B?QVk4ZXBpT0dzZHJrdTNvSXdzNFloSXhLUklTaFBFMERZSi9EUDlscDZ3cGxU?=
 =?utf-8?B?N3F2dHhHTzc4a0hITXNaSFVWQzdaNS9RNXRhTG5oQksvZGE3YkJXbUNIN3B1?=
 =?utf-8?B?c1lUenBUOTVnM1AwRVFqck1iOHQ5dUl2TTIwQ1dBc2xGek9KaWljaktsVWl2?=
 =?utf-8?B?WituVWlrbTI5SGNOSmFUdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEo3YUhMUVYwWVBYNjlxc21qeThtRzZ6dllOR1dXSFcxK29lOWQ2VU9ackZ5?=
 =?utf-8?B?eVU0ZEI3emV4djJFelBUOXdra3l0TnRJcDNubHlDcUFEWmxEMTVENk1KS1JR?=
 =?utf-8?B?U3dONGQxNllLcEZQK1BvTW9HbE9SbUdNd09EWXJ5KzBESWlyaFA5NDF6U01l?=
 =?utf-8?B?Zk5qQ1VFTnIzNFp4RHZkN3IwWWlmM2dtVGdrLzhZUy9hMHl6eVE2WTF0NWZF?=
 =?utf-8?B?QmtnajF3V0QvWXNaMDM0OCszM3Jsb1I5THRMTkE1OEdTWXRaTWU4Qi9DUE1I?=
 =?utf-8?B?QzFiTi95Nk9XU1RXYnhsdDZpSU9IZGFQZ1FhekxUVWdnNWpLbnhtR1liTU5i?=
 =?utf-8?B?WW1XQmRBMzBHdk8wNGRhd1ZQQS9oeXl1eDQ4cGZUUDRZcU1mUHd5Wm0xV3Vx?=
 =?utf-8?B?VTBSTUxCL0ZjMHhmSXlRb0t4dVMycS8xcjdQVGZFNnMvODdkMFFtTEVDT1l6?=
 =?utf-8?B?ekRrZjRZc3BhbUlPazdGZ0VXejFVejBMYUx4aDU2aU8yVnhvbUxEN0w2eUln?=
 =?utf-8?B?eStrQzZDa0xDcENHRjZhSUpMVUthUWgzVWVFalFKdVNxV3BtZk1YMlFrSStL?=
 =?utf-8?B?S3VWUHdBbG4rUHRuSmt0TlJzc3ZyOEJDYTUyMklydENNU3BsTkZoYWorajFC?=
 =?utf-8?B?ZExCOXVQdm9oSEI0cWxYOU1uOFZRYUpraC8zd3pCME8vQTZWQUxwZXhkdlVI?=
 =?utf-8?B?cDVCNExDNkhMaC82MDJvUXRSTTlCN3FLbVFtZTUvNEhvZ0xkYVNUZFZaeWFX?=
 =?utf-8?B?b1AvRXpJRjUyVEQ5L1lDclcyQmpPRjE4R0JCMGJ3emtVZ1RUZG9zV1FhVlRO?=
 =?utf-8?B?ZmhGekQxSlA0R3JEVTlBYzJ2YUcwMG4rbEJLaTAxejd3QVUrcFBTYWIxVkl0?=
 =?utf-8?B?aWxFQmZQODY4aHRSMWgvNHhObExXckJ4QzhLY215WWNTVGpLVEtIS0VmUU93?=
 =?utf-8?B?R1VkTlRHTHhJTlpWREtuenRVNDdKRHJqeWxpQ1g1SWdFZ2IzUS9wUXlaTUQx?=
 =?utf-8?B?S2xJZFFuTC80ZXhzMXY3MUY3TDd1UkV1RmorNC9YaTFFVStNejk3OW5UWEdH?=
 =?utf-8?B?TlFyNzVGTEphVm93bzE5L09XdnJQNDQvZ3JLaGR5QXVBT2tWam02aXBLZFBT?=
 =?utf-8?B?d0JOVTJZWE5Gbmd6dllCayt1N2FaMUFQSTBsd1VxS29qa1UwSVMyTkc5dElk?=
 =?utf-8?B?YVdKQWkvbGlXQ2lLaUNBUXk2RWNLQzI5VnJhT0RjUnA5cmlRVGF5OFNFM21u?=
 =?utf-8?B?clhXKys4YUFUS1MrN2MzcHZGY2Qrak52U1QySHRIZDZPOEJsdG81WDcxZU5p?=
 =?utf-8?B?Sys5MnNWb0Y2VkduSEJsN0FMZFd6Ty94RTdQWUFCZEZORXVtaVQ0VTQxMVJV?=
 =?utf-8?B?M1Y0S096U3NXZlE1UHYxbHEzV2w0ck10QnpST0FSNVVjdkpvR3hzS09PbE11?=
 =?utf-8?B?VFY3UGlwamxKbU9TUGNSTE1reG9iTEtnZlA3MkMzZ1Y3T2hjM2tENC9KTUI4?=
 =?utf-8?B?MVZ3NWl4Z3ZTYkc4NlZvdGoyK0VjUk44Vzd0REtPdGpHTTlmL0RMYWJ6TmdZ?=
 =?utf-8?B?c0MvMVcyaDlWK1FlWnZQZzhTK1drTG16TVNXWU1ITzloN2JIOHgxU3MzTUxT?=
 =?utf-8?B?cFFCK1Ird01Hbm9TWDhnZnJjWVdFTUFkUjVqYW12a2JiclZFbURYQzhBb3ZN?=
 =?utf-8?B?SU1rRCtNZFFEY2pFcU02SzdoUlplcDBLYjhzQ09YVEpPbHFZd0xlVGlxMWZH?=
 =?utf-8?B?cEl3OHFWdU9EWjFmK2lHTWhTcUo3YjZ5cDhBZW1nNHN3Nzcyemo4OVRrRWlz?=
 =?utf-8?B?aHJhL0RFY1I0L1VQSXNiTSttRVgxdmxPc29VR2hSRW5JZ2IwZktYUXBzYlI1?=
 =?utf-8?B?TGVFVXlDMDNDTmdEUzhLejIzK1JjMHZlY1JITXliQzNRamtZSHZ3Z05HaHhW?=
 =?utf-8?B?SFdycW9CODFpYzRhSlR4WmtQNHA4U3BReHJ3Z0M5RTVzM0puU1JYbm1QaFJs?=
 =?utf-8?B?RUY1N3FnZkhhREFsVFhad0NxUWhMM2laMi9ObW9obUpPbUtFSUtyRGtuMHl4?=
 =?utf-8?B?ZWNBWENrTHpTMXVSSHJ1WnNmOG5vTnJhR0NiRENWbVo3b1ZybGRLclZtdXJu?=
 =?utf-8?Q?uLPE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac00e3e8-1cc7-42a9-30ef-08dc83aa9c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 08:53:16.6294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LSsJ8HbAMqsHkrWE9k7EFg9teXEus5lH8zS4NbRyLyz/54f2kubFwTP02mOIRZtGVPponbX0TsiYpKkjQuPtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQ2hyaXN0aWFuLA0KDQpJdCBmaXhlcyBhIHBvdGVudGlhbCBPdmVyZmxvd2VkIGNvbnN0
YW50IChJTlRFR0VSX09WRVJGTE9XKSB3YXJuaW5nIHJlcG9ydGVkIGJ5IENvdmVyaXR5Lg0KDQpS
ZWdhcmRzLA0KQm9iDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogMjAyNOW5tDbmnIgz
5pelIDE1OjU2DQpUbzogWmhvdSwgQm9iIDxCb2IuWmhvdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPjsgWmhhbmcs
IEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogcmVwbGFjZSBpbnQgd2l0aCB1bnNpZ25lZCBpbnQgZm9yIGltdV92MTJfMC5jDQoNCkFt
IDAzLjA2LjI0IHVtIDA3OjU5IHNjaHJpZWIgQm9iIFpob3U6DQo+IFRoZSByZXR1cm4gdmFsdWUg
b2YgUlJFRzMyX1NPQzE1IGlzIHVuc2lnbmVkIGludCwgc28gbW9kaWZ5IHZhcmlhYmxlIHRvIHVu
c2lnbmVkLg0KDQpBbmQgd2h5IGlzIHRoYXQgYW4gaW1wcm92ZW1lbnQ/DQoNClJlZ2FyZHMsDQpD
aHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogQm9iIFpob3UgPGJvYi56aG91QGFtZC5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ltdV92MTJfMC5jIHwg
NiArKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3Yx
Ml8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pbXVfdjEyXzAuYw0KPiBpbmRl
eCAwYzhlZjkwOGQxMTIuLjJkNmY3NTQ5YzJhZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvaW11X3YxMl8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvaW11X3YxMl8wLmMNCj4gQEAgLTExOSw3ICsxMTksNyBAQCBzdGF0aWMgaW50IGltdV92
MTJfMF9sb2FkX21pY3JvY29kZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4NCj4g
ICBzdGF0aWMgaW50IGltdV92MTJfMF93YWl0X2Zvcl9yZXNldF9zdGF0dXMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiAtICAgICBpbnQgaSwgaW11X3JlZ192YWwgPSAwOw0K
PiArICAgICB1bnNpZ25lZCBpbnQgaSwgaW11X3JlZ192YWwgPSAwOw0KPg0KPiAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsNCj4gICAgICAgICAgICAgICBp
bXVfcmVnX3ZhbCA9IFJSRUczMl9TT0MxNShHQywgMCwgcmVnR0ZYX0lNVV9HRlhfUkVTRVRfQ1RS
TCk7IEBADQo+IC0xMzgsNyArMTM4LDcgQEAgc3RhdGljIGludCBpbXVfdjEyXzBfd2FpdF9mb3Jf
cmVzZXRfc3RhdHVzKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPg0KPiAgIHN0YXRp
YyB2b2lkIGltdV92MTJfMF9zZXR1cChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICB7
DQo+IC0gICAgIGludCBpbXVfcmVnX3ZhbDsNCj4gKyAgICAgdW5zaWduZWQgaW50IGltdV9yZWdf
dmFsOw0KPg0KPiAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0dGWF9JTVVfQzJQTVNHX0FD
Q0VTU19DVFJMMCwgMHhmZmZmZmYpOw0KPiAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0dG
WF9JTVVfQzJQTVNHX0FDQ0VTU19DVFJMMSwgMHhmZmZmKTsgQEANCj4gLTE1Nyw3ICsxNTcsNyBA
QCBzdGF0aWMgdm9pZCBpbXVfdjEyXzBfc2V0dXAoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFk
ZXYpDQo+DQo+ICAgc3RhdGljIGludCBpbXVfdjEyXzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+ICAgew0KPiAtICAgICBpbnQgaW11X3JlZ192YWw7DQo+ICsgICAgIHVuc2ln
bmVkIGludCBpbXVfcmVnX3ZhbDsNCj4NCj4gICAgICAgaW11X3JlZ192YWwgPSBSUkVHMzJfU09D
MTUoR0MsIDAsIHJlZ0dGWF9JTVVfQ09SRV9DVFJMKTsNCj4gICAgICAgaW11X3JlZ192YWwgJj0g
MHhmZmZmZmZmZTsNCg0K
