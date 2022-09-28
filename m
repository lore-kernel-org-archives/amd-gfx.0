Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D603C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 18:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AB810E56C;
	Wed, 28 Sep 2022 18:11:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB6210E551
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 18:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbXRlELkZYE9z2F5Z6Zr30VixsdDzvtQECjYbMSNx3xDTLld5qM7ghqDANA8jtqF1Ud7LsfqCayNnGr6TA6SxqF0kKKXmvWV8lOh2N4i8UY/k+etwqDWZ4aG89dnPcZ77Nu8JrKNdKNXKUfEyLXQ8xQqQUYKVTuXyD7/ka7eRKMkDa0pdi+RVSYSAzugGpE/3n9CYmZ1E6FuM7w47MERhUhbiffAsN0l5/kQGmkal9r107S4+kWOpoVFGDdNae8+QYaq2yQq4HmGbDnWbCwjeSYOyXPQ2DcpKSEq+qIx+lW0SWn8Gz9kSjtLHxgYU6HgJ9kwFP6t+cKiQpbDp/dyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z9IDoTlHw9zRpr83g6gOAe70Ez0SYVF7LTqZOFHIuE=;
 b=lmn76O6tWB3NWBu845trhG1x7IeHbKoEEuieBcb6xyoUtnqXa4r1lcu5pSfU/zROKn/cRn/WLE3FFdvv6pPxZnadkMSSXBV88qQ5fJJzmr3ZN9cfkvUTwi30cX3BdV8qkdOOcgt3seDbR56zsW25/x1vskfJv4goOPh1yIxDO2t9W45l6rlsZe2Qda3UuxKRJMtYpHWq+oYGC5SDIe0zqDAQ+r4TTQYdQGffBSOmByxFJkNUapoX/WOyGL9dMGGu1OAQaMD3/2S1YeLcsRAhMUkd7RHxJNlQN/4Cv6kztv7KB+s0siWpwahnorxyhXiH2cWyZa8wZAXMqEcjxXi0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z9IDoTlHw9zRpr83g6gOAe70Ez0SYVF7LTqZOFHIuE=;
 b=B9AwvAHY3aToooVGrYU7415jhDkgA2N2kBbiReTvrnS5mjMGP6w6nyX6kB8Bl7WzV9sVLo+qL8bRo/yQtG+cbpfVp6mwSmsMBDN3TPAvW7hL4mQtiM20VgxGG7GXTCOLQhvWhrlbR43yRKF4UEypVXUSW1lTBjOu00z5iVlPWfg=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 18:11:20 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::a434:1300:f059:70f]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::a434:1300:f059:70f%4]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 18:11:20 +0000
From: "Chander, Vignesh" <Vignesh.Chander@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Thread-Topic: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Thread-Index: AQHY02HKP/dIIEIz80SuY/DE8zWLUa31HW0AgAAGMWA=
Date: Wed, 28 Sep 2022 18:11:20 +0000
Message-ID: <DM4PR12MB50555014BD3BF52EE18DD083EC549@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20220928174321.13409-1-Vignesh.Chander@amd.com>
 <23d82ef8-a3b2-0cda-479e-9ff2588fd0dc@gmail.com>
In-Reply-To: <23d82ef8-a3b2-0cda-479e-9ff2588fd0dc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T18:11:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=404a8c7f-043e-46a5-b3cb-37b4ebbaf144;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-28T18:11:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3eebb58d-ef5b-43ab-bf2f-85ecacff7eb7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|DM4PR12MB6446:EE_
x-ms-office365-filtering-correlation-id: 85a0d09b-17ee-42fa-0bcf-08daa17cd899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUNkF+eZ0A/96FXYtMUq4aXFkoATeI20YCqNXkDPch17qyPt9qXpQEfMMJ/zzHiHIqyhCIMOhPhCtukCYE4ibG7ooFD1DAjaRvMK/1S34bqOaF3YX2+OKoLpKXPVPB1+Be0RM4HI0IddMxAFGwQoW2CiDevnp2y/EYSPs6QDDx3FfDiAQMcNeQpCAuWCX1AsqJY3pqleMHERZJKN0xfwP260+e69sK/Lf8UTrnpSIs/y+dLEWKIHdMbxbxObNwchHLbgxPmWe2OwtyLT5Rmu1FuP4u1d72jv4W2+WHcSokaVIlq9TmJASC6e/HU0Kol/NZ5JiY/ii7VYGExMkjizC/ziO3vNB21tMGXBkSxVrnbyIL/79gflgenP3ewEPH3aSclgAfbixO4j4it9jOvQOBYbWRRbPCfgxcTegxgzd5uXJaW/ljGOHnmYj/n9lUyIEvoI4PV3dB0XzmSCdn52L2OxJjTZLbxk4gXRqz+ahE89qDkS6/FmwMcDVkyS9UCyJ0QmJgBh9ejnJ7uZ+8qfIw6xQf5jrth44TPKljs0yHJ64eqG05Ep2WS+I0F0MIyL4hTEkMuIbWObk9+PkbngFYampoNfby7ETV09X1HSmW+fai8n6KxQ5D4ZvrgOUhd+czAJVZTlLpLM2Oamt89mg4CiqdKRDhUqlKtdovXSQ0xk3enlgQrCn2ZdD/SUSK0+eAyPRyUmtTtxbw5E32a8YI5ctPD+BTehV6+WRhyYTp8mlnDFx4UA0a93tdnE6Kt7aD2Pbi5MuGPmnccHFtOa7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(5660300002)(8676002)(33656002)(2906002)(26005)(4326008)(9686003)(52536014)(41300700001)(53546011)(8936002)(6506007)(66446008)(66946007)(64756008)(76116006)(66556008)(66476007)(38070700005)(86362001)(122000001)(38100700002)(83380400001)(66574015)(186003)(7696005)(55016003)(110136005)(71200400001)(316002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dExIaFVaVVBDc29xU25kQ3QyZ1JSam5IZXZuTm5IWnZrcTJpNlp6Q2R2bmlP?=
 =?utf-8?B?MDJlZWxnNFRzK1ZsTWx3dUo5ZlNHSFR6NjNGMTJxNEtiRHk4RW94SDJ2Z2w5?=
 =?utf-8?B?d3VHR1R5SHZtU29KaThxcCsvMURHREw2aEZ1YlVhcE5PVnFmL3VFS3NtT3Fo?=
 =?utf-8?B?bFozRHdtZWVLMXJOa2UweUQ1aVB5Tml5eDhmS0tQY1JTMTFPUzdWNXlMUytP?=
 =?utf-8?B?Q2lQTG4xYnZSbm92S3cvcmhscXFYOWhaeC9Bc2lYUk1aY2ZDeEF0V0Z6NUM3?=
 =?utf-8?B?Vm9KaldtWEQ1MzFWS1hqRHRBam1RQi9FT1dzZnhwZkZkTVlKODZHUC9VQXFN?=
 =?utf-8?B?RGs0Vi9mV25kZk9Ob0U0aUpGc1k2anlyd0FXSTJtajM1a1ZjQUdJbHk1aWdw?=
 =?utf-8?B?Q2FQVjlhbGlNNnlWeVRlUWpPUW1FTFMrelNicFh5VE5GV1FnYjlaNVp5VCtH?=
 =?utf-8?B?em54NWZ3Y1hQT2hLQW43RGo1YS93WVJ3RlNPWloxS0QzbHpLNlljd3RTanJh?=
 =?utf-8?B?U2laZDc0ZG5UNXVEcmVjYnRxL3RUYWxVNTBybzR2UkROQmR6THdtZExERTlU?=
 =?utf-8?B?NmRrT3RJcm9kaXN2cXVsSHE5OTlyNStOM2xZQTY1SHZSZ2RRVU5HTlhzbWJ2?=
 =?utf-8?B?NExQTmRJTVdEekFjK2grU0dyWTdRUDl1eE5EQ09MRC9VbStvYVFHWlNFNFEy?=
 =?utf-8?B?eXdCNmN5TXBNMGlocnBjLytiTHErZGNhelcySHFlZUgrbzBLOCtvZVJUSVdY?=
 =?utf-8?B?cnBCMW1zenNuN1dncXVkY0NBSzAvSzF6WHVoTmJUd3lvemdNd2dsU3oxY3FV?=
 =?utf-8?B?aURnZVNycFl5bS9YczFxaDdCMll5TFM0RGhoM000SGYrZkNIN1NpelUraFVQ?=
 =?utf-8?B?Z0lKbGUvVFFucDczY3NEVnRDNGVKVG0yNDIzbEREM3h4enZhTEpVMzJyclNU?=
 =?utf-8?B?U01mYzJQNkdEVjJjK3pUYWdmOGNBSVVFWGNWS0FDUTJUQ1hWeTBBOFpmOXNN?=
 =?utf-8?B?UHV5VWIyTWl5RFJ4RVlhdW1NaUtPai96aEYrREIyZDJuc0s3WDZ4MTVJSWFj?=
 =?utf-8?B?TnEzOUhtV0pIY1B4TGo1MDBZZVJDUFVlckwraWpFZjMvZjZyMVdQUHBlRVRK?=
 =?utf-8?B?enZaNllGcTh2VUdxWE1WYnZCaXp3MjZ6TWRNRXlmamZiMUlaZW56YmFjRnJJ?=
 =?utf-8?B?RHNWRGhvV3VwVXhTbDRndjZaOWFSY05XK3l1a0VpaVJiTXl2UTRPeHhjNXYv?=
 =?utf-8?B?SlV2UHpjSGdyUGg1MjhkR3ltdEJNL3padFdmU1JzVkQvcTN4S1YrWWF2ZmFx?=
 =?utf-8?B?Zzc4dmVwem1xczFPcTBBVzRhenZDcjh2YnpWazdNT2crVVZSME91VEc2Q1pQ?=
 =?utf-8?B?Tm42cVRubmRoR09Wb2RwMFBGQ1VpK2s0MWVqZHVYQ09JcktRZWVDL1ZCd1Va?=
 =?utf-8?B?bkN0ZER2OGVUSE90aWprYis4bUtHKy9zSkxNMGp5YWVQSDIrYUpSMW1NaWd3?=
 =?utf-8?B?elVKNHFrZ2Zia3FrWmFmSE9WVytwSGFNWlppaytRcXVYd09nMFdKcnN3NllP?=
 =?utf-8?B?MVY5UDQ4OWJjMDVTMnhTeks2VWEvaUIwMVNUQXhjOWNRVmxTUTdtUkxTWlNE?=
 =?utf-8?B?dWs5alI5M0dNWUQ5T01tRXlhZi81ZDJOakVzNmNmK2xPTW1XRnc2NllDZkV4?=
 =?utf-8?B?MGZ3R3pqQkxzc0VUbVBHQzZTTHRjSFd1MGdGWHRHTFVmOVM5dzVwZjcwRG5P?=
 =?utf-8?B?US9MZnQrNnNEYTJVbDg1ZmpXaXdzRmducVc4Zy9neS9CLzFIVmQzQ1F5Ymtu?=
 =?utf-8?B?dUJLVnNDZE41Zjk2QjNXb3ZDZUdRZUlxd1VobXhIYWZLYTZFeTBqYm9ucWtx?=
 =?utf-8?B?dkU3VUtJa2NWa25YeGRyRzhyYlExTlM2ZWRCVmJuYlpnQTdudCtrTE9CZHlo?=
 =?utf-8?B?aFZJOFhLNDdTU2FoY2t3NCtuZThraHc4aDFoYTJUN0ozM3JwS1ZMbFNkQy9D?=
 =?utf-8?B?a2FQZ0F1NUpZRFpOVm1GRVNHMEVUSHFrc0FGV2p5NnoxejlIV2ZzV3pNQnM3?=
 =?utf-8?B?WnliaHVQWnI5NzM0dVBCc0RZMCtjY3dvU2tjaUg5S0JpdVBkQ21uMklxaFFl?=
 =?utf-8?Q?wLCo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a0d09b-17ee-42fa-0bcf-08daa17cd899
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 18:11:20.8115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIIOmtWoIuOWfzIz0P4UM0on543fJqHJtJp6VmNx0ibl9ZwkguONnq5W+HGC7EBVarZzHT9Ar4xT+bAmKX3jUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwgDQoNCkl0
IGlzIGJlY2F1c2UgdGhlIGhvc3QgZHJpdmVyIGhhbmRsZXMgdGhlIHJlc2V0IGZvciB4Z21pIHNy
aW92IGNhc2UuIEkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBib2R5IGFzDQoNCkZvciB4Z21pIHNy
aW92LCB0aGUgcmVzZXQgaXMgaGFuZGxlZCBieSBob3N0IGRyaXZlciBhbmQgaGl2ZS0+cmVzZXRf
ZG9tYWluDQppcyBub3QgaW5pdGlhbGl6ZWQgc28gbmVlZCB0byBjaGVjayBpZiBpdCBleGlzdHMg
YmVmb3JlIGRvaW5nIGEgcHV0Lg0KDQpSZWdhcmRzLCANCg0KVklHTkVTSCBDSEFOREVSIA0KU2Vu
aW9yIFNvZnR3YXJlIERldmVsb3BtZW50IEVuZ2luZWVywqDCoHzCoMKgQU1EDQpTVyBHUFUgVmly
dHVhbGl6YXRpb24NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjEgQ29tbWVyY2UgVmFsbGV5IERyIEUsIE1h
cmtoYW0sIE9OIEwzVCA3WDYsIENhbmFkYQ0KwqDCoA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMjIgMTo0NSBQTQ0KVG86
IENoYW5kZXIsIFZpZ25lc2ggPFZpZ25lc2guQ2hhbmRlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBTa2lwIHB1dF9yZXNldF9kb21haW4g
aWYgaXQgZG9lc250IGV4aXN0DQoNCkFtIDI4LjA5LjIyIHVtIDE5OjQzIHNjaHJpZWIgVmlnbmVz
aCBDaGFuZGVyOg0KPiBGb3Igc3Jpb3YsIHRoZSByZXNldCBkb21haW4gaXMgbm8gbG9uZ2VyIGNy
ZWF0ZWQgc28gbmVlZCB0byBjaGVjayBpZiBpdA0KPiBleGlzdHMgYmVmb3JlIGRvaW5nIGEgcHV0
Lg0KDQpXaHkgaXMgdGhlIHJlc2V0IGRvbWFpbiBubyBsb25nZXIgY3JlYXRlZCBmb3IgU1JJT1Y/
DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gU2lnbmVkLW9mZi1ieTogVmlnbmVzaCBDaGFu
ZGVyIDxWaWduZXNoLkNoYW5kZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV94Z21pLmMNCj4gaW5kZXggNDcxNTllOWEwODg0Li44MGZiNmVmOTI5ZTUgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0KPiBAQCAtMjE3
LDcgKzIxNyw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV94Z21pX2hpdmVfcmVsZWFzZShzdHJ1Y3Qg
a29iamVjdCAqa29iaikNCj4gICAJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUgPSBjb250
YWluZXJfb2YoDQo+ICAgCQlrb2JqLCBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbywga29iaik7DQo+
ICAgDQo+IC0JYW1kZ3B1X3Jlc2V0X3B1dF9yZXNldF9kb21haW4oaGl2ZS0+cmVzZXRfZG9tYWlu
KTsNCj4gKwlpZiAoaGl2ZS0+cmVzZXRfZG9tYWluKQ0KPiArCQlhbWRncHVfcmVzZXRfcHV0X3Jl
c2V0X2RvbWFpbihoaXZlLT5yZXNldF9kb21haW4pOw0KPiAgIAloaXZlLT5yZXNldF9kb21haW4g
PSBOVUxMOw0KPiAgIA0KPiAgIAltdXRleF9kZXN0cm95KCZoaXZlLT5oaXZlX2xvY2spOw0K
